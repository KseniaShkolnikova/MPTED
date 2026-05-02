import logging
import random
import string
from datetime import timedelta

from django.contrib.auth.hashers import check_password, make_password
from django.contrib.auth.models import User
from django.contrib.auth.password_validation import validate_password
from django.core.cache import cache
from django.core.exceptions import ValidationError as DjangoValidationError
from django.db import transaction
from django.utils import timezone
from rest_framework.authtoken.models import Token

from MPTed_base.utils.email_sender import send_password_reset_code_email

from .models import PasswordResetCode


logger = logging.getLogger(__name__)

PASSWORD_RESET_CODE_LENGTH = 6
PASSWORD_RESET_CODE_TTL = timedelta(minutes=10)
PASSWORD_RESET_MAX_REQUESTS_PER_HOUR = 5
PASSWORD_RESET_MAX_ATTEMPTS = 5
PASSWORD_RESET_RATE_LIMIT_WINDOW = 60 * 60
PASSWORD_RESET_GENERIC_RESPONSE = (
    "Если такая почта есть в системе, код восстановления отправлен."
)


class PasswordResetServiceError(Exception):
    def __init__(self, detail):
        self.detail = detail
        super().__init__(str(detail))


def normalize_email(email):
    return (email or "").strip().lower()


def extract_client_ip(request):
    forwarded_for = request.META.get("HTTP_X_FORWARDED_FOR", "")
    if forwarded_for:
        return forwarded_for.split(",")[0].strip() or None
    return request.META.get("REMOTE_ADDR") or None


def generate_reset_code():
    return "".join(random.choices(string.digits, k=PASSWORD_RESET_CODE_LENGTH))


def get_password_reset_user(email):
    normalized_email = normalize_email(email)
    if not normalized_email:
        return None

    return (
        User.objects.select_related("student_profile")
        .filter(
            email__iexact=normalized_email,
            is_active=True,
            is_staff=False,
            is_superuser=False,
            student_profile__isnull=False,
        )
        .first()
    )


def _rate_limit_key(prefix, value):
    return f"password_reset:{prefix}:{value}"


def _register_rate_limited_request(email, request_ip):
    limited = False
    keys = []

    normalized_email = normalize_email(email)
    if normalized_email:
        keys.append(_rate_limit_key("email", normalized_email))
    if request_ip:
        keys.append(_rate_limit_key("ip", request_ip))

    for key in keys:
        current_count = int(cache.get(key) or 0) + 1
        cache.set(key, current_count, PASSWORD_RESET_RATE_LIMIT_WINDOW)
        if current_count > PASSWORD_RESET_MAX_REQUESTS_PER_HOUR:
            limited = True

    return limited


def request_password_reset_code(email, request_ip=None):
    normalized_email = normalize_email(email)
    if not normalized_email:
        return False

    if _register_rate_limited_request(normalized_email, request_ip):
        return False

    user = get_password_reset_user(normalized_email)
    if not user:
        return False

    now = timezone.now()
    code = generate_reset_code()

    with transaction.atomic():
        PasswordResetCode.objects.filter(
            user=user,
            used_at__isnull=True,
        ).update(used_at=now)

        password_reset = PasswordResetCode.objects.create(
            user=user,
            requested_email=normalized_email,
            code_hash=make_password(code),
            expires_at=now + PASSWORD_RESET_CODE_TTL,
            request_ip=request_ip,
        )

        sent = send_password_reset_code_email(
            user_email=user.email,
            recipient_name=user.get_full_name().strip() or user.username,
            code=code,
            expires_in_minutes=int(PASSWORD_RESET_CODE_TTL.total_seconds() // 60),
        )
        if not sent:
            logger.error(
                "Password reset email send failed for user_id=%s",
                user.id,
            )
            password_reset.delete()
            return False

    return True


def _latest_reset_code(user):
    if not user:
        return None

    return PasswordResetCode.objects.filter(user=user).order_by("-created_at").first()


def _error(detail):
    raise PasswordResetServiceError(detail)


def _invalid_code_error():
    return {"code": ["Неверный или истекший код."]}


def _blocked_code_error():
    return {"code": ["Код восстановления заблокирован. Запросите новый."]}


def _expired_code_error():
    return {"code": ["Срок действия кода истек. Запросите новый код."]}


def _unknown_user_error():
    return {"email": ["Пользователь с такой почтой не найден."]}


def _validate_new_password(user, new_password, new_password_confirm=None):
    if new_password_confirm is not None and new_password != new_password_confirm:
        _error({"new_password_confirm": ["Пароли не совпадают."]})

    try:
        validate_password(new_password, user=user)
    except DjangoValidationError as exc:
        _error({"new_password": list(exc.messages)})


def _set_user_password(user, new_password, now=None):
    now = now or timezone.now()

    with transaction.atomic():
        user.set_password(new_password)
        user.save()
        Token.objects.filter(user=user).delete()
        PasswordResetCode.objects.filter(
            user=user,
            used_at__isnull=True,
        ).update(used_at=now)

    return user


def confirm_password_reset_code(
    email,
    code,
    new_password,
    new_password_confirm=None,
):
    normalized_email = normalize_email(email)
    user = get_password_reset_user(normalized_email)
    reset_code = _latest_reset_code(user)
    now = timezone.now()

    if not user or not reset_code or reset_code.requested_email != normalized_email:
        _error(_invalid_code_error())

    if reset_code.used_at:
        _error(_invalid_code_error())

    if reset_code.expires_at <= now:
        reset_code.used_at = now
        reset_code.save(update_fields=["used_at"])
        _error(_expired_code_error())

    if reset_code.attempts >= PASSWORD_RESET_MAX_ATTEMPTS:
        reset_code.used_at = reset_code.used_at or now
        reset_code.save(update_fields=["used_at"])
        _error(_blocked_code_error())

    raw_code = (code or "").strip()
    if not check_password(raw_code, reset_code.code_hash):
        reset_code.attempts += 1
        update_fields = ["attempts"]
        if reset_code.attempts >= PASSWORD_RESET_MAX_ATTEMPTS:
            reset_code.used_at = now
            update_fields.append("used_at")
            reset_code.save(update_fields=update_fields)
            _error(_blocked_code_error())

        reset_code.save(update_fields=update_fields)
        _error(_invalid_code_error())

    _validate_new_password(user, new_password, new_password_confirm)
    return _set_user_password(user, new_password, now=now)


def update_password_for_email(
    email,
    new_password,
    new_password_confirm=None,
):
    normalized_email = normalize_email(email)
    user = get_password_reset_user(normalized_email)

    if not user:
        _error(_unknown_user_error())

    _validate_new_password(user, new_password, new_password_confirm)
    return _set_user_password(user, new_password)

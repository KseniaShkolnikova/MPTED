import logging
import random
import string
from datetime import timedelta

from django.contrib.auth.hashers import check_password, make_password
from django.contrib.auth.models import User
from django.contrib.auth.password_validation import validate_password
from django.core.cache import cache
from django.core.exceptions import ValidationError as DjangoValidationError
from django.core.mail import send_mail
from django.db import transaction
from django.utils import timezone
from rest_framework.authtoken.models import Token

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


def _build_reset_email_message(user, code):
    display_name = user.get_full_name().strip() or user.username
    return (
        f"Здравствуйте, {display_name}!\n\n"
        f"Ваш код восстановления пароля: {code}\n"
        "Код действует 10 минут.\n\n"
        "Если это были не вы, просто проигнорируйте это письмо."
    )


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

        try:
            sent_count = send_mail(
                subject="Код восстановления пароля MPTed",
                message=_build_reset_email_message(user, code),
                from_email=None,
                recipient_list=[user.email],
                fail_silently=False,
            )
        except Exception:
            logger.exception(
                "Password reset email send failed for user_id=%s",
                user.id,
            )
            password_reset.delete()
            return False

        if sent_count <= 0:
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

    if new_password_confirm is not None and new_password != new_password_confirm:
        _error({"new_password_confirm": ["Пароли не совпадают."]})

    try:
        validate_password(new_password, user=user)
    except DjangoValidationError as exc:
        _error({"new_password": list(exc.messages)})

    with transaction.atomic():
        user.set_password(new_password)
        user.save()
        Token.objects.filter(user=user).delete()

        PasswordResetCode.objects.filter(
            user=user,
            used_at__isnull=True,
        ).update(used_at=now)

    return user

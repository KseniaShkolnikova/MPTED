import json
import logging
import os
import smtplib
from datetime import datetime
from urllib import error as urllib_error
from urllib import request as urllib_request

from django.conf import settings
from django.core.mail import EmailMultiAlternatives, get_connection
from django.template import TemplateDoesNotExist
from django.template.loader import render_to_string


logger = logging.getLogger(__name__)


def _email_base_context(**extra_context):
    sender_name = os.getenv("EMAIL_SENDER_NAME", "MPTed").strip() or "MPTed"
    support_email = (
        getattr(settings, "SERVER_EMAIL", "")
        or getattr(settings, "DEFAULT_FROM_EMAIL", "")
        or ""
    ).strip()

    return {
        "app_name": sender_name,
        "support_email": support_email,
        "current_year": datetime.now().year,
        **extra_context,
    }


def _resolve_template_names(template_name):
    normalized_name = template_name.replace("\\", "/").lstrip("/")
    if normalized_name.startswith(("email/", "emails/")):
        return [normalized_name]
    return [f"email/{normalized_name}", f"emails/{normalized_name}"]


def _render_email_template(template_names, context, fallback_html):
    for template_name in template_names:
        try:
            return render_to_string(template_name, context)
        except TemplateDoesNotExist:
            continue

    logger.warning("Не удалось загрузить email-шаблоны: %s", template_names)
    return fallback_html


def _render_templated_email(template_name, context, fallback_html):
    return _render_email_template(
        _resolve_template_names(template_name),
        _email_base_context(**context),
        fallback_html,
    )


def _fallback_card_html(title, recipient_name, body_html, subtitle=""):
    app_name = os.getenv("EMAIL_SENDER_NAME", "MPTed").strip() or "MPTed"
    greeting_block = ""
    if recipient_name:
        greeting_block = f"<p>Здравствуйте, <strong>{recipient_name}</strong>!</p>"

    subtitle_block = ""
    if subtitle:
        subtitle_block = f"<p style=\"margin:8px 0 0;color:#dbe7f0;\">{subtitle}</p>"

    return f"""<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{title}</title>
</head>
<body style="margin:0;padding:24px;background:#eef2f5;font-family:Segoe UI,Arial,sans-serif;color:#24323d;">
    <div style="max-width:640px;margin:0 auto;background:#ffffff;border:1px solid #d9e2e8;border-radius:16px;overflow:hidden;">
        <div style="background:#214e68;color:#ffffff;padding:28px 32px;">
            <div style="font-size:12px;letter-spacing:0.08em;text-transform:uppercase;opacity:0.8;">{app_name}</div>
            <h1 style="margin:12px 0 0;font-size:28px;line-height:1.2;">{title}</h1>
            {subtitle_block}
        </div>
        <div style="padding:32px;">
            {greeting_block}
            {body_html}
        </div>
        <div style="padding:20px 32px;border-top:1px solid #d9e2e8;background:#f8fafb;color:#5d6b76;font-size:13px;">
            Это автоматическое письмо от {app_name}. Отвечать на него не нужно.
        </div>
    </div>
</body>
</html>"""


def _send_via_brevo_api(to_email, subject, text_content, html_content):
    brevo_api_key = os.getenv("BREVO_API_KEY", "").strip()
    if not brevo_api_key:
        return False

    sender_email = (getattr(settings, "DEFAULT_FROM_EMAIL", "") or "").strip()
    sender_name = os.getenv("EMAIL_SENDER_NAME", "MPTed").strip() or "MPTed"

    if not sender_email:
        logger.error("Brevo fallback: DEFAULT_FROM_EMAIL пустой")
        return False

    payload = {
        "sender": {"name": sender_name, "email": sender_email},
        "to": [{"email": to_email}],
        "subject": subject,
        "textContent": text_content,
        "htmlContent": html_content,
    }
    data = json.dumps(payload).encode("utf-8")
    req = urllib_request.Request(
        url="https://api.brevo.com/v3/smtp/email",
        data=data,
        method="POST",
        headers={
            "accept": "application/json",
            "content-type": "application/json",
            "api-key": brevo_api_key,
        },
    )

    try:
        with urllib_request.urlopen(req, timeout=20) as response:
            status_code = getattr(response, "status", response.getcode())
            response_body = response.read().decode("utf-8", errors="ignore")
            if 200 <= status_code < 300:
                logger.info("Email отправлен через Brevo API")
                return True
            logger.error(
                "Brevo API вернул неожиданный статус %s: %s",
                status_code,
                response_body,
            )
            return False
    except urllib_error.HTTPError as http_error:
        error_body = http_error.read().decode("utf-8", errors="ignore")
        logger.error("Ошибка Brevo API HTTP %s: %s", http_error.code, error_body)
        return False
    except Exception as request_error:
        logger.error("Ошибка запроса к Brevo API: %s", request_error)
        return False


def _send_email_with_fallback(to_email, subject, text_content, html_content):
    email = EmailMultiAlternatives(
        subject=subject,
        body=text_content,
        from_email=settings.DEFAULT_FROM_EMAIL,
        to=[to_email],
    )
    email.attach_alternative(html_content, "text/html")

    try:
        result = email.send(fail_silently=False)
        if result == 1:
            return True
        logger.warning("SMTP вернул результат %s, пробуем Brevo fallback", result)
    except Exception as send_error:
        logger.error("SMTP ошибка отправки: %s", send_error)

    return _send_via_brevo_api(to_email, subject, text_content, html_content)


def _send_templated_email(
    to_email,
    subject,
    template_name,
    context,
    text_content,
    fallback_body_html,
):
    fallback_html = _fallback_card_html(
        title=context.get("title", subject),
        recipient_name=context.get("greeting_name", ""),
        subtitle=context.get("subtitle", ""),
        body_html=fallback_body_html,
    )
    html_content = _render_templated_email(template_name, context, fallback_html)
    return _send_email_with_fallback(to_email, subject, text_content, html_content)


def _send_security_code_email(
    *,
    to_email,
    subject,
    title,
    subtitle,
    preheader,
    recipient_name,
    intro_text,
    code,
    expires_in_minutes,
    warning_text,
    template_name,
):
    context = {
        "preheader": preheader,
        "title": title,
        "subtitle": subtitle,
        "greeting_name": recipient_name,
        "intro_text": intro_text,
        "code": code,
        "expires_in_minutes": expires_in_minutes,
        "warning_text": warning_text,
    }

    text_content = (
        f"Здравствуйте, {recipient_name}!\n\n"
        f"{intro_text}\n\n"
        f"Код: {code}\n"
        f"Срок действия: {expires_in_minutes} минут.\n\n"
        f"{warning_text}"
    )

    fallback_body_html = f"""
        <p>{intro_text}</p>
        <div style="margin:24px 0;padding:18px 20px;border:1px solid #d9e2e8;border-radius:12px;background:#f8fafb;">
            <div style="color:#5d6b76;font-size:12px;text-transform:uppercase;letter-spacing:0.08em;">Код</div>
            <div style="margin-top:8px;font-size:30px;letter-spacing:0.24em;font-weight:700;">{code}</div>
        </div>
        <p>Код действует {expires_in_minutes} минут.</p>
        <p style="padding:16px;border-radius:12px;background:#fff7eb;border:1px solid #f0d7ad;color:#6b4f1d;">{warning_text}</p>
    """

    return _send_templated_email(
        to_email=to_email,
        subject=subject,
        template_name=template_name,
        context=context,
        text_content=text_content,
        fallback_body_html=fallback_body_html,
    )


def _send_credentials_email(
    *,
    to_email,
    subject,
    title,
    subtitle,
    preheader,
    recipient_name,
    role_label,
    username,
    password,
    login_url,
    template_name,
):
    context = {
        "preheader": preheader,
        "title": title,
        "subtitle": subtitle,
        "greeting_name": recipient_name,
        "role_label": role_label,
        "username": username,
        "password": password,
        "action_url": login_url,
        "action_label": "Открыть MPTed",
        "action_hint": "Если кнопка не открывается, скопируйте ссылку в адресную строку браузера.",
    }

    text_content = (
        f"Здравствуйте, {recipient_name}!\n\n"
        f"Для вас создана учетная запись {role_label} в системе MPTed.\n\n"
        f"Логин: {username}\n"
        f"Пароль: {password}\n"
        f"Ссылка для входа: {login_url}\n\n"
        "После первого входа рекомендуем сменить пароль и не передавать данные третьим лицам."
    )

    fallback_body_html = f"""
        <p>Для вас создана учетная запись {role_label} в системе MPTed.</p>
        <div style="margin:24px 0;padding:18px 20px;border:1px solid #d9e2e8;border-radius:12px;background:#f8fafb;">
            <p style="margin:0 0 10px;"><strong>Логин:</strong> {username}</p>
            <p style="margin:0;"><strong>Пароль:</strong> {password}</p>
        </div>
        <p><a href="{login_url}">Открыть MPTed</a></p>
        <p style="padding:16px;border-radius:12px;background:#fff7eb;border:1px solid #f0d7ad;color:#6b4f1d;">После первого входа рекомендуем сменить пароль и не передавать данные третьим лицам.</p>
    """

    return _send_templated_email(
        to_email=to_email,
        subject=subject,
        template_name=template_name,
        context=context,
        text_content=text_content,
        fallback_body_html=fallback_body_html,
    )


def send_generic_email(to_email, subject, text_content, html_content=None):
    html = html_content if html_content is not None else text_content.replace("\n", "<br>")
    return _send_email_with_fallback(to_email, subject, text_content, html)


def send_student_email_verification_code_email(
    user_email,
    recipient_name,
    code,
    expires_in_minutes,
):
    logger.info("Отправка кода подтверждения входа на %s", user_email)
    return _send_security_code_email(
        to_email=user_email,
        subject="Код подтверждения входа в MPTed",
        title="Подтвердите вход",
        subtitle="Одноразовый код для входа в систему",
        preheader="Код подтверждения входа в MPTed.",
        recipient_name=recipient_name,
        intro_text="Используйте этот код, чтобы завершить вход в систему.",
        code=code,
        expires_in_minutes=expires_in_minutes,
        warning_text="Если это были не вы, сразу смените пароль и сообщите администратору.",
        template_name="verification_code_email.html",
    )


def send_password_reset_code_email(
    user_email,
    recipient_name,
    code,
    expires_in_minutes,
):
    logger.info("Отправка кода восстановления пароля на %s", user_email)
    return _send_security_code_email(
        to_email=user_email,
        subject="Код восстановления пароля в MPTed",
        title="Сброс пароля",
        subtitle="Одноразовый код для восстановления доступа",
        preheader="Код для восстановления пароля в MPTed.",
        recipient_name=recipient_name,
        intro_text="Мы получили запрос на восстановление пароля для вашей учетной записи.",
        code=code,
        expires_in_minutes=expires_in_minutes,
        warning_text="Если вы не запрашивали восстановление пароля, просто проигнорируйте это письмо.",
        template_name="password_reset_email.html",
    )


def send_student_credentials_email(
    student_email,
    username,
    password,
    student_name,
    login_url,
):
    try:
        logger.info("Попытка отправки email студенту %s (%s)", student_name, student_email)
        sent = _send_credentials_email(
            to_email=student_email,
            subject="Данные для входа в MPTed",
            title="Учетная запись создана",
            subtitle="Доступ к системе MPTed",
            preheader="Для вас подготовлены данные для входа в MPTed.",
            recipient_name=student_name,
            role_label="студента",
            username=username,
            password=password,
            login_url=login_url,
            template_name="student_welcome.html",
        )
        if sent:
            logger.info("Email успешно отправлен студенту %s (%s)", student_name, student_email)
            return True

        logger.warning("Email не отправлен студенту %s", student_email)
        return False
    except Exception as error:
        logger.error("Ошибка отправки email студенту %s: %s", student_email, error)
        logger.exception("Трассировка ошибки")
        return False


def send_account_changes_email(
    student_email,
    username,
    password,
    student_name,
    login_url,
    changes,
):
    recipient_email = student_email
    recipient_name = student_name
    normalized_changes = changes or ["Были обновлены данные учетной записи."]

    try:
        logger.info("Попытка отправки email об изменениях для %s (%s)", recipient_name, recipient_email)

        context = {
            "preheader": "В вашей учетной записи MPTed произошли изменения.",
            "title": "Данные учетной записи обновлены",
            "subtitle": "Проверьте актуальные данные для входа",
            "greeting_name": recipient_name,
            "changes": normalized_changes,
            "username": username,
            "password": password,
            "action_url": login_url,
            "action_label": "Открыть MPTed",
            "action_hint": "Если кнопка не открывается, скопируйте ссылку в адресную строку браузера.",
        }

        changes_text = "\n".join(f"- {change}" for change in normalized_changes)
        password_text = f"Новый пароль: {password}\n" if password else "Пароль не менялся.\n"
        text_content = (
            f"Здравствуйте, {recipient_name}!\n\n"
            "В вашей учетной записи MPTed произошли изменения:\n"
            f"{changes_text}\n\n"
            "Актуальные данные для входа:\n"
            f"Логин: {username}\n"
            f"{password_text}"
            f"Ссылка для входа: {login_url}\n\n"
            "Если вы не инициировали эти изменения, обратитесь к администратору."
        )

        changes_html = "".join(f"<li>{change}</li>" for change in normalized_changes)
        password_html = ""
        if password:
            password_html = f"""
                <div style="padding-top:12px;margin-top:12px;border-top:1px solid #d9e2e8;">
                    <div style="color:#5d6b76;font-size:13px;">Новый пароль</div>
                    <div style="margin-top:4px;font-weight:600;">{password}</div>
                </div>
            """

        fallback_body_html = f"""
            <p>В вашей учетной записи MPTed произошли изменения:</p>
            <ul>{changes_html}</ul>
            <div style="margin:24px 0;padding:18px 20px;border:1px solid #d9e2e8;border-radius:12px;background:#f8fafb;">
                <div style="color:#5d6b76;font-size:13px;">Логин</div>
                <div style="margin-top:4px;font-weight:600;">{username}</div>
                {password_html}
            </div>
            <p><a href="{login_url}">Открыть MPTed</a></p>
            <p style="padding:16px;border-radius:12px;background:#fff7eb;border:1px solid #f0d7ad;color:#6b4f1d;">Если вы не инициировали эти изменения, обратитесь к администратору.</p>
        """

        sent = _send_templated_email(
            to_email=recipient_email,
            subject="Изменения в учетной записи MPTed",
            template_name="account_changes_email.html",
            context=context,
            text_content=text_content,
            fallback_body_html=fallback_body_html,
        )
        if sent:
            logger.info("Email об изменениях успешно отправлен для %s", recipient_name)
            return True

        logger.warning("Email об изменениях не отправлен для %s", recipient_email)
        return False
    except Exception as error:
        logger.error("Ошибка отправки email об изменениях: %s", error)
        return False


def send_teacher_credentials_email(
    teacher_email,
    username,
    password,
    teacher_name,
    login_url,
):
    try:
        logger.info("Попытка отправки email преподавателю %s (%s)", teacher_name, teacher_email)
        sent = _send_credentials_email(
            to_email=teacher_email,
            subject="Данные для входа в MPTed",
            title="Учетная запись создана",
            subtitle="Доступ к системе MPTed",
            preheader="Для вас подготовлены данные для входа в MPTed.",
            recipient_name=teacher_name,
            role_label="преподавателя",
            username=username,
            password=password,
            login_url=login_url,
            template_name="teacher_welcome.html",
        )
        if sent:
            logger.info("Email успешно отправлен преподавателю %s (%s)", teacher_name, teacher_email)
            return True

        logger.warning("Email не отправлен преподавателю %s", teacher_email)
        return False
    except Exception as error:
        logger.error("Ошибка отправки email преподавателю %s: %s", teacher_email, error)
        return False


def test_email_connection():
    try:
        logger.info("Тестирование соединения с SMTP сервером")

        connection = get_connection()

        logger.debug("Backend: %s", connection.__class__.__name__)
        logger.debug("Host: %s", connection.host)
        logger.debug("Port: %s", connection.port)
        logger.debug("Username: %s", connection.username)

        connection.open()
        logger.info("Соединение с SMTP сервером установлено успешно")

        if hasattr(connection, "login"):
            connection.login()
            logger.info("Авторизация прошла успешно")

        connection.close()
        logger.info("Соединение закрыто")
        return True
    except smtplib.SMTPAuthenticationError as error:
        logger.error("Ошибка аутентификации: %s", error)
        logger.error("Проверьте логин и пароль в настройках SMTP")
        return False
    except Exception as error:
        logger.error("Ошибка соединения: %s", error)
        return False

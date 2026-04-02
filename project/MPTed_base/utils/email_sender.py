# MPTed_base/utils/email_sender.py
import logging
import json
import os
from django.core.mail import EmailMultiAlternatives, get_connection
from django.template.loader import render_to_string
from django.conf import settings
import smtplib
import ssl
from urllib import error as urllib_error
from urllib import request as urllib_request
from datetime import datetime


logger = logging.getLogger(__name__)


def _render_email_template(template_names, context, fallback_html):
    """Пробует загрузить один из шаблонов; если не найден, возвращает fallback."""
    for template_name in template_names:
        try:
            return render_to_string(template_name, context)
        except Exception:
            continue
    logger.warning(f"⚠️ Не удалось загрузить шаблоны: {template_names}")
    return fallback_html


def _send_via_brevo_api(to_email, subject, text_content, html_content):
    """
    Fallback-отправка через Brevo API.
    Работает по HTTPS, что обычно надежнее на PythonAnywhere free, чем SMTP.
    """
    brevo_api_key = os.getenv("BREVO_API_KEY", "").strip()
    if not brevo_api_key:
        return False

    sender_email = (getattr(settings, "DEFAULT_FROM_EMAIL", "") or "").strip()
    sender_name = os.getenv("EMAIL_SENDER_NAME", "MPTed").strip() or "MPTed"

    if not sender_email:
        logger.error("❌ Brevo fallback: DEFAULT_FROM_EMAIL пустой")
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
                logger.info("✅ Email отправлен через Brevo API")
                return True
            logger.error(
                f"❌ Brevo API вернул неожиданный статус {status_code}: {response_body}"
            )
            return False
    except urllib_error.HTTPError as http_error:
        error_body = http_error.read().decode("utf-8", errors="ignore")
        logger.error(f"❌ Ошибка Brevo API HTTP {http_error.code}: {error_body}")
        return False
    except Exception as request_error:
        logger.error(f"❌ Ошибка запроса к Brevo API: {request_error}")
        return False


def _send_email_with_fallback(to_email, subject, text_content, html_content):
    """Основная отправка: SMTP -> fallback через Brevo API."""
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
        logger.warning(f"⚠️ SMTP вернул результат {result}, пробуем Brevo fallback")
    except Exception as send_error:
        logger.error(f"❌ SMTP ошибка отправки: {send_error}")

    return _send_via_brevo_api(to_email, subject, text_content, html_content)


def send_generic_email(to_email, subject, text_content, html_content=None):
    """
    Универсальная отправка писем с fallback:
    SMTP -> Brevo API (если BREVO_API_KEY задан).
    """
    html = html_content if html_content is not None else text_content.replace("\n", "<br>")
    return _send_email_with_fallback(to_email, subject, text_content, html)


def send_student_credentials_email(student_email, username, password, student_name, login_url):
    """
    Отправляет HTML письмо с учетными данными студенту
    """
    try:
        logger.info(f"🔄 Попытка отправки email студенту {student_name} ({student_email})")
        
        subject = f'Ваши учетные данные для входа в образовательную систему'
        
        fallback_html = f"""
        <html>
        <body>
            <h2>Здравствуйте, {student_name}!</h2>
            <p>Ваша учетная запись в образовательной системе была успешно создана.</p>
            <p><strong>Ваши данные для входа:</strong></p>
            <ul>
                <li><strong>Логин:</strong> {username}</li>
                <li><strong>Пароль:</strong> {password}</li>
            </ul>
            <p><a href="{login_url}">Войти в систему</a></p>
            <p>После первого входа рекомендуется сменить пароль.</p>
        </body>
        </html>
        """
        html_content = _render_email_template(
            ['emails/student_welcome.html', 'email/student_welcome.html'],
            {
                'student_name': student_name,
                'username': username,
                'password': password,
                'login_url': login_url,
            },
            fallback_html,
        )
        
        # Текстовая версия
        text_content = f"""
        Здравствуйте, {student_name}!
        
        Ваша учетная запись в образовательной системе была успешно создана.
        
        Ваши данные для входа:
        • Логин: {username}
        • Пароль: {password}
        • Ссылка для входа: {login_url}
        
        После первого входа рекомендуется сменить пароль.
        Никому не сообщайте свои учетные данные.
        
        С уважением,
        Администрация образовательной системы
        """
        
        # Пытаемся отправить через SMTP; при проблемах с сетью будет fallback в Brevo API
        sent = _send_email_with_fallback(student_email, subject, text_content, html_content)
        if sent:
            logger.info(f"✅ Email успешно отправлен студенту {student_name} ({student_email})")
            return True

        logger.warning(f"⚠️ Email не отправлен студенту {student_email}")
        return False
        
    except Exception as e:
        logger.error(f"❌ Общая ошибка отправки email студенту {student_email}: {str(e)}")
        logger.exception("Трассировка ошибки:")
        return False


def send_account_changes_email(student_email, username, password, student_name, login_url, changes):
    """
    Отправляет письмо об изменениях в учетной записи
    """
    try:
        logger.info(f"🔄 Попытка отправки email об изменениях студенту {student_name} ({student_email})")
        
        subject = f'Изменения в вашей учетной записи'
        
        # Подготовка HTML контента
        html_content = f"""
        <html>
        <body>
            <h2>Здравствуйте, {student_name}!</h2>
            <p>В вашей учетной записи произошли следующие изменения:</p>
            <ul>
        """
        
        for change in changes:
            html_content += f"<li>{change}</li>"
        
        html_content += f"""
            </ul>
            <p><strong>Текущие данные для входа:</strong></p>
            <ul>
                <li><strong>Логин:</strong> {username}</li>
        """
        
        if password:
            html_content += f"<li><strong>Новый пароль:</strong> {password}</li>"
        
        html_content += f"""
            </ul>
            <p><a href="{login_url}">Войти в систему</a></p>
        </body>
        </html>
        """
        
        # Текстовая версия
        text_content = f"В вашей учетной записи произошли изменения: {', '.join(changes)}"
        
        sent = _send_email_with_fallback(student_email, subject, text_content, html_content)
        if sent:
            logger.info(f"✅ Email об изменениях отправлен студенту {student_name}")
            return True

        logger.warning(f"⚠️ Email об изменениях не отправлен студенту {student_email}")
        return False
        
    except Exception as e:
        logger.error(f"❌ Общая ошибка отправки email об изменениях: {str(e)}")
        return False


# Дополнительная функция для тестирования email соединения
def test_email_connection():
    """Тестирует соединение с SMTP сервером"""
    try:
        logger.info("🔧 Тестирование соединения с SMTP сервером...")
        
        connection = get_connection()
        
        logger.debug(f"Backend: {connection.__class__.__name__}")
        logger.debug(f"Host: {connection.host}")
        logger.debug(f"Port: {connection.port}")
        logger.debug(f"Username: {connection.username}")
        
        # Пробуем открыть соединение
        connection.open()
        logger.info("✅ Соединение с SMTP сервером установлено успешно!")
        
        # Проверяем авторизацию
        if hasattr(connection, 'login'):
            connection.login()
            logger.info("✅ Авторизация прошла успешно!")
        
        connection.close()
        logger.info("✅ Соединение закрыто")
        return True
        
    except smtplib.SMTPAuthenticationError as e:
        logger.error(f"❌ Ошибка аутентификации: {e}")
        logger.error("Проверьте логин и пароль в настройках Gmail")
        return False
        
    except Exception as e:
        logger.error(f"❌ Ошибка соединения: {e}")
        return False
    

def send_teacher_credentials_email(teacher_email, username, password, teacher_name, login_url):
    """
    Отправляет HTML письмо с учетными данными преподавателю
    """
    try:
        logger.info(f"Отправка email преподавателю {teacher_name} ({teacher_email})")
        
        subject = 'Учетные данные для входа в систему МПТед'
        
        fallback_html = f"""
        <html>
        <body>
            <h2>Уважаемый(ая) {teacher_name},</h2>
            <p>Ваша учетная запись преподавателя в системе МПТед создана.</p>
            <p><strong>Логин:</strong> {username}</p>
            <p><strong>Пароль:</strong> {password}</p>
            <p><a href="{login_url}">Войти в систему</a></p>
            <p>Сохраните эти данные и смените пароль после первого входа.</p>
        </body>
        </html>
        """
        html_content = _render_email_template(
            ['emails/teacher_welcome.html', 'email/teacher_welcome.html'],
            {
                'teacher_name': teacher_name,
                'username': username,
                'password': password,
                'login_url': login_url,
            },
            fallback_html,
        )
        
        text_content = f"""
        Уважаемый(ая) {teacher_name},
        
        Ваша учетная запись преподавателя в системе МПТед создана.
        
        Логин: {username}
        Пароль: {password}
        Ссылка: {login_url}
        
        Сохраните эти данные.
        Смените пароль после первого входа.
        """
        
        sent = _send_email_with_fallback(teacher_email, subject, text_content, html_content)
        if sent:
            logger.info(f"Email отправлен преподавателю {teacher_name}")
            return True

        logger.warning(f"Email не отправлен преподавателю {teacher_email}")
        return False
        
    except Exception as e:
        logger.error(f"Ошибка отправки email преподавателю: {str(e)}")
        return False

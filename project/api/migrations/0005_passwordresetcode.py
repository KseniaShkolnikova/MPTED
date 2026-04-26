

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("api", "0004_studentprofile_email_verified"),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name="PasswordResetCode",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                (
                    "requested_email",
                    models.EmailField(
                        max_length=254,
                        verbose_name="Email запроса",
                    ),
                ),
                (
                    "code_hash",
                    models.CharField(
                        max_length=255,
                        verbose_name="Хеш кода",
                    ),
                ),
                (
                    "created_at",
                    models.DateTimeField(
                        auto_now_add=True,
                        verbose_name="Создан",
                    ),
                ),
                (
                    "expires_at",
                    models.DateTimeField(verbose_name="Действует до"),
                ),
                (
                    "used_at",
                    models.DateTimeField(
                        blank=True,
                        null=True,
                        verbose_name="Использован",
                    ),
                ),
                (
                    "attempts",
                    models.PositiveSmallIntegerField(
                        default=0,
                        verbose_name="Попытки",
                    ),
                ),
                (
                    "request_ip",
                    models.GenericIPAddressField(
                        blank=True,
                        null=True,
                        verbose_name="IP запроса",
                    ),
                ),
                (
                    "user",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="password_reset_codes",
                        to=settings.AUTH_USER_MODEL,
                        verbose_name="Пользователь",
                    ),
                ),
            ],
            options={
                "verbose_name": "Код восстановления пароля",
                "verbose_name_plural": "Коды восстановления пароля",
                "ordering": ["-created_at"],
                "indexes": [
                    models.Index(
                        fields=["user", "created_at"],
                        name="api_prc_user_created_idx",
                    ),
                    models.Index(
                        fields=["requested_email", "created_at"],
                        name="api_prc_email_created_idx",
                    ),
                    models.Index(
                        fields=["expires_at"],
                        name="api_prc_expires_idx",
                    ),
                ],
            },
        ),
    ]

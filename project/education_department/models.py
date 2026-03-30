from django.conf import settings
from django.db import models

from api.models import ScheduleLesson, Subject


class LessonReplacement(models.Model):
    """
    One-time lesson replacement for a specific date.
    Does not change the base weekly schedule.
    """

    replacement_date = models.DateField(
        db_index=True,
        verbose_name="Дата замены",
    )
    original_lesson = models.ForeignKey(
        ScheduleLesson,
        on_delete=models.CASCADE,
        related_name="lesson_replacements",
        verbose_name="Исходный пара",
    )
    replacement_subject = models.ForeignKey(
        Subject,
        on_delete=models.PROTECT,
        related_name="lesson_replacements",
        verbose_name="Предмет замены",
    )
    replacement_teacher = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.PROTECT,
        related_name="lesson_replacements",
        verbose_name="Преподаватель замены",
    )
    reason = models.CharField(
        max_length=255,
        blank=True,
        default="",
        verbose_name="Причина",
    )
    created_by = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="created_lesson_replacements",
        verbose_name="Кем создано",
    )
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Создано")
    updated_at = models.DateTimeField(auto_now=True, verbose_name="Обновлено")

    class Meta:
        verbose_name = "Разовая замена пары"
        verbose_name_plural = "Разовые замены пар"
        ordering = ["-replacement_date", "original_lesson__lesson_number"]
        unique_together = ("replacement_date", "original_lesson")

    def __str__(self):
        group_name = self.original_lesson.daily_schedule.student_group.name
        return (
            f"{self.replacement_date} - {group_name}, "
            f"{self.original_lesson.lesson_number} пара"
        )


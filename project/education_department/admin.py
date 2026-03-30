from django.contrib import admin

from .models import LessonReplacement


@admin.register(LessonReplacement)
class LessonReplacementAdmin(admin.ModelAdmin):
    list_display = (
        "replacement_date",
        "get_group",
        "get_week_day",
        "get_lesson_number",
        "replacement_subject",
        "replacement_teacher",
        "created_at",
    )
    list_filter = ("replacement_date", "replacement_subject")
    search_fields = (
        "original_lesson__daily_schedule__student_group__name",
        "replacement_subject__name",
        "replacement_teacher__first_name",
        "replacement_teacher__last_name",
        "reason",
    )

    @admin.display(description="Класс")
    def get_group(self, obj):
        return obj.original_lesson.daily_schedule.student_group.name

    @admin.display(description="День недели")
    def get_week_day(self, obj):
        return obj.original_lesson.daily_schedule.get_week_day_display()

    @admin.display(description="Пара")
    def get_lesson_number(self, obj):
        return obj.original_lesson.lesson_number


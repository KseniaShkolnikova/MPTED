from datetime import timedelta

from django.utils import timezone

from api.models import ScheduleLesson

from .models import LessonReplacement


WEEKDAY_CODES = ("MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN")


def get_week_day_code(target_date):
    return WEEKDAY_CODES[target_date.weekday()]


def get_current_week_start(reference_date=None):
    base_date = reference_date or timezone.localdate()
    return base_date - timedelta(days=base_date.weekday())


def get_current_week_dates(reference_date=None):
    week_start = get_current_week_start(reference_date)
    return {
        code: week_start + timedelta(days=index)
        for index, code in enumerate(WEEKDAY_CODES)
    }


def annotate_lessons_with_replacements(lessons, target_date):
    lessons = list(lessons)
    if not lessons:
        return lessons

    lesson_ids = [lesson.id for lesson in lessons]
    replacements = LessonReplacement.objects.filter(
        replacement_date=target_date,
        original_lesson_id__in=lesson_ids,
    ).select_related(
        "replacement_subject",
        "replacement_teacher",
    )
    replacements_by_lesson = {
        replacement.original_lesson_id: replacement
        for replacement in replacements
    }

    for lesson in lessons:
        replacement = replacements_by_lesson.get(lesson.id)
        lesson.replacement = replacement
        lesson.is_replaced = bool(replacement)
        lesson.effective_subject = (
            replacement.replacement_subject if replacement else lesson.subject
        )
        lesson.effective_teacher = (
            replacement.replacement_teacher if replacement else lesson.teacher
        )

    return lessons


def get_teacher_effective_lessons_for_date(
    teacher_user,
    target_date,
    *,
    group_id=None,
    subject_id=None,
):
    week_day = get_week_day_code(target_date)

    lessons_qs = ScheduleLesson.objects.filter(
        daily_schedule__week_day=week_day,
        daily_schedule__is_active=True,
        daily_schedule__is_weekend=False,
    ).select_related(
        "subject",
        "teacher",
        "daily_schedule__student_group",
    ).order_by(
        "lesson_number",
    )

    if group_id:
        lessons_qs = lessons_qs.filter(daily_schedule__student_group_id=group_id)

    lessons = annotate_lessons_with_replacements(lessons_qs, target_date)

    effective_lessons = []
    subject_id_int = None
    if subject_id:
        try:
            subject_id_int = int(subject_id)
        except (TypeError, ValueError):
            subject_id_int = None

    for lesson in lessons:
        if lesson.is_replaced:
            if lesson.replacement.replacement_teacher_id != teacher_user.id:
                continue
        elif lesson.teacher_id != teacher_user.id:
            continue

        if subject_id_int and lesson.effective_subject.id != subject_id_int:
            continue

        effective_lessons.append(lesson)

    return effective_lessons

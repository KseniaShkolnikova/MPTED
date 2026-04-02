from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.db.models import Q, Count, Avg, Sum, Max, Min
from django.core.paginator import Paginator
from django.db.models.functions import TruncMonth, TruncYear  # Добавить эту строку!
from django.utils import timezone
from datetime import datetime, date, timedelta
import json
import calendar
from django.http import HttpResponse
from django.utils import timezone
from django.db.models import Avg, Count, Q
from api.models import StudentGroup, StudentProfile, Grade, Subject


# Импортируем ВСЕ существующие модели из api
from api.models import *
from django.contrib.auth.models import User, Group
from django.http import JsonResponse
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.forms import PasswordChangeForm
from django.views.decorators.http import require_POST
from django.urls import reverse

# Декораторы (скопируем из вашего декораторов.py)
from MPTed_base.decorators import *
from .models import LessonReplacement
from .replacement_utils import (
    get_current_week_dates,
    get_teacher_effective_lessons_for_date,
)


# ===== ФУНКЦИИ ОЦЕНОК ПО ГРУППАМ (КОПИРУЕМ ИЗ ВАШЕГО ФАЙЛА) =====

@login_required
@education_department_required
def group_grades_overview(request):
    """Обзор оценок по группам (ТОЧНАЯ КОПИЯ ВАШЕЙ ФУНКЦИИ)"""
    # Получаем все группы
    groups = StudentGroup.objects.all().select_related('curator').order_by('year', 'name')
    
    # Статистика по группам
    groups_stats = []
    for group in groups:
        # Количество студентов в группе
        student_count = StudentProfile.objects.filter(student_group=group).count()
        
        # Средняя оценка по группе
        avg_grade_result = Grade.objects.filter(
            student__student_profile__student_group=group
        ).aggregate(avg=Avg('value'))
        avg_grade = round(avg_grade_result['avg'], 1) if avg_grade_result['avg'] else 0
        
        # Количество оценок
        grades_count = Grade.objects.filter(
            student__student_profile__student_group=group
        ).count()
        
        groups_stats.append({
            'group': group,
            'student_count': student_count,
            'avg_grade': avg_grade,
            'grades_count': grades_count,
        })
    
    context = {
        'groups_stats': groups_stats,
    }
    # Итоги (правильные, без шаблонных костылей)
    total_students = sum(s['student_count'] for s in groups_stats)
    total_grades = sum(s['grades_count'] for s in groups_stats)

    # Сколько групп без куратора
    groups_without_curator = sum(1 for s in groups_stats if not s['group'].curator)

    # Средний балл по всем оценкам (не среднее из средних!)
    overall_avg_result = Grade.objects.aggregate(avg=Avg('value'))
    overall_avg = round(overall_avg_result['avg'], 1) if overall_avg_result['avg'] else 0

    context = {
        'groups_stats': groups_stats,
        'total_students': total_students,
        'total_grades': total_grades,
        'groups_without_curator': groups_without_curator,
        'overall_avg': overall_avg,
    }
    return render(request, 'education_department/group_grades_overview.html', context)

    


@login_required
@education_department_required
def group_grades_detail(request, group_id):
    """Детальная статистика оценок по группе"""
    group = get_object_or_404(StudentGroup, id=group_id)
    
    # Получаем предметы, которые есть у группы в расписании
    subjects_in_schedule = Subject.objects.filter(
        schedule_lessons__daily_schedule__student_group=group
    ).distinct().order_by('name')
    
    # Получаем всех студентов группы
    students = StudentProfile.objects.filter(
        student_group=group
    ).select_related('user').order_by('user__last_name', 'user__first_name')
    
    # Статистика по предметам
    subjects_stats = []
    for subject in subjects_in_schedule:
        # Преподаватели, которые ведут этот предмет в этой группе
        teachers = User.objects.filter(
            schedule_lessons__daily_schedule__student_group=group,
            schedule_lessons__subject=subject
        ).distinct()
        
        # Оценки по этому предмету в группе
        grades = Grade.objects.filter(
            student__student_profile__student_group=group,
            subject=subject
        )
        
        # Средняя оценка по предмету
        avg_result = grades.aggregate(avg=Avg('value'))
        avg_grade = round(avg_result['avg'], 1) if avg_result['avg'] else 0
        
        # Количество оценок
        grades_count = grades.count()
        
        # Распределение оценок
        grade_distribution = {}
        for value in [5, 4, 3, 2]:
            count = grades.filter(value=value).count()
            if count > 0:
                grade_distribution[value] = count
        
        subjects_stats.append({
            'subject': subject,
            'teachers': teachers,
            'avg_grade': avg_grade,
            'grades_count': grades_count,
            'grade_distribution': grade_distribution,
        })
    
    # Общая статистика по группе
    all_grades = Grade.objects.filter(
        student__student_profile__student_group=group
    )
    
    total_grades = all_grades.count()
    overall_avg_result = all_grades.aggregate(avg=Avg('value'))
    overall_avg = round(overall_avg_result['avg'], 1) if overall_avg_result['avg'] else 0
    
    # Статистика по типам оценок
    grade_types_stats = []
    for grade_type_code, grade_type_name in Grade.GradeType.choices:
        count = all_grades.filter(grade_type=grade_type_code).count()
        if count > 0:
            avg_result = all_grades.filter(grade_type=grade_type_code).aggregate(avg=Avg('value'))
            avg = round(avg_result['avg'], 1) if avg_result['avg'] else 0
            grade_types_stats.append({
                'name': grade_type_name,
                'count': count,
                'avg': avg,
            })
    
    # Последние оценки в группе
    recent_grades = all_grades.select_related(
        'student', 'subject', 'teacher'
    ).order_by('-date', '-id')[:10]
    
    # Добавляем распределение оценок для общего просмотра
    overall_distribution = {}
    for value in [5, 4, 3, 2]:
        count = all_grades.filter(value=value).count()
        if count > 0:
            overall_distribution[value] = count
    
    context = {
        'group': group,
        'students': students,
        'subjects_stats': subjects_stats,
        'total_grades': total_grades,
        'overall_grade': overall_avg,  # Переименовано для шаблона
        'overall_avg': overall_avg,     # Оставляем для обратной совместимости
        'grade_types_stats': grade_types_stats,
        'recent_grades': recent_grades,
        'student_count': students.count(),
        'overall_distribution': overall_distribution,
    }
    return render(request, 'education_department/group_grades_detail.html', context)

@login_required
@education_department_required
def group_subject_grades(request, group_id, subject_id):
    """Оценки по конкретному предмету в группе (ТОЧНАЯ КОПИЯ ВАШЕЙ ФУНКЦИИ)"""
    group = get_object_or_404(StudentGroup, id=group_id)
    subject = get_object_or_404(Subject, id=subject_id)
    
    # Проверяем, есть ли этот предмет в расписании группы
    if not ScheduleLesson.objects.filter(
        daily_schedule__student_group=group,
        subject=subject
    ).exists():
        messages.error(request, f'Предмет "{subject.name}" не входит в расписание группы {group.name}')
        return redirect('education_department:group_grades_detail', group_id=group_id)
    
    # Получаем всех студентов группы
    students = StudentProfile.objects.filter(
        student_group=group
    ).select_related('user').order_by('user__last_name', 'user__first_name')
    
    # Получаем преподавателей, которые ведут этот предмет в группе
    teachers = User.objects.filter(
        schedule_lessons__daily_schedule__student_group=group,
        schedule_lessons__subject=subject
    ).distinct()
    
    # Собираем оценки по студентам
    students_grades = []
    for student_profile in students:
        grades = Grade.objects.filter(
            student=student_profile.user,
            subject=subject
        ).order_by('-date')
        
        # Средняя оценка студента по предмету
        avg_result = grades.aggregate(avg=Avg('value'))
        avg_grade = round(avg_result['avg'], 1) if avg_result['avg'] else 0
        
        # Количество оценок
        grades_count = grades.count()
        
        # Последние 5 оценок
        recent_grades = grades[:5]
        
        students_grades.append({
            'student': student_profile,
            'grades': grades,
            'avg_grade': avg_grade,
            'grades_count': grades_count,
            'recent_grades': recent_grades,
        })
    
    # Общая статистика по предмету в группе
    all_grades = Grade.objects.filter(
        student__student_profile__student_group=group,
        subject=subject
    )
    
    total_grades = all_grades.count()
    overall_avg_result = all_grades.aggregate(avg=Avg('value'))
    overall_avg = round(overall_avg_result['avg'], 1) if overall_avg_result['avg'] else 0
    
    # Распределение оценок
    grade_distribution = {}
    for value in [5, 4, 3, 2]:
        count = all_grades.filter(value=value).count()
        percentage = round((count / total_grades * 100), 1) if total_grades > 0 else 0
        if count > 0:
            grade_distribution[value] = {
                'count': count,
                'percentage': percentage
            }
    
    # Статистика по типам оценок для этого предмета
    grade_types_stats = []
    for grade_type_code, grade_type_name in Grade.GradeType.choices:
        count = all_grades.filter(grade_type=grade_type_code).count()
        if count > 0:
            avg_result = all_grades.filter(grade_type=grade_type_code).aggregate(avg=Avg('value'))
            avg = round(avg_result['avg'], 1) if avg_result['avg'] else 0
            percentage = round((count / total_grades * 100), 1) if total_grades > 0 else 0
            grade_types_stats.append({
                'type': grade_type_code,
                'name': grade_type_name,
                'count': count,
                'avg': avg,
                'percentage': percentage,
            })
    
    context = {
        'group': group,
        'subject': subject,
        'teachers': teachers,
        'students_grades': students_grades,
        'total_grades': total_grades,
        'overall_avg': overall_avg,
        'grade_distribution': grade_distribution,
        'grade_types_stats': grade_types_stats,
    }
    return render(request, 'education_department/group_subject_grades.html', context)


# ===== ФУНКЦИИ ОБЗОРА УЧИТЕЛЕЙ (КОПИРУЕМ ИЗ ВАШЕГО ФАЙЛА) =====

@login_required
@education_department_required
def teacher_subject_performance(request, teacher_id, subject_id):
    """Производительность преподавателя по конкретному предмету (аналог вашей функции)"""
    user = get_object_or_404(User, id=teacher_id)
    subject = get_object_or_404(Subject, id=subject_id)
    
    # Проверяем, что преподаватель преподает этот предмет
    if not TeacherSubject.objects.filter(
        teacher__user=user,
        subject=subject
    ).exists():
        messages.error(request, f'Преподаватель не преподает предмет "{subject.name}"')
        return redirect('education_department:teacher_full_detail', teacher_id=teacher_id)
    
    # Группы, в которых преподаватель ведет этот предмет
    teaching_groups = StudentGroup.objects.filter(
        daily_schedules__lessons__teacher=user,
        daily_schedules__lessons__subject=subject
    ).distinct().order_by('year', 'name')
    
    # Оценки преподавателя по этому предмету
    grades = Grade.objects.filter(
        teacher=user,
        subject=subject
    ).select_related('student', 'schedule_lesson__daily_schedule__student_group')
    
    total_grades = grades.count()
    avg_grade_result = grades.aggregate(avg=Avg('value'))
    avg_grade = round(avg_grade_result['avg'], 1) if avg_grade_result['avg'] else 0
    
    # Статистика по месяцам
    import calendar
    from django.db.models.functions import TruncMonth
    
    monthly_stats = []
    monthly_data = grades.annotate(
        month=TruncMonth('date')
    ).values('month').annotate(
        count=Count('id'),
        avg=Avg('value')
    ).order_by('-month')[:12]  # Последние 12 месяцев
    
    for stat in monthly_data:
        monthly_stats.append({
            'month': stat['month'].strftime('%Y-%m'),
            'month_name': calendar.month_name[stat['month'].month],
            'year': stat['month'].year,
            'count': stat['count'],
            'avg': round(stat['avg'], 1) if stat['avg'] else 0,
        })
    
    # Статистика по группам
    group_stats = []
    for group in teaching_groups:
        group_grades = grades.filter(
            schedule_lesson__daily_schedule__student_group=group
        )
        group_total = group_grades.count()
        
        if group_total > 0:
            group_avg_result = group_grades.aggregate(avg=Avg('value'))
            group_avg = round(group_avg_result['avg'], 1) if group_avg_result['avg'] else 0
            
            group_stats.append({
                'group': group,
                'total': group_total,
                'avg': group_avg,
            })
    
    # Распределение оценок
    grade_distribution = {}
    for value in [5, 4, 3, 2]:
        count = grades.filter(value=value).count()
        if count > 0:
            percentage = round((count / total_grades * 100), 1) if total_grades > 0 else 0
            grade_distribution[value] = {
                'count': count,
                'percentage': percentage
            }
    
    # Последние оценки
    recent_grades = grades.order_by('-date')[:20]
    
    context = {
        'teacher_user': user,
        'subject': subject,
        'teaching_groups': teaching_groups,
        'total_grades': total_grades,
        'avg_grade': avg_grade,
        'monthly_stats': monthly_stats,
        'group_stats': group_stats,
        'grade_distribution': grade_distribution,
        'recent_grades': recent_grades,
    }
    return render(request, 'education_department/teachers/teacher_subject_performance.html', context)

@login_required
@education_department_required
def teacher_full_detail(request, teacher_id):
    """Полная детальная информация об учителе (аналог вашей функции)"""
    user = get_object_or_404(User, id=teacher_id)
    
    # Проверяем, что это преподаватель
    if not user.groups.filter(name='teacher').exists() and not hasattr(user, 'teacher_profile'):
        messages.error(request, 'Пользователь не является преподавателем')
        return redirect('education_department:teachers_overview')
    
    try:
        profile = user.teacher_profile
    except TeacherProfile.DoesNotExist:
        profile = None
        messages.warning(request, 'У преподавателя нет профиля')
    
    # Предметы преподавателя
    teacher_subjects = TeacherSubject.objects.filter(
        teacher__user=user
    ).select_related('subject')
    
    # Группы, в которых преподает преподаватель
    teaching_groups = StudentGroup.objects.filter(
        daily_schedules__lessons__teacher=user
    ).distinct().order_by('year', 'name')
    
    # Детальное расписание преподавателя
    schedule_by_day = {}
    week_dates = get_current_week_dates()
    day_name_map = dict(DailySchedule.WeekDay.choices)

    for day_code, day_date in week_dates.items():
        day_lessons = get_teacher_effective_lessons_for_date(user, day_date)
        if not day_lessons:
            continue

        schedule_by_day[day_code] = {
            'day_name': day_name_map.get(day_code, day_code),
            'lessons': day_lessons,
        }
    
    # Статистика оценок
    grades_stats = Grade.objects.filter(
        teacher=user
    )
    
    total_grades = grades_stats.count()
    avg_grade_result = grades_stats.aggregate(avg=Avg('value'))
    avg_grade = round(avg_grade_result['avg'], 1) if avg_grade_result['avg'] else 0
    
    # Статистика по предметам
    grades_by_subject = []
    for ts in teacher_subjects:
        subject_grades = Grade.objects.filter(
            teacher=user,
            subject=ts.subject
        )
        
        subject_stats = subject_grades.aggregate(
            total=Count('id'),
            avg=Avg('value'),
            first_date=Min('date'),
            last_date=Max('date')
        )
        
        # Распределение оценок по предмету
        grade_distribution = {}
        for value in [5, 4, 3, 2]:
            count = subject_grades.filter(value=value).count()
            if count > 0:
                percentage = round((count / subject_stats['total'] * 100), 1) if subject_stats['total'] > 0 else 0
                grade_distribution[value] = {
                    'count': count,
                    'percentage': percentage
                }
        
        grades_by_subject.append({
            'subject': ts.subject,
            'total': subject_stats['total'] or 0,
            'avg': round(subject_stats['avg'], 1) if subject_stats['avg'] else 0,
            'first_date': subject_stats['first_date'],
            'last_date': subject_stats['last_date'],
            'grade_distribution': grade_distribution,
        })
    
    # Статистика по типам оценок
    grades_by_type = []
    for grade_type_code, grade_type_name in Grade.GradeType.choices:
        type_grades = grades_stats.filter(grade_type=grade_type_code)
        count = type_grades.count()
        if count > 0:
            avg_result = type_grades.aggregate(avg=Avg('value'))
            avg = round(avg_result['avg'], 1) if avg_result['avg'] else 0
            percentage = round((count / total_grades * 100), 1) if total_grades > 0 else 0
            
            grades_by_type.append({
                'type': grade_type_code,
                'name': grade_type_name,
                'count': count,
                'avg': avg,
                'percentage': percentage,
            })
    
    # Последние выставленные оценки
    recent_grades = grades_stats.select_related(
        'student', 'subject'
    ).order_by('-date')[:10]
    
    # Студенты, у которых преподаватель преподает
    students_taught = User.objects.filter(
        grades__teacher=user
    ).distinct().count()
    
    context = {
        'teacher_user': user,
        'profile': profile,
        'teacher_subjects': teacher_subjects,
        'teaching_groups': teaching_groups,
        'schedule_by_day': schedule_by_day,
        'total_grades': total_grades,
        'avg_grade': avg_grade,
        'grades_by_subject': grades_by_subject,
        'grades_by_type': grades_by_type,
        'recent_grades': recent_grades,
        'students_taught': students_taught,
        'lesson_count': ScheduleLesson.objects.filter(teacher=user).count(),
        'subject_count': teacher_subjects.count(),
        'group_count': teaching_groups.count(),
    }
    return render(request, 'education_department/teacher_full_detail.html', context)



@login_required
@education_department_required
def teachers_overview(request):
    """Обзорная страница преподавателей с подробной информацией"""
    # Получаем всех преподавателей
    teachers_qs = User.objects.filter(
        Q(groups__name='teacher') | Q(teacher_profile__isnull=False)
    ).distinct().order_by('last_name', 'first_name')
    
    # Фильтры
    search_query = request.GET.get('search', '').strip()
    if search_query:
        teachers_qs = teachers_qs.filter(
            Q(username__icontains=search_query) |
            Q(first_name__icontains=search_query) |
            Q(last_name__icontains=search_query) |
            Q(teacher_profile__patronymic__icontains=search_query)
        ).distinct()
    
    # Подготавливаем детальную информацию об преподавателях
    teachers_info = []
    total_subjects_count = 0  # Счетчик для всех предметов
    total_grades_count = 0     # Счетчик для всех оценок
    
    for user in teachers_qs:
        try:
            profile = user.teacher_profile
            patronymic = profile.patronymic
            phone = profile.phone
            qualification = profile.qualification
            birth_date = profile.birth_date
        except TeacherProfile.DoesNotExist:
            patronymic = ''
            phone = ''
            qualification = ''
            birth_date = None
        
        # Получаем предметы преподавателя
        subjects = TeacherSubject.objects.filter(
            teacher__user=user
        ).select_related('subject')
        
        # Группы, в которых преподает преподаватель
        teaching_groups = StudentGroup.objects.filter(
            daily_schedules__lessons__teacher=user
        ).distinct().order_by('year', 'name')
        
        # Расписание преподавателя
        schedule_lessons = ScheduleLesson.objects.filter(
            teacher=user
        ).select_related(
            'daily_schedule', 'subject', 'daily_schedule__student_group'
        ).order_by('daily_schedule__week_day', 'lesson_number')
        
        # Статистика по оценкам
        grades_stats = Grade.objects.filter(
            teacher=user
        ).aggregate(
            total=Count('id'),
            avg=Avg('value'),
            latest=Max('date')
        )
        
        # Количество студентов у преподавателя (через оценки)
        unique_students = Grade.objects.filter(
            teacher=user
        ).values('student').distinct().count()
        
        subject_count = subjects.count()
        grades_total = grades_stats['total'] or 0
        
        # Добавляем к общим счетчикам
        total_subjects_count += subject_count
        total_grades_count += grades_total
        
        teachers_info.append({
            'id': user.id,
            'user': user,
            'profile': profile if hasattr(user, 'teacher_profile') else None,
            'patronymic': patronymic,
            'phone': phone,
            'qualification': qualification,
            'birth_date': birth_date,
            'subjects': subjects,
            'teaching_groups': teaching_groups,
            'schedule_lessons': schedule_lessons,
            'grades_total': grades_total,
            'grades_avg': round(grades_stats['avg'], 1) if grades_stats['avg'] else 0,
            'grades_latest': grades_stats['latest'],
            'unique_students': unique_students,
            'subject_count': subject_count,
            'group_count': teaching_groups.count(),
            'lesson_count': schedule_lessons.count(),
        })
    
    # Общая статистика
    total_teachers = teachers_qs.count()
    active_teachers = teachers_qs.filter(is_active=True).count()
    
    # Статистика по предметам среди преподавателей
    subject_stats = Subject.objects.filter(
        subject_teachers__isnull=False
    ).annotate(
        teacher_count=Count('subject_teachers', distinct=True)
    ).order_by('-teacher_count')[:10]
    
    context = {
        'teachers_info': teachers_info,
        'search_query': search_query,
        'total_teachers': total_teachers,
        'active_teachers': active_teachers,
        'subject_stats': subject_stats,
        'total_subjects_count': total_subjects_count,  # Добавляем общее количество предметов
        'total_grades_count': total_grades_count,      # Добавляем общее количество оценок
    }
    return render(request, 'education_department/teachers_overview.html', context)


@login_required
@admin_required
def teacher_full_detail_admin(request, teacher_id):
    """Полная детальная информация об учителе (ТОЧНАЯ КОПИЯ ВАШЕЙ ФУНКЦИИ)"""
    user = get_object_or_404(User, id=teacher_id)
    
    # Проверяем, что это преподаватель
    if not user.groups.filter(name='teacher').exists() and not hasattr(user, 'teacher_profile'):
        messages.error(request, 'Пользователь не является преподавателем')
        return redirect('education_department:teachers_overview')
    
    try:
        profile = user.teacher_profile
    except TeacherProfile.DoesNotExist:
        profile = None
        messages.warning(request, 'У преподавателя нет профиля')
    
    # Предметы преподавателя
    teacher_subjects = TeacherSubject.objects.filter(
        teacher__user=user
    ).select_related('subject')
    
    # Группы, в которых преподает преподаватель
    teaching_groups = StudentGroup.objects.filter(
        daily_schedules__lessons__teacher=user
    ).distinct().order_by('year', 'name')
    
    # Детальное расписание преподавателя
    schedule_by_day = {}
    week_dates = get_current_week_dates()
    day_name_map = dict(DailySchedule.WeekDay.choices)

    for day_code, day_date in week_dates.items():
        day_lessons = get_teacher_effective_lessons_for_date(user, day_date)
        if not day_lessons:
            continue

        schedule_by_day[day_code] = {
            'day_name': day_name_map.get(day_code, day_code),
            'lessons': day_lessons,
        }
    
    # Статистика оценок
    grades_stats = Grade.objects.filter(
        teacher=user
    )
    
    total_grades = grades_stats.count()
    avg_grade_result = grades_stats.aggregate(avg=Avg('value'))
    avg_grade = round(avg_grade_result['avg'], 1) if avg_grade_result['avg'] else 0
    
    # Статистика по предметам
    grades_by_subject = []
    for ts in teacher_subjects:
        subject_grades = Grade.objects.filter(
            teacher=user,
            subject=ts.subject
        )
        
        subject_stats = subject_grades.aggregate(
            total=Count('id'),
            avg=Avg('value'),
            first_date=Min('date'),
            last_date=Max('date')
        )
        
        # Распределение оценок по предмету
        grade_distribution = {}
        for value in [5, 4, 3, 2]:
            count = subject_grades.filter(value=value).count()
            if count > 0:
                percentage = round((count / subject_stats['total'] * 100), 1) if subject_stats['total'] > 0 else 0
                grade_distribution[value] = {
                    'count': count,
                    'percentage': percentage
                }
        
        grades_by_subject.append({
            'subject': ts.subject,
            'total': subject_stats['total'] or 0,
            'avg': round(subject_stats['avg'], 1) if subject_stats['avg'] else 0,
            'first_date': subject_stats['first_date'],
            'last_date': subject_stats['last_date'],
            'grade_distribution': grade_distribution,
        })
    
    # Статистика по типам оценок
    grades_by_type = []
    for grade_type_code, grade_type_name in Grade.GradeType.choices:
        type_grades = grades_stats.filter(grade_type=grade_type_code)
        count = type_grades.count()
        if count > 0:
            avg_result = type_grades.aggregate(avg=Avg('value'))
            avg = round(avg_result['avg'], 1) if avg_result['avg'] else 0
            percentage = round((count / total_grades * 100), 1) if total_grades > 0 else 0
            
            grades_by_type.append({
                'type': grade_type_code,
                'name': grade_type_name,
                'count': count,
                'avg': avg,
                'percentage': percentage,
            })
    
    # Последние выставленные оценки
    recent_grades = grades_stats.select_related(
        'student', 'subject'
    ).order_by('-date')[:10]
    
    # Студенты, у которых преподаватель преподает
    students_taught = User.objects.filter(
        grades__teacher=user
    ).distinct().count()
    
    context = {
        'teacher_user': user,
        'profile': profile,
        'teacher_subjects': teacher_subjects,
        'teaching_groups': teaching_groups,
        'schedule_by_day': schedule_by_day,
        'total_grades': total_grades,
        'avg_grade': avg_grade,
        'grades_by_subject': grades_by_subject,
        'grades_by_type': grades_by_type,
        'recent_grades': recent_grades,
        'students_taught': students_taught,
        'lesson_count': ScheduleLesson.objects.filter(teacher=user).count(),
        'subject_count': teacher_subjects.count(),
        'group_count': teaching_groups.count(),
    }
    return render(request, 'education_department/teacher_full_detail.html', context)


@login_required
@education_department_required
def teacher_subject_performance(request, teacher_id, subject_id):
    """Производительность преподавателя по конкретному предмету (ТОЧНАЯ КОПИЯ ВАШЕЙ ФУНКЦИИ)"""
    user = get_object_or_404(User, id=teacher_id)
    subject = get_object_or_404(Subject, id=subject_id)
    
    # Проверяем, что преподаватель преподает этот предмет
    if not TeacherSubject.objects.filter(
        teacher__user=user,
        subject=subject
    ).exists():
        messages.error(request, f'Преподаватель не преподает предмет "{subject.name}"')
        return redirect('education_department:teacher_full_detail', teacher_id=teacher_id)
    
    # Группы, в которых преподаватель ведет этот предмет
    teaching_groups = StudentGroup.objects.filter(
        daily_schedules__lessons__teacher=user,
        daily_schedules__lessons__subject=subject
    ).distinct().order_by('year', 'name')
    
    # Оценки преподавателя по этому предмету
    grades = Grade.objects.filter(
        teacher=user,
        subject=subject
    ).select_related('student', 'schedule_lesson__daily_schedule__student_group')
    
    total_grades = grades.count()
    avg_grade_result = grades.aggregate(avg=Avg('value'))
    avg_grade = round(avg_grade_result['avg'], 1) if avg_grade_result['avg'] else 0
    
    # Статистика по месяцам
    monthly_stats = []
    monthly_data = grades.annotate(
        month=TruncMonth('date')
    ).values('month').annotate(
        count=Count('id'),
        avg=Avg('value')
    ).order_by('-month')[:12]  # Последние 12 месяцев
    
    for stat in monthly_data:
        monthly_stats.append({
            'month': stat['month'].strftime('%Y-%m'),
            'month_name': calendar.month_name[stat['month'].month],
            'year': stat['month'].year,
            'count': stat['count'],
            'avg': round(stat['avg'], 1) if stat['avg'] else 0,
        })
    
    # Статистика по группам
    group_stats = []
    for group in teaching_groups:
        group_grades = grades.filter(
            schedule_lesson__daily_schedule__student_group=group
        )
        group_total = group_grades.count()
        
        if group_total > 0:
            group_avg_result = group_grades.aggregate(avg=Avg('value'))
            group_avg = round(group_avg_result['avg'], 1) if group_avg_result['avg'] else 0
            
            group_stats.append({
                'group': group,
                'total': group_total,
                'avg': group_avg,
            })
    
    # Распределение оценок
    grade_distribution = {}
    for value in [5, 4, 3, 2]:
        count = grades.filter(value=value).count()
        if count > 0:
            percentage = round((count / total_grades * 100), 1) if total_grades > 0 else 0
            grade_distribution[value] = {
                'count': count,
                'percentage': percentage
            }
    
    # Последние оценки
    recent_grades = grades.order_by('-date')[:20]
    
    context = {
        'teacher_user': user,
        'subject': subject,
        'teaching_groups': teaching_groups,
        'total_grades': total_grades,
        'avg_grade': avg_grade,
        'monthly_stats': monthly_stats,
        'group_stats': group_stats,
        'grade_distribution': grade_distribution,
        'recent_grades': recent_grades,
    }
    return render(request, 'education_department/teacher_subject_performance.html', context)


# ===== ДОПОЛНИТЕЛЬНЫЕ ФУНКЦИИ ДЛЯ НОВОГО ПРИЛОЖЕНИЯ =====

@login_required
@education_department_required
def department_dashboard(request):
    """Главная панель учебного отдела"""
    # Статистика
    total_groups = StudentGroup.objects.count()
    total_students = StudentProfile.objects.count()
    total_teachers = TeacherProfile.objects.count()
    total_subjects = Subject.objects.count()
    
    # Последние оценки
    recent_grades = Grade.objects.select_related(
        'student', 'subject', 'teacher'
    ).order_by('-date')[:10]
    
    # Последние домашние задания
    recent_homeworks = Homework.objects.select_related(
        'student_group', 'schedule_lesson__subject'
    ).order_by('-created_at')[:5]
    
    context = {
        'total_groups': total_groups,
        'total_students': total_students,
        'total_teachers': total_teachers,
        'total_subjects': total_subjects,
        'recent_grades': recent_grades,
        'recent_homeworks': recent_homeworks,
    }
    return render(request, 'education_department/dashboard.html', context)


# Заглушки для будущих функций
@login_required
@education_department_required
def homework_overview(request):
    """Обзор домашних заданий (ЗАГЛУШКА)"""
    messages.info(request, 'Функция домашних заданий находится в разработке')
    return render(request, 'education_department/homework/overview.html')


@login_required
@education_department_required
def schedule_management(request):
    """Управление расписанием (ЗАГЛУШКА - используем существующее приложение schedule)"""
    messages.info(request, 'Управление расписанием находится в отдельном приложении')
    return redirect('schedule:dashboard')

WEEKDAY_MAP = {
    0: "MON",
    1: "TUE",
    2: "WED",
    3: "THU",
    4: "FRI",
    5: "SAT",
    6: "SUN",
}


@login_required
@education_department_required
def lesson_replacements(request):
    """Manage one-time replacements via current-week schedule selection."""
    selected_group = (request.GET.get("group") or "").strip()
    selected_date = (request.GET.get("date") or "").strip()

    if request.method == "POST":
        replacement_date_raw = (request.POST.get("replacement_date") or "").strip()
        group_id = (request.POST.get("group_id") or "").strip()
        original_lesson_id = (request.POST.get("original_lesson_id") or "").strip()
        replacement_subject_id = (request.POST.get("replacement_subject_id") or "").strip()
        replacement_teacher_id = (request.POST.get("replacement_teacher_id") or "").strip()
        reason = (request.POST.get("reason") or "").strip()

        if not all([
            replacement_date_raw,
            group_id,
            original_lesson_id,
            replacement_subject_id,
            replacement_teacher_id,
        ]):
            messages.error(request, "Выберите пара из расписания недели и заполните обязательные поля.")
            return redirect(f"{reverse('education_department:lesson_replacements')}?group={group_id}")

        try:
            replacement_date = date.fromisoformat(replacement_date_raw)
        except (TypeError, ValueError):
            messages.error(request, "Некорректная дата замены.")
            return redirect(f"{reverse('education_department:lesson_replacements')}?group={group_id}")

        original_lesson = get_object_or_404(
            ScheduleLesson.objects.select_related(
                "daily_schedule",
                "subject",
                "teacher",
                "daily_schedule__student_group",
            ),
            id=original_lesson_id,
        )

        if str(original_lesson.daily_schedule.student_group_id) != str(group_id):
            messages.error(request, "Выбранная пара не принадлежит указанной группе.")
            return redirect(f"{reverse('education_department:lesson_replacements')}?group={group_id}")

        expected_day_code = WEEKDAY_MAP[replacement_date.weekday()]
        if original_lesson.daily_schedule.week_day != expected_day_code:
            messages.error(request, "Дата замены должна соответствовать дню недели выбранного пары.")
            return redirect(f"{reverse('education_department:lesson_replacements')}?group={group_id}")

        replacement_subject = get_object_or_404(Subject, id=replacement_subject_id)
        replacement_teacher = get_object_or_404(User, id=replacement_teacher_id)

        if not hasattr(replacement_teacher, "teacher_profile"):
            messages.error(request, "Выбранный пользователь не является преподавателем.")
            return redirect(f"{reverse('education_department:lesson_replacements')}?group={group_id}")

        teacher_profile = replacement_teacher.teacher_profile
        if not TeacherSubject.objects.filter(
            teacher=teacher_profile,
            subject=replacement_subject
        ).exists():
            messages.error(request, "Преподаватель не закреплен за выбранным предметом.")
            return redirect(f"{reverse('education_department:lesson_replacements')}?group={group_id}")

        replacement, created = LessonReplacement.objects.update_or_create(
            replacement_date=replacement_date,
            original_lesson=original_lesson,
            defaults={
                "replacement_subject": replacement_subject,
                "replacement_teacher": replacement_teacher,
                "reason": reason,
                "created_by": request.user,
            },
        )

        if created:
            messages.success(request, "Замена добавлена.")
        else:
            messages.success(request, "Замена обновлена.")

        return redirect(f"{reverse('education_department:lesson_replacements')}?group={group_id}")

    replacements_qs = LessonReplacement.objects.select_related(
        "original_lesson__daily_schedule__student_group",
        "original_lesson__subject",
        "original_lesson__teacher",
        "replacement_subject",
        "replacement_teacher",
        "created_by",
    )

    if selected_group:
        replacements_qs = replacements_qs.filter(
            original_lesson__daily_schedule__student_group_id=selected_group
        )
    if selected_date:
        replacements_qs = replacements_qs.filter(replacement_date=selected_date)

    groups = StudentGroup.objects.all().order_by("year", "name")
    subjects = Subject.objects.all().order_by("name")
    teachers = User.objects.filter(
        teacher_profile__isnull=False
    ).select_related("teacher_profile").order_by("last_name", "first_name")

    selected_group_obj = None
    week_schedule = []
    week_range_label = ""
    today_iso = timezone.localdate().isoformat()

    if selected_group:
        selected_group_obj = get_object_or_404(StudentGroup, id=selected_group)
        today = timezone.localdate()
        week_start = today - timedelta(days=today.weekday())
        week_end = week_start + timedelta(days=6)
        week_range_label = f"{week_start.strftime('%d.%m.%Y')} - {week_end.strftime('%d.%m.%Y')}"

        daily_schedules = DailySchedule.objects.filter(
            student_group=selected_group_obj
        ).order_by("week_day")
        schedule_map = {item.week_day: item for item in daily_schedules}

        day_name_map = dict(DailySchedule.WeekDay.choices)

        for offset in range(7):
            current_date = week_start + timedelta(days=offset)
            day_code = WEEKDAY_MAP[offset]
            day_name = day_name_map.get(day_code, day_code)
            daily_schedule = schedule_map.get(day_code)
            is_weekend = bool(daily_schedule.is_weekend) if daily_schedule else (day_code == "SUN")
            lessons = []

            if daily_schedule and not is_weekend:
                lessons = list(
                    ScheduleLesson.objects.filter(daily_schedule=daily_schedule)
                    .select_related("subject", "teacher")
                    .order_by("lesson_number")
                )

            week_schedule.append({
                "date": current_date,
                "day_code": day_code,
                "day_name": day_name,
                "lessons": lessons,
                "is_weekend": is_weekend,
            })

    teacher_subject_map = {}
    teacher_subject_links = TeacherSubject.objects.select_related("teacher", "subject")
    for link in teacher_subject_links:
        teacher_user_id = str(link.teacher.user_id)
        teacher_subject_map.setdefault(teacher_user_id, [])
        if link.subject_id not in teacher_subject_map[teacher_user_id]:
            teacher_subject_map[teacher_user_id].append(link.subject_id)

    context = {
        "groups": groups,
        "subjects": subjects,
        "teachers": teachers,
        "replacements": replacements_qs.order_by(
            "-replacement_date",
            "original_lesson__daily_schedule__student_group__year",
            "original_lesson__daily_schedule__student_group__name",
            "original_lesson__lesson_number",
        ),
        "selected_group": selected_group,
        "selected_group_obj": selected_group_obj,
        "selected_date": selected_date,
        "teacher_subject_map": teacher_subject_map,
        "week_schedule": week_schedule,
        "week_range_label": week_range_label,
        "today_iso": today_iso,
    }
    return render(
        request,
        "education_department/lesson_replacements.html",
        context,
    )


@require_POST
@login_required
@education_department_required
def lesson_replacement_delete(request, replacement_id):
    replacement = get_object_or_404(LessonReplacement, id=replacement_id)
    replacement.delete()
    messages.success(request, "Замена удалена.")
    return redirect("education_department:lesson_replacements")


from django.db.models import Count, Avg, Q
from django.utils import timezone
from datetime import timedelta
from collections import defaultdict


@login_required
@education_department_required
def homework_stats(request):
    """Homework statistics with corrected submission and overdue calculations."""

    # Filters
    year = request.GET.get('year', '')
    group_id = request.GET.get('group', '')
    subject_id = request.GET.get('subject', '')

    # Base queryset
    homeworks_qs = Homework.objects.select_related(
        'student_group',
        'schedule_lesson',
        'schedule_lesson__subject',
    )

    if year:
        homeworks_qs = homeworks_qs.filter(created_at__year=year)
    if group_id:
        homeworks_qs = homeworks_qs.filter(student_group_id=group_id)
    if subject_id:
        homeworks_qs = homeworks_qs.filter(schedule_lesson__subject_id=subject_id)

    homeworks = list(homeworks_qs)
    homework_ids = [hw.id for hw in homeworks]

    submissions = []
    if homework_ids:
        submissions = list(
            HomeworkSubmission.objects.filter(homework_id__in=homework_ids).select_related(
                'homework',
                'student',
                'homework__schedule_lesson__subject',
            )
        )

    total_homeworks = len(homeworks)
    total_submissions = len(submissions)

    # Students per group for "expected submissions" calculation
    group_ids = {hw.student_group_id for hw in homeworks}
    students_by_group = {}
    if group_ids:
        students_by_group = dict(
            StudentProfile.objects.filter(student_group_id__in=group_ids)
            .values('student_group_id')
            .annotate(total=Count('pk'))
            .values_list('student_group_id', 'total')
        )

    homeworks_by_group = defaultdict(list)
    homeworks_by_subject = defaultdict(list)
    submissions_by_homework = defaultdict(int)
    submissions_by_group = defaultdict(int)
    submissions_by_subject = defaultdict(int)
    on_time_by_subject = defaultdict(int)

    active_students_set = set()
    on_time_submissions = 0
    now = timezone.now()

    for hw in homeworks:
        homeworks_by_group[hw.student_group_id].append(hw)
        homeworks_by_subject[hw.schedule_lesson.subject_id].append(hw)

    for submission in submissions:
        hw = submission.homework
        group_pk = hw.student_group_id
        subject_pk = hw.schedule_lesson.subject_id

        submissions_by_homework[submission.homework_id] += 1
        submissions_by_group[group_pk] += 1
        submissions_by_subject[subject_pk] += 1
        active_students_set.add(submission.student_id)

        if submission.submitted_at <= hw.due_date:
            on_time_submissions += 1
            on_time_by_subject[subject_pk] += 1

    # Core metrics
    total_expected_submissions = sum(
        students_by_group.get(hw.student_group_id, 0) for hw in homeworks
    )

    completion_rate = (
        (total_submissions / total_expected_submissions) * 100
        if total_expected_submissions else 0
    )
    on_time_rate = (
        (on_time_submissions / total_submissions) * 100
        if total_submissions else 0
    )
    active_students = len(active_students_set)

    overdue_count = 0
    overdue_list = []
    for hw in homeworks:
        students_in_group = students_by_group.get(hw.student_group_id, 0)
        submitted_count = submissions_by_homework.get(hw.id, 0)
        not_submitted = max(students_in_group - submitted_count, 0)

        if hw.due_date < now and not_submitted > 0:
            overdue_count += 1
            overdue_list.append({
                'student_group': hw.student_group,
                'schedule_lesson': hw.schedule_lesson,
                'title': hw.title,
                'due_date': hw.due_date,
                'days_overdue': max((now - hw.due_date).days, 0),
                'not_submitted_count': not_submitted,
            })

    overdue_list.sort(key=lambda item: item['days_overdue'], reverse=True)

    # Trend placeholders
    homeworks_trend = 0
    overdue_trend = 0

    # Group rating by completion
    group_ratings = []
    groups_with_homework = StudentGroup.objects.filter(
        id__in=homeworks_by_group.keys()
    ).order_by('year', 'name')

    for group in groups_with_homework:
        students_in_group = students_by_group.get(group.id, 0)
        group_homeworks_count = len(homeworks_by_group.get(group.id, []))
        total_possible_submissions = students_in_group * group_homeworks_count

        if total_possible_submissions == 0:
            continue

        group_submissions = submissions_by_group.get(group.id, 0)
        group_completion = (group_submissions / total_possible_submissions) * 100

        group_ratings.append({
            'group': group,
            'completion_rate': group_completion,
            'submissions_count': group_submissions,
            'students_count': students_in_group,
        })

    group_ratings.sort(key=lambda x: x['completion_rate'], reverse=True)

    # Data for filters/tables
    groups = StudentGroup.objects.all().order_by('year', 'name')
    subjects = Subject.objects.all().order_by('name')

    # Subject stats and problematic subjects
    subject_stats = []
    problematic_subjects = []

    for subject in subjects:
        subject_homeworks = homeworks_by_subject.get(subject.id, [])
        if not subject_homeworks:
            continue

        total_hw_count = len(subject_homeworks)
        subject_submissions_count = submissions_by_subject.get(subject.id, 0)
        subject_on_time_count = on_time_by_subject.get(subject.id, 0)

        total_possible = sum(
            students_by_group.get(hw.student_group_id, 0) for hw in subject_homeworks
        )

        subject_completion_rate = (
            (subject_submissions_count / total_possible) * 100
            if total_possible else 0
        )
        subject_on_time_rate = (
            (subject_on_time_count / subject_submissions_count) * 100
            if subject_submissions_count else 0
        )

        subject_overdue = 0
        for hw in subject_homeworks:
            students_in_group = students_by_group.get(hw.student_group_id, 0)
            submitted_count = submissions_by_homework.get(hw.id, 0)
            not_submitted = max(students_in_group - submitted_count, 0)
            if hw.due_date < now and not_submitted > 0:
                subject_overdue += 1

        subject_stats.append({
            'subject': subject,
            'total': total_hw_count,
            'completion_rate': subject_completion_rate,
            'on_time_count': subject_on_time_count,
            'on_time_rate': subject_on_time_rate,
            'overdue_count': subject_overdue,
            'submissions_count': subject_submissions_count,
            'trend': 0,
        })

        if total_possible > 0 and subject_completion_rate < 50:
            problematic_subjects.append({
                'subject': subject,
                'completion_rate': subject_completion_rate,
                'overdue_count': subject_overdue,
                'submissions_count': subject_submissions_count,
            })

    subject_stats.sort(key=lambda x: x['completion_rate'], reverse=True)

    # Daily activity (last 30 days including today)
    start_day = now.date() - timedelta(days=29)
    daily_counts = defaultdict(int)
    for submission in submissions:
        day = submission.submitted_at.date()
        if day >= start_day:
            daily_counts[day] += 1

    max_daily = max(daily_counts.values(), default=1)
    daily_activity = []
    for i in range(30):
        day = start_day + timedelta(days=i)
        day_submissions = daily_counts.get(day, 0)
        daily_activity.append({
            'date': day,
            'count': day_submissions,
            'height': int((day_submissions / max_daily) * 60),
            'opacity': min(1, 0.3 + (day_submissions / max_daily * 0.7)),
        })

    context = {
        'filters': {
            'year': year,
            'group': group_id,
            'subject': subject_id,
        },
        'groups': groups,
        'subjects': subjects,
        'metrics': {
            'total_homeworks': total_homeworks,
            'homeworks_trend': homeworks_trend,
            'completion_rate': completion_rate,
            'on_time_rate': on_time_rate,
            'overdue_count': overdue_count,
            'overdue_trend': overdue_trend,
            'active_students': active_students,
            'total_submissions': total_submissions,
            'expected_submissions': total_expected_submissions,
            'missing_submissions': max(total_expected_submissions - total_submissions, 0),
        },
        'group_ratings': group_ratings[:10],
        'problematic_subjects': problematic_subjects,
        'subject_stats': subject_stats,
        'daily_activity': daily_activity,
        'overdue_homeworks': overdue_list[:10],
    }

    return render(request, 'education_department/homework_stats.html', context)


from io import BytesIO
import os

from django.conf import settings
from django.http import HttpResponse
from django.utils import timezone
from django.db.models import Avg, Count

from reportlab.lib.pagesizes import A4
from reportlab.lib import colors
from reportlab.lib.units import mm
from reportlab.platypus import SimpleDocTemplate, Paragraph, Table, TableStyle, Spacer
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfbase import pdfmetrics


def _safe_float(v, default=0.0):
    try:
        return float(v)
    except Exception:
        return default


@login_required
@education_department_required
def grades_school_report_pdf(request):
    """
    PDF отчёт по общей статистике оценок по школе (без CRUD).
    """

    # ====== агрегаты "по школе" ======
    total_groups = StudentGroup.objects.count()
    total_students = StudentProfile.objects.count()
    total_grades = Grade.objects.count()

    overall_avg_val = Grade.objects.aggregate(avg=Avg("value"))["avg"]
    overall_avg = round(_safe_float(overall_avg_val, 0.0), 2) if overall_avg_val else 0

    groups_without_curator = StudentGroup.objects.filter(curator__isnull=True).count()

    # распределение оценок (пример по целым: 5,4,3,2)
    dist = {v: Grade.objects.filter(value=v).count() for v in [5, 4, 3, 2]}

    # топ-5 предметов по количеству оценок (надёжно через Grade)
    top_subjects = (
        Grade.objects
        .values("subject__name")
        .annotate(grades_cnt=Count("id"))
        .order_by("-grades_cnt", "subject__name")[:5]
    )

    # топ-5 групп по среднему баллу (где есть оценки)
    groups_avg = (
        StudentGroup.objects
        .annotate(
            grades_cnt=Count("students__user__grades", distinct=True),
            avg_grade=Avg("students__user__grades__value"),
            student_cnt=Count("students", distinct=True),
        )
        .filter(grades_cnt__gt=0)
        .order_by("-avg_grade")[:5]
    )

    # ====== PDF ======
    buffer = BytesIO()

    # шрифт из проекта
    font_path = os.path.join(settings.BASE_DIR, "static", "fonts", "ARIAL.TTF")

    try:
        pdfmetrics.registerFont(TTFont("Arial", font_path))
        base_font = "Arial"
    except Exception:
        base_font = "Helvetica"  # если шрифт не найден, кириллица может сломаться

    styles = getSampleStyleSheet()
    normal = styles["Normal"]
    title = styles["Title"]
    h2 = styles["Heading2"]
    h3 = styles["Heading3"]

    for st in (normal, title, h2, h3):
        st.fontName = base_font

    doc = SimpleDocTemplate(
        buffer,
        pagesize=A4,
        leftMargin=18 * mm,
        rightMargin=18 * mm,
        topMargin=15 * mm,
        bottomMargin=15 * mm,
        title="Отчёт по оценкам",
    )

    story = []

    report_date = timezone.localtime(timezone.now()).strftime("%d.%m.%Y %H:%M")

    story.append(Paragraph("ОТЧЁТ", title))
    story.append(Paragraph("Общая статистика оценок по школе", h2))
    story.append(Spacer(1, 6))
    story.append(Paragraph(f"Дата формирования: {report_date}", normal))
    story.append(Spacer(1, 12))

    # 1) Общая сводка
    summary_data = [
        ["Показатель", "Значение"],
        ["Всего групп", str(total_groups)],
        ["Всего студентов", str(total_students)],
        ["Всего оценок", str(total_grades)],
        ["Средний балл (по школе)", (f"{overall_avg:.2f}" if overall_avg else "—")],
        ["Групп без куратора", str(groups_without_curator)],
    ]
    summary_table = Table(summary_data, colWidths=[110 * mm, 60 * mm])
    summary_table.setStyle(TableStyle([
        ("FONTNAME", (0, 0), (-1, -1), base_font),
        ("FONTSIZE", (0, 0), (-1, -1), 10),
        ("BACKGROUND", (0, 0), (-1, 0), colors.HexColor("#f2f4f7")),
        ("GRID", (0, 0), (-1, -1), 0.5, colors.HexColor("#d0d5dd")),
        ("ALIGN", (1, 1), (1, -1), "RIGHT"),
        ("VALIGN", (0, 0), (-1, -1), "MIDDLE"),
        ("PADDING", (0, 0), (-1, -1), 6),
    ]))
    story.append(Paragraph("1) Общая сводка", h3))
    story.append(summary_table)
    story.append(Spacer(1, 12))

    # 2) Распределение оценок
    dist_data = [
        ["Оценка", "Количество"],
        ["5", str(dist[5])],
        ["4", str(dist[4])],
        ["3", str(dist[3])],
        ["2", str(dist[2])],
    ]
    dist_table = Table(dist_data, colWidths=[50 * mm, 120 * mm])
    dist_table.setStyle(TableStyle([
        ("FONTNAME", (0, 0), (-1, -1), base_font),
        ("FONTSIZE", (0, 0), (-1, -1), 10),
        ("BACKGROUND", (0, 0), (-1, 0), colors.HexColor("#f2f4f7")),
        ("GRID", (0, 0), (-1, -1), 0.5, colors.HexColor("#d0d5dd")),
        ("ALIGN", (1, 1), (1, -1), "RIGHT"),
        ("PADDING", (0, 0), (-1, -1), 6),
    ]))
    story.append(Paragraph("2) Распределение оценок", h3))
    story.append(dist_table)
    story.append(Spacer(1, 12))

    # 3) Топ предметов
    subj_data = [["Предмет", "Оценок"]]
    for s in top_subjects:
        subj_data.append([s["subject__name"] or "—", str(s["grades_cnt"] or 0)])

    subj_table = Table(subj_data, colWidths=[130 * mm, 40 * mm])
    subj_table.setStyle(TableStyle([
        ("FONTNAME", (0, 0), (-1, -1), base_font),
        ("FONTSIZE", (0, 0), (-1, -1), 10),
        ("BACKGROUND", (0, 0), (-1, 0), colors.HexColor("#f2f4f7")),
        ("GRID", (0, 0), (-1, -1), 0.5, colors.HexColor("#d0d5dd")),
        ("ALIGN", (1, 1), (1, -1), "RIGHT"),
        ("PADDING", (0, 0), (-1, -1), 6),
    ]))
    story.append(Paragraph("3) Топ-5 предметов по количеству оценок", h3))
    story.append(subj_table)
    story.append(Spacer(1, 12))

    # 4) Топ групп
    grp_data = [["Группа", "Студентов", "Оценок", "Средний балл"]]
    for g in groups_avg:
        grp_data.append([
            f"{g.name} ({g.year} год)",
            str(g.student_cnt or 0),
            str(g.grades_cnt or 0),
            f"{_safe_float(g.avg_grade, 0.0):.2f}" if g.avg_grade else "—",
        ])

    grp_table = Table(grp_data, colWidths=[85 * mm, 30 * mm, 25 * mm, 30 * mm])
    grp_table.setStyle(TableStyle([
        ("FONTNAME", (0, 0), (-1, -1), base_font),
        ("FONTSIZE", (0, 0), (-1, -1), 10),
        ("BACKGROUND", (0, 0), (-1, 0), colors.HexColor("#f2f4f7")),
        ("GRID", (0, 0), (-1, -1), 0.5, colors.HexColor("#d0d5dd")),
        ("ALIGN", (1, 1), (-1, -1), "RIGHT"),
        ("ALIGN", (0, 0), (0, -1), "LEFT"),
        ("PADDING", (0, 0), (-1, -1), 6),
    ]))
    story.append(Paragraph("4) Топ-5 групп по среднему баллу (где есть оценки)", h3))
    story.append(grp_table)
    story.append(Spacer(1, 18))

    story.append(Paragraph("Подпись ответственного: ____________________", normal))
    story.append(Spacer(1, 6))
    story.append(Paragraph("М.П.", normal))

    doc.build(story)

    pdf = buffer.getvalue()
    buffer.close()

    filename = f"school_grades_report_{timezone.localtime(timezone.now()).strftime('%Y%m%d_%H%M')}.pdf"
    response = HttpResponse(content_type="application/pdf")
    response["Content-Disposition"] = f'attachment; filename="{filename}"'
    response.write(pdf)
    return response





from django.shortcuts import redirect
from functools import wraps
from django.contrib import messages


def custom_login_required(view_func):
    @wraps(view_func)
    def _wrapped_view(request, *args, **kwargs):
        if request.user.is_authenticated:
            return view_func(request, *args, **kwargs)
        return redirect('/')
    return _wrapped_view


def admin_required(view_func):
    @wraps(view_func)
    def _wrapped_view(request, *args, **kwargs):
        if not request.user.is_authenticated:
            return redirect('/')

        is_admin = request.user.is_superuser or request.user.groups.filter(name='admin').exists()

        if not is_admin:
            messages.error(request, 'Доступ только для администраторов')
            return redirect('dashboard_page')

        return view_func(request, *args, **kwargs)
    return _wrapped_view


def student_required(view_func):
    @wraps(view_func)
    def _wrapped_view(request, *args, **kwargs):
        if not request.user.is_authenticated:
            return redirect('/')

        is_student = request.user.groups.filter(name='student').exists()

        if not is_student:
            messages.error(request, 'Доступ только для студентов')

            if request.user.is_superuser or request.user.groups.filter(name='admin').exists():
                return redirect('admin_dashboard_page')
            else:
                return redirect('dashboard_page')

        return view_func(request, *args, **kwargs)
    return _wrapped_view


def education_department_required(view_func):
    """Декоратор для проверки прав учебного отдела"""
    @wraps(view_func)
    def _wrapped_view(request, *args, **kwargs):
        if not request.user.is_authenticated:
            messages.error(request, 'Требуется авторизация')
            return redirect('login_page')


        is_allowed = (
            request.user.is_superuser or
            request.user.groups.filter(name='admin').exists() or
            request.user.groups.filter(name='education_department').exists()
        )

        if not is_allowed:
            messages.error(request, 'Доступ только для сотрудников учебного отдела')
            return redirect('dashboard_page')

        return view_func(request, *args, **kwargs)
    return _wrapped_view

import os
import json
import hashlib
import shutil
import subprocess
import tempfile
from datetime import datetime, timedelta
from django.conf import settings
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.db import connection
from django.http import HttpResponse, FileResponse, JsonResponse
from django.shortcuts import render, redirect, get_object_or_404
from django.urls import reverse
from django.utils import timezone
from django.views.decorators.http import require_http_methods

from .models import DatabaseBackup, BackupSchedule, BackupLog


def admin_required(view_func):
    def wrapper(request, *args, **kwargs):
        if not request.user.is_authenticated:
            return redirect('login_page')
        if not (request.user.is_superuser or request.user.groups.filter(name='admin').exists()):
            messages.error(request, 'Доступ запрещен. Требуются права администратора.')
            return redirect('dashboard_page')
        return view_func(request, *args, **kwargs)
    return wrapper


@login_required
@admin_required
def backup_list(request):
    """Список всех резервных копий"""
    backups = DatabaseBackup.objects.all()


    status_filter = request.GET.get('status', '')
    type_filter = request.GET.get('type', '')

    if status_filter:
        backups = backups.filter(status=status_filter)
    if type_filter:
        backups = backups.filter(backup_type=type_filter)


    page_number = request.GET.get('page', 1)
    paginator = Paginator(backups, 20)
    page_obj = paginator.get_page(page_number)


    total_backups = backups.count()
    total_size = sum(b.file_size for b in backups if b.file_size)
    last_backup = backups.filter(status='completed').first()

    context = {
        'backups': page_obj,
        'page_obj': page_obj,
        'is_paginated': page_obj.has_other_pages(),
        'total_backups': total_backups,
        'total_size': total_size,
        'total_size_display': format_size(total_size),
        'last_backup': last_backup,
        'status_filter': status_filter,
        'type_filter': type_filter,
        'status_choices': DatabaseBackup.STATUS_CHOICES,
        'type_choices': DatabaseBackup.BACKUP_TYPES,
    }
    return render(request, 'backup_service/backup_list.html', context)


@login_required
@admin_required
def backup_create(request):
    """Создание новой резервной копии"""
    if request.method == 'POST':
        name = request.POST.get('name', '').strip()
        description = request.POST.get('description', '').strip()

        if not name:
            messages.error(request, 'Введите название резервной копии')
            return redirect('backup_service:backup_create')


        backup = DatabaseBackup.objects.create(
            name=name,
            description=description,
            backup_type='manual',
            status='pending',
            created_by=request.user
        )


        try:
            result = create_database_backup(backup)

            if result['success']:
                backup.status = 'completed'
                backup.completed_at = timezone.now()
                backup.file_path = result['file_path']
                backup.file_size = result['file_size']
                backup.filename = os.path.basename(result['file_path'])


                backup.database_name = settings.DATABASES['default']['NAME']
                backup.tables_count = result.get('tables_count', 0)
                backup.row_count = result.get('row_count', 0)

                backup.save()


                BackupLog.objects.create(
                    backup=backup,
                    action='create',
                    user=request.user,
                    details=f"Создана резервная копия {backup.filename}",
                    ip_address=get_client_ip(request)
                )

                messages.success(request, f'✅ Резервная копия "{name}" успешно создана')
            else:
                backup.status = 'failed'
                backup.error_message = result.get('error', 'Неизвестная ошибка')
                backup.save()
                messages.error(request, f'❌ Ошибка при создании бэкапа: {result.get("error")}')

        except Exception as e:
            backup.status = 'failed'
            backup.error_message = str(e)
            backup.save()
            messages.error(request, f'❌ Ошибка: {str(e)}')

        return redirect('backup_service:backup_list')


    db_info = get_database_info()

    context = {
        'db_info': db_info,
    }
    return render(request, 'backup_service/backup_create.html', context)


@login_required
@admin_required
def backup_detail(request, backup_id):
    """Детальная информация о резервной копии"""
    get_object_or_404(DatabaseBackup, id=backup_id)
    messages.info(request, 'Backup details are disabled. Use backups list.')
    return redirect('backup_service:backup_list')


@login_required
@admin_required
def backup_download(request, backup_id):
    """Скачивание резервной копии"""
    backup = get_object_or_404(DatabaseBackup, id=backup_id)

    if backup.status != 'completed' or not backup.file_path:
        messages.error(request, 'Файл резервной копии недоступен')
        return redirect('backup_service:backup_list')

    if not os.path.exists(backup.file_path):
        messages.error(request, 'Файл не найден на сервере')
        return redirect('backup_service:backup_list')


    BackupLog.objects.create(
        backup=backup,
        action='download',
        user=request.user,
        ip_address=get_client_ip(request)
    )

    response = FileResponse(
        open(backup.file_path, 'rb'),
        as_attachment=True,
        filename=backup.filename or f"backup_{backup.id}.sql"
    )
    return response


@login_required
@admin_required
@require_http_methods(["POST"])
def backup_delete(request, backup_id):
    """Удаление резервной копии"""
    backup = get_object_or_404(DatabaseBackup, id=backup_id)


    BackupLog.objects.create(
        backup=backup,
        action='delete',
        user=request.user,
        ip_address=get_client_ip(request)
    )

    backup_name = backup.name
    backup.delete()

    messages.success(request, f'Резервная копия "{backup_name}" удалена')
    return redirect('backup_service:backup_list')


@login_required
@admin_required
def backup_restore(request, backup_id):
    """Restore the current DB from a selected backup."""
    backup = get_object_or_404(DatabaseBackup, id=backup_id)

    if request.method != 'POST':
        messages.info(request, 'Run restore from backups list action button.')
        return redirect('backup_service:backup_list')

    confirm = request.POST.get('confirm')
    if confirm != 'CONFIRM':
        messages.error(request, 'Restore confirmation failed.')
        return redirect('backup_service:backup_list')

    if backup.status != 'completed':
        messages.error(request, 'Only completed backups can be restored.')
        return redirect('backup_service:backup_list')

    if not backup.file_path or not os.path.exists(backup.file_path):
        messages.error(request, 'Backup file was not found on the server.')
        return redirect('backup_service:backup_list')

    backup.status = 'restoring'
    backup.save(update_fields=['status'])

    try:
        result = restore_database_from_backup(backup)
        backup.status = 'completed'
        backup.save(update_fields=['status'])

        if result.get('success'):
            BackupLog.objects.create(
                backup=backup,
                action='restore',
                user=request.user,
                details=f'Restored from backup file {backup.filename or backup.name}',
                ip_address=get_client_ip(request)
            )
            messages.success(request, 'Database restored successfully.')
        else:
            messages.error(request, f'Restore failed: {result.get("error", "Unknown error")}')

    except Exception as e:
        backup.status = 'completed'
        backup.save(update_fields=['status'])
        messages.error(request, f'Restore failed: {str(e)}')

    return redirect('backup_service:backup_list')

@login_required
@admin_required
def schedule_list(request):
    """Список расписаний бэкапов"""
    schedules = BackupSchedule.objects.all()

    context = {
        'schedules': schedules,
    }
    return render(request, 'backup_service/schedule_list.html', context)


@login_required
@admin_required
def schedule_create(request):
    """Создание расписания"""
    if request.method == 'POST':
        name = request.POST.get('name', '').strip()
        frequency = request.POST.get('frequency', 'daily')
        time_str = request.POST.get('time', '03:00')
        day_of_week = request.POST.get('day_of_week')
        day_of_month = request.POST.get('day_of_month')
        interval_hours = request.POST.get('interval_hours', 6)
        keep_last = request.POST.get('keep_last', 10)
        compression = request.POST.get('compression') == 'on'
        is_active = request.POST.get('is_active') == 'on'

        if not name:
            messages.error(request, 'Введите название расписания')
            return redirect('backup_service:schedule_create')

        try:
            time_obj = datetime.strptime(time_str, '%H:%M').time()
        except:
            time_obj = datetime.strptime('03:00', '%H:%M').time()

        schedule = BackupSchedule.objects.create(
            name=name,
            frequency=frequency,
            time=time_obj,
            day_of_week=int(day_of_week) if day_of_week else None,
            day_of_month=int(day_of_month) if day_of_month else None,
            interval_hours=int(interval_hours),
            keep_last=int(keep_last),
            compression=compression,
            is_active=is_active
        )

        messages.success(request, f'Расписание "{name}" создано')
        return redirect('backup_service:schedule_list')

    context = {
        'now': timezone.now(),
    }
    return render(request, 'backup_service/schedule_form.html', context)


@login_required
@admin_required
def schedule_edit(request, schedule_id):
    """Редактирование расписания"""
    schedule = get_object_or_404(BackupSchedule, id=schedule_id)

    if request.method == 'POST':
        name = request.POST.get('name', '').strip()
        frequency = request.POST.get('frequency', 'daily')
        time_str = request.POST.get('time', '03:00')
        day_of_week = request.POST.get('day_of_week')
        day_of_month = request.POST.get('day_of_month')
        interval_hours = request.POST.get('interval_hours', 6)
        keep_last = request.POST.get('keep_last', 10)
        compression = request.POST.get('compression') == 'on'
        is_active = request.POST.get('is_active') == 'on'

        if not name:
            messages.error(request, 'Введите название расписания')
            return redirect('backup_service:schedule_edit', schedule_id=schedule.id)

        try:
            time_obj = datetime.strptime(time_str, '%H:%M').time()
        except:
            time_obj = datetime.strptime('03:00', '%H:%M').time()

        schedule.name = name
        schedule.frequency = frequency
        schedule.time = time_obj
        schedule.day_of_week = int(day_of_week) if day_of_week else None
        schedule.day_of_month = int(day_of_month) if day_of_month else None
        schedule.interval_hours = int(interval_hours)
        schedule.keep_last = int(keep_last)
        schedule.compression = compression
        schedule.is_active = is_active
        schedule.save()

        messages.success(request, f'Расписание "{name}" обновлено')
        return redirect('backup_service:schedule_list')

    context = {
        'schedule': schedule,
    }
    return render(request, 'backup_service/schedule_form.html', context)


@login_required
@admin_required
@require_http_methods(["POST"])
def schedule_delete(request, schedule_id):
    """Удаление расписания"""
    schedule = get_object_or_404(BackupSchedule, id=schedule_id)
    name = schedule.name
    schedule.delete()
    messages.success(request, f'Расписание "{name}" удалено')
    return redirect('backup_service:schedule_list')


@login_required
@admin_required
@require_http_methods(["POST"])
def schedule_toggle(request, schedule_id):
    """Включение/выключение расписания"""
    schedule = get_object_or_404(BackupSchedule, id=schedule_id)
    schedule.is_active = not schedule.is_active
    schedule.save()

    status = "активировано" if schedule.is_active else "деактивировано"
    messages.success(request, f'Расписание "{schedule.name}" {status}')
    return redirect('backup_service:schedule_list')




def get_client_ip(request):
    """Получение IP адреса клиента"""
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0]
    else:
        ip = request.META.get('REMOTE_ADDR')
    return ip


def format_size(size):
    """Форматирование размера"""
    for unit in ['Б', 'КБ', 'МБ', 'ГБ']:
        if size < 1024.0:
            return f"{size:.1f} {unit}"
        size /= 1024.0
    return f"{size:.1f} ТБ"


from django.db import connection

def get_database_info():
    """Информация о реально подключенной БД (а не только settings.py)"""
    cfg = connection.settings_dict
    info = {
        'engine': cfg.get('ENGINE', '').split('.')[-1],
        'name': cfg.get('NAME'),
        'host': cfg.get('HOST') or 'localhost',
        'port': cfg.get('PORT') or '',
        'user': cfg.get('USER') or '',
        'schema': 'public',
        'tables_count': None,
        'total_rows': None,
        'errors': [],
    }

    try:
        with connection.cursor() as cursor:

            cursor.execute("SELECT current_database(), current_schema()")
            dbname, schema = cursor.fetchone()
            info['name'] = dbname
            info['schema'] = schema


            cursor.execute("""
                SELECT COUNT(*)
                FROM information_schema.tables
                WHERE table_schema = current_schema()
                  AND table_type = 'BASE TABLE'
            """)
            info['tables_count'] = cursor.fetchone()[0]


            cursor.execute("""
                SELECT COALESCE(SUM(reltuples)::bigint, 0)
                FROM pg_class c
                JOIN pg_namespace n ON n.oid = c.relnamespace
                WHERE c.relkind = 'r'
                  AND n.nspname = current_schema()
            """)
            info['total_rows'] = int(cursor.fetchone()[0] or 0)

    except Exception as e:
        info['errors'].append(str(e))

        info['tables_count'] = info['tables_count'] or 0
        info['total_rows'] = info['total_rows'] or 0

    return info


def resolve_postgres_binary(binary_name):
    """Find pg_dump/psql on Windows or in PATH."""
    executable = f'{binary_name}.exe' if os.name == 'nt' else binary_name

    candidate = shutil.which(binary_name) or shutil.which(executable)
    if candidate:
        return candidate

    if os.name == 'nt':
        for version in ['17', '16', '15', '14', '13', '12']:
            for base in [r'C:\Program Files\PostgreSQL', r'C:\Program Files (x86)\PostgreSQL']:
                path = os.path.join(base, version, 'bin', executable)
                if os.path.exists(path):
                    return path

    return None


def create_database_backup(backup):
    """Создание резервной копии базы данных"""
    try:

        backup_dir = os.path.join(settings.BASE_DIR, 'backups')
        os.makedirs(backup_dir, exist_ok=True)


        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        filename = f"backup_{backup.id}_{timestamp}.sql"
        file_path = os.path.join(backup_dir, filename)

        db_config = settings.DATABASES['default']


        if 'postgresql' in db_config['ENGINE']:

            pg_dump_path = resolve_postgres_binary('pg_dump')
            if not pg_dump_path:
                return {'success': False, 'error': 'pg_dump not found. Install PostgreSQL client tools.'}

            env = os.environ.copy()
            if db_config.get('PASSWORD'):
                env['PGPASSWORD'] = db_config['PASSWORD']

            cmd = [
                pg_dump_path,
                '-h', db_config.get('HOST') or 'localhost',
                '-p', str(db_config.get('PORT') or '5432'),
                '-U', db_config['USER'],
                '-d', db_config['NAME'],
                '-f', file_path,
                '--clean',
                '--if-exists',
            ]

            if db_config.get('PASSWORD'):
                result = subprocess.run(cmd, env=env, capture_output=True, text=True)
            else:
                result = subprocess.run(cmd, capture_output=True, text=True)

            if result.returncode != 0:
                return {'success': False, 'error': result.stderr}


            tables_count = 0
            row_count = 0

            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT COUNT(*) FROM information_schema.tables
                    WHERE table_schema = 'public'
                """)
                tables_count = cursor.fetchone()[0]

                cursor.execute("""
                    SELECT SUM(reltuples) FROM pg_class
                    WHERE relkind = 'r' AND relnamespace = 'public'::regnamespace
                """)
                row_count = int(cursor.fetchone()[0] or 0)

            file_size = os.path.getsize(file_path)


            md5_hash = hashlib.md5()
            with open(file_path, 'rb') as f:
                for chunk in iter(lambda: f.read(4096), b''):
                    md5_hash.update(chunk)

            return {
                'success': True,
                'file_path': file_path,
                'file_size': file_size,
                'tables_count': tables_count,
                'row_count': row_count,
                'md5': md5_hash.hexdigest(),
            }

        elif 'mysql' in db_config['ENGINE']:

            cmd = [
                'mysqldump',
                '-h', db_config.get('HOST', 'localhost'),
                '-P', str(db_config.get('PORT', '3306')),
                '-u', db_config['USER'],
                f'-p{db_config["PASSWORD"]}' if db_config.get('PASSWORD') else '',
                db_config['NAME'],
                '--result-file', file_path,
                '--add-drop-table',
                '--create-options',
                '--quick',
            ]


            cmd = [arg for arg in cmd if arg]

            result = subprocess.run(cmd, capture_output=True, text=True)

            if result.returncode != 0:
                return {'success': False, 'error': result.stderr}

            file_size = os.path.getsize(file_path)

            return {
                'success': True,
                'file_path': file_path,
                'file_size': file_size,
                'tables_count': 0,
                'row_count': 0,
            }
        else:
            return {'success': False, 'error': 'Неподдерживаемый тип БД'}

    except Exception as e:
        return {'success': False, 'error': str(e)}


def restore_database_from_backup(backup):
    """Восстановление базы данных из резервной копии"""
    try:
        if not backup.file_path or not os.path.exists(backup.file_path):
            return {'success': False, 'error': 'Файл резервной копии не найден'}

        db_config = settings.DATABASES['default']

        if 'postgresql' in db_config['ENGINE']:

            psql_path = resolve_postgres_binary('psql')
            if not psql_path:
                return {'success': False, 'error': 'psql not found. Install PostgreSQL client tools.'}

            env = os.environ.copy()
            if db_config.get('PASSWORD'):
                env['PGPASSWORD'] = db_config['PASSWORD']


            try:
                with connection.cursor() as cursor:
                    cursor.execute("""
                        SELECT pg_terminate_backend(pid)
                        FROM pg_stat_activity
                        WHERE datname = %s AND pid <> pg_backend_pid()
                    """, [db_config['NAME']])
            except Exception:
                pass

            cmd = [
                psql_path,
                '-v', 'ON_ERROR_STOP=1',
                '-h', db_config.get('HOST') or 'localhost',
                '-p', str(db_config.get('PORT') or '5432'),
                '-U', db_config['USER'],
                '-d', db_config['NAME'],
                '-f', backup.file_path,
            ]

            if db_config.get('PASSWORD'):
                result = subprocess.run(cmd, env=env, capture_output=True, text=True)
            else:
                result = subprocess.run(cmd, capture_output=True, text=True)

            if result.returncode != 0:
                return {'success': False, 'error': result.stderr}

            return {'success': True}

        elif 'mysql' in db_config['ENGINE']:

            cmd = [
                'mysql',
                '-h', db_config.get('HOST', 'localhost'),
                '-P', str(db_config.get('PORT', '3306')),
                '-u', db_config['USER'],
                f'-p{db_config["PASSWORD"]}' if db_config.get('PASSWORD') else '',
                db_config['NAME'],
                '-e', f'source {backup.file_path}',
            ]

            cmd = [arg for arg in cmd if arg]

            result = subprocess.run(cmd, capture_output=True, text=True)

            if result.returncode != 0:
                return {'success': False, 'error': result.stderr}

            return {'success': True}
        else:
            return {'success': False, 'error': 'Неподдерживаемый тип БД'}

    except Exception as e:
        return {'success': False, 'error': str(e)}

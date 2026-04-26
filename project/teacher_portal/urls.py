
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from . import views

app_name = 'teacher_portal'

urlpatterns = [

    path('', views.dashboard, name='dashboard'),


    path('grades/', views.manage_grades, name='grades'),
    path('grades/add/', views.add_grade, name='add_grade'),
    path('grades/<int:grade_id>/edit/', views.edit_grade, name='edit_grade'),
    path('grades/<int:grade_id>/delete/', views.delete_grade, name='delete_grade'),


    path('attendance/', views.manage_attendance, name='attendance'),
    path('attendance/save/', views.save_attendance, name='save_attendance'),


    path('homework/', views.manage_homework, name='homework'),
    path('homework/create/', views.create_homework, name='create_homework'),
    path('homework/<int:homework_id>/submissions/', views.homework_submissions, name='homework_submissions'),
    path('submissions/<int:submission_id>/grade/', views.grade_submission, name='grade_submission'),
    path('homework/delete/<int:homework_id>/', views.delete_homework, name='delete_homework'),
    path('homework/<int:homework_id>/edit/', views.edit_homework, name='edit_homework'),

    path('homework/<int:homework_id>/view_file/', views.view_homework_file, name='view_homework_file'),
    path('statistics/export/pdf/', views.export_statistics_pdf, name='export_statistics_pdf'),
    path('statistics/export/excel/', views.export_statistics_excel, name='export_statistics_excel'),

    path('schedule/', views.view_schedule, name='schedule'),

path('homework/<int:homework_id>/student/<int:student_id>/',
     views.student_submission_detail,
     name='student_submission_detail'),
path('find-grade/', views.find_grade_id, name='find_grade_id'),

    path('announcements/', views.manage_announcements, name='announcements'),
    path('announcements/create/', views.create_announcement, name='create_announcement'),
    path('announcements/<int:announcement_id>/delete/', views.delete_announcement, name='delete_announcement'),
    path('announcements/<int:announcement_id>/edit/', views.edit_announcement, name='edit_announcement'),
    path('grades/<int:grade_id>/update/', views.update_grade, name='update_grade'),

    path('students/', views.view_students, name='students'),
    path('students/<int:student_id>/', views.student_detail, name='student_detail'),
    path('submissions/<int:submission_id>/view_file/', views.view_submission_file, name='view_submission_file'),

    path('statistics/', views.view_statistics, name='statistics'),
]


if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

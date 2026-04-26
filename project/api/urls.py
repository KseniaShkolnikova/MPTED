"""Маршруты основного REST API и мобильного API.

Этот модуль регистрирует общие DRF viewset-ы для основного API, собирает
отдельный router для мобильного клиента и добавляет mobile-only endpoints для
авторизации и профиля в пространстве имен `mobile/`.
"""

from django.urls import include, path
from rest_framework import routers
from .views import *

# Основной router для стандартных endpoint-ов `/api/`.
router = routers.SimpleRouter()

# Отдельный router для endpoint-ов `/api/mobile/`, которые использует мобилка.
mobile_router = routers.SimpleRouter()

# Общая карта ресурсов, которая регистрируется и в основном, и в mobile API.
api_routes = [
    ("users", UserViewSet, "user"),
    ("subjects", SubjectViewSet, "subject"),
    ("student-groups", StudentGroupViewSet, "studentgroup"),
    ("student-profiles", StudentProfileViewSet, "studentprofile"),
    ("teacher-profiles", TeacherProfileViewSet, "teacherprofile"),
    ("teacher-subjects", TeacherSubjectViewSet, "teachersubject"),
    ("daily-schedules", DailyScheduleViewSet, "dailyschedule"),
    ("schedule-lessons", ScheduleLessonViewSet, "schedulelesson"),
    ("lesson-replacements", LessonReplacementViewSet, "lessonreplacement"),
    ("homeworks", HomeworkViewSet, "homework"),
    ("homework-submissions", HomeworkSubmissionViewSet, "homeworksubmission"),
    ("grades", GradeViewSet, "grade"),
    ("comments", CommentViewSet, "comment"),
    ("attendance", AttendanceViewSet, "attendance"),
    ("announcements", AnnouncementViewSet, "announcement"),
]

# Регистрирует общие ресурсы в основном API и, где это допустимо, в mobile API.
for prefix, viewset, basename in api_routes:
    router.register(prefix, viewset, basename=basename)
    if prefix != "student-profiles":
        mobile_router.register(prefix, viewset, basename=f"mobile-{basename}")

# Endpoint-ы только для мобилки, которые не входят в общий набор ресурсов.
mobile_urlpatterns = [
    path(
        "auth/password-reset/request/",
        MobilePasswordResetRequestView.as_view(),
        name="mobile-password-reset-request",
    ),
    path(
        "auth/password-reset/confirm/",
        MobilePasswordResetConfirmView.as_view(),
        name="mobile-password-reset-confirm",
    ),
    path(
        "auth/password-reset/update-password/",
        MobilePasswordResetUpdatePasswordView.as_view(),
        name="mobile-password-reset-update-password",
    ),
    path(
        "student-profiles/",
        MobileStudentProfileView.as_view(),
        name="mobile-studentprofile-list",
    ),
    *mobile_router.urls,
]

# Финальная таблица URL: подключает mobile namespace и основной router API.
urlpatterns = [
    path(
        "mobile/",
        include((mobile_urlpatterns, "mobile_api"), namespace="mobile_api"),
    ),
    path("", include(router.urls)),
]

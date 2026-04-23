from django.urls import include, path
from rest_framework import routers
from .views import *

router = routers.SimpleRouter()
mobile_router = routers.SimpleRouter()

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

for prefix, viewset, basename in api_routes:
    router.register(prefix, viewset, basename=basename)
    mobile_router.register(prefix, viewset, basename=f"mobile-{basename}")

urlpatterns = [
    path(
        "mobile/",
        include((mobile_router.urls, "mobile_api"), namespace="mobile_api"),
    ),
    path("", include(router.urls)),
]

from django.contrib.auth.models import User
from django.db.models import Q
from rest_framework import permissions, viewsets

from .models import (
    Announcement,
    Attendance,
    Comment,
    DailySchedule,
    Grade,
    Homework,
    HomeworkSubmission,
    ScheduleLesson,
    StudentGroup,
    StudentProfile,
    Subject,
    TeacherProfile,
    TeacherSubject,
)
from .pagination import PaginationPage
from .serializers import (
    AnnouncementSerializer,
    AttendanceSerializer,
    CommentSerializer,
    DailyScheduleSerializer,
    GradeSerializer,
    HomeworkSerializer,
    HomeworkSubmissionSerializer,
    ScheduleLessonSerializer,
    StudentGroupSerializer,
    StudentProfileSerializer,
    SubjectSerializer,
    TeacherProfileSerializer,
    TeacherSubjectSerializer,
    UserSerializer,
)


class StudentScopeMixin:
    permission_classes = [permissions.IsAuthenticated]
    pagination_class = PaginationPage

    def is_staff_user(self):
        user = self.request.user
        return user.is_staff or user.is_superuser

    def get_student_profile(self):
        return (
            StudentProfile.objects.select_related("user", "student_group")
            .filter(user=self.request.user)
            .first()
        )


class UserViewSet(StudentScopeMixin, viewsets.ReadOnlyModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return User.objects.all()
        return User.objects.filter(id=self.request.user.id)


class SubjectViewSet(StudentScopeMixin, viewsets.ReadOnlyModelViewSet):
    queryset = Subject.objects.all()
    serializer_class = SubjectSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return Subject.objects.all()

        profile = self.get_student_profile()
        if not profile or not profile.student_group_id:
            return Subject.objects.none()

        return Subject.objects.filter(
            Q(grades__student=self.request.user)
            | Q(schedule_lessons__daily_schedule__student_group=profile.student_group)
            | Q(homeworks__student_group=profile.student_group)
        ).distinct()


class StudentGroupViewSet(StudentScopeMixin, viewsets.ReadOnlyModelViewSet):
    queryset = StudentGroup.objects.all()
    serializer_class = StudentGroupSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return StudentGroup.objects.all()

        return StudentGroup.objects.filter(students__user=self.request.user).distinct()


class StudentProfileViewSet(StudentScopeMixin, viewsets.ReadOnlyModelViewSet):
    queryset = StudentProfile.objects.all()
    serializer_class = StudentProfileSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return StudentProfile.objects.select_related("user", "student_group")

        return StudentProfile.objects.select_related("user", "student_group").filter(
            user=self.request.user
        )


class TeacherProfileViewSet(StudentScopeMixin, viewsets.ReadOnlyModelViewSet):
    queryset = TeacherProfile.objects.all()
    serializer_class = TeacherProfileSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return TeacherProfile.objects.select_related("user")

        profile = self.get_student_profile()
        if not profile or not profile.student_group_id:
            return TeacherProfile.objects.none()

        return TeacherProfile.objects.select_related("user").filter(
            Q(user__schedule_lessons__daily_schedule__student_group=profile.student_group)
            | Q(teacher_subjects__subject__schedule_lessons__daily_schedule__student_group=profile.student_group)
        ).distinct()


class TeacherSubjectViewSet(StudentScopeMixin, viewsets.ReadOnlyModelViewSet):
    queryset = TeacherSubject.objects.all()
    serializer_class = TeacherSubjectSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return TeacherSubject.objects.select_related("teacher__user", "subject")

        profile = self.get_student_profile()
        if not profile or not profile.student_group_id:
            return TeacherSubject.objects.none()

        return TeacherSubject.objects.select_related("teacher__user", "subject").filter(
            subject__schedule_lessons__daily_schedule__student_group=profile.student_group
        ).distinct()


class DailyScheduleViewSet(StudentScopeMixin, viewsets.ReadOnlyModelViewSet):
    queryset = DailySchedule.objects.all()
    serializer_class = DailyScheduleSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return DailySchedule.objects.select_related("student_group")

        profile = self.get_student_profile()
        if not profile or not profile.student_group_id:
            return DailySchedule.objects.none()

        return DailySchedule.objects.select_related("student_group").filter(
            student_group=profile.student_group,
            is_active=True,
        )


class ScheduleLessonViewSet(StudentScopeMixin, viewsets.ReadOnlyModelViewSet):
    queryset = ScheduleLesson.objects.all()
    serializer_class = ScheduleLessonSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return ScheduleLesson.objects.select_related(
                "daily_schedule",
                "daily_schedule__student_group",
                "subject",
                "teacher",
            )

        profile = self.get_student_profile()
        if not profile or not profile.student_group_id:
            return ScheduleLesson.objects.none()

        return ScheduleLesson.objects.select_related(
            "daily_schedule",
            "daily_schedule__student_group",
            "subject",
            "teacher",
        ).filter(
            daily_schedule__student_group=profile.student_group
        )


class HomeworkViewSet(StudentScopeMixin, viewsets.ReadOnlyModelViewSet):
    queryset = Homework.objects.all()
    serializer_class = HomeworkSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return Homework.objects.select_related(
                "schedule_lesson",
                "schedule_lesson__subject",
                "student_group",
            )

        profile = self.get_student_profile()
        if not profile or not profile.student_group_id:
            return Homework.objects.none()

        return Homework.objects.select_related(
            "schedule_lesson",
            "schedule_lesson__subject",
            "student_group",
        ).filter(
            student_group=profile.student_group
        )


class HomeworkSubmissionViewSet(StudentScopeMixin, viewsets.ModelViewSet):
    queryset = HomeworkSubmission.objects.all()
    serializer_class = HomeworkSubmissionSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return HomeworkSubmission.objects.select_related("homework", "student")

        return HomeworkSubmission.objects.select_related("homework", "student").filter(
            student=self.request.user
        )

    def perform_create(self, serializer):
        if self.is_staff_user():
            serializer.save()
        else:
            serializer.save(student=self.request.user)


class GradeViewSet(StudentScopeMixin, viewsets.ReadOnlyModelViewSet):
    queryset = Grade.objects.all()
    serializer_class = GradeSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return Grade.objects.select_related(
                "student",
                "subject",
                "schedule_lesson",
                "teacher",
            )

        return Grade.objects.select_related(
            "student",
            "subject",
            "schedule_lesson",
            "teacher",
        ).filter(
            student=self.request.user
        )


class CommentViewSet(StudentScopeMixin, viewsets.ModelViewSet):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return Comment.objects.select_related("homework", "author")

        profile = self.get_student_profile()
        if not profile or not profile.student_group_id:
            return Comment.objects.none()

        return Comment.objects.select_related("homework", "author").filter(
            homework__student_group=profile.student_group
        )

    def perform_create(self, serializer):
        if self.is_staff_user():
            serializer.save()
        else:
            serializer.save(author=self.request.user)


class AttendanceViewSet(StudentScopeMixin, viewsets.ReadOnlyModelViewSet):
    queryset = Attendance.objects.all()
    serializer_class = AttendanceSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return Attendance.objects.select_related("student", "schedule_lesson")

        return Attendance.objects.select_related("student", "schedule_lesson").filter(
            student=self.request.user
        )


class AnnouncementViewSet(StudentScopeMixin, viewsets.ReadOnlyModelViewSet):
    queryset = Announcement.objects.all()
    serializer_class = AnnouncementSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return Announcement.objects.select_related("author", "student_group")

        profile = self.get_student_profile()
        if not profile or not profile.student_group_id:
            return Announcement.objects.filter(is_for_all=True).select_related(
                "author",
                "student_group",
            )

        return Announcement.objects.select_related("author", "student_group").filter(
            Q(is_for_all=True) | Q(student_group=profile.student_group)
        ).distinct()

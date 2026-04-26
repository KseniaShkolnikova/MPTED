from django.contrib.auth.models import User
from django.db.models import Q
from django.utils.dateparse import parse_date
from rest_framework import generics, permissions, status, viewsets
from rest_framework.exceptions import PermissionDenied, ValidationError
from rest_framework.parsers import FormParser, JSONParser, MultiPartParser
from rest_framework.renderers import JSONRenderer
from rest_framework.response import Response
from rest_framework.views import APIView

from education_department.models import LessonReplacement
from education_department.replacement_utils import (
    annotate_lessons_with_replacements,
    get_week_day_code,
)

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
    LessonReplacementSerializer,
    MobileStudentProfileSerializer,
    PasswordResetConfirmSerializer,
    PasswordResetRequestSerializer,
    PasswordResetUpdatePasswordSerializer,
    ScheduleLessonSerializer,
    StudentGroupSerializer,
    StudentProfileSerializer,
    SubjectSerializer,
    TeacherProfileSerializer,
    TeacherSubjectSerializer,
    UserSerializer,
)
from .password_reset import (
    PASSWORD_RESET_GENERIC_RESPONSE,
    PasswordResetServiceError,
    confirm_password_reset_code,
    extract_client_ip,
    request_password_reset_code,
    update_password_for_email,
)
from .permissions import IsAdminOrMobileStudent, IsAuthenticatedStudent


class StudentScopeMixin:
    permission_classes = [IsAdminOrMobileStudent]
    renderer_classes = [JSONRenderer]
    pagination_class = PaginationPage
    student_write_methods = set()

    def is_staff_user(self):
        user = self.request.user
        return user.is_staff or user.is_superuser

    def get_student_profile(self):
        return (
            StudentProfile.objects.select_related("user", "student_group")
            .filter(user=self.request.user)
            .first()
        )

    def get_requested_date(self):
        raw_date = (self.request.query_params.get("date") or "").strip()
        if not raw_date:
            return None

        parsed_date = parse_date(raw_date)
        if not parsed_date:
            raise ValidationError({"date": "Используйте формат YYYY-MM-DD."})

        return parsed_date

    def get_student_homework_queryset(self):
        profile = self.get_student_profile()
        if not profile or not profile.student_group_id:
            return Homework.objects.none()

        return Homework.objects.filter(student_group=profile.student_group)

    def ensure_student_can_access_homework(self, homework):
        if self.is_staff_user():
            return

        if not self.get_student_homework_queryset().filter(pk=homework.pk).exists():
            raise PermissionDenied("Это задание недоступно текущему ученику.")


class UserViewSet(StudentScopeMixin, viewsets.ReadOnlyModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return User.objects.all()
        return User.objects.filter(id=self.request.user.id)


class SubjectViewSet(StudentScopeMixin, viewsets.ModelViewSet):
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
            | Q(schedule_lessons__homeworks__student_group=profile.student_group)
        ).distinct()


class StudentGroupViewSet(StudentScopeMixin, viewsets.ModelViewSet):
    queryset = StudentGroup.objects.all()
    serializer_class = StudentGroupSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return StudentGroup.objects.all()

        return StudentGroup.objects.filter(students__user=self.request.user).distinct()


class StudentProfileViewSet(StudentScopeMixin, viewsets.ModelViewSet):
    queryset = StudentProfile.objects.all()
    serializer_class = StudentProfileSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return StudentProfile.objects.select_related("user", "student_group")

        return StudentProfile.objects.select_related("user", "student_group").filter(
            user=self.request.user
        )


class MobileStudentProfileView(generics.RetrieveUpdateAPIView):
    serializer_class = MobileStudentProfileSerializer
    permission_classes = [permissions.IsAuthenticated, IsAuthenticatedStudent]
    renderer_classes = [JSONRenderer]
    parser_classes = [JSONParser]
    http_method_names = ["get", "patch", "head", "options"]

    def get_object(self):
        return self.request.user.student_profile


class MobilePasswordResetRequestView(APIView):
    authentication_classes = []
    permission_classes = [permissions.AllowAny]
    renderer_classes = [JSONRenderer]
    parser_classes = [JSONParser]

    def post(self, request, *args, **kwargs):
        serializer = PasswordResetRequestSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        request_password_reset_code(
            serializer.validated_data["email"],
            request_ip=extract_client_ip(request),
        )

        return Response(
            {"detail": PASSWORD_RESET_GENERIC_RESPONSE},
            status=status.HTTP_200_OK,
        )


class MobilePasswordResetConfirmView(APIView):
    authentication_classes = []
    permission_classes = [permissions.AllowAny]
    renderer_classes = [JSONRenderer]
    parser_classes = [JSONParser]

    def post(self, request, *args, **kwargs):
        serializer = PasswordResetConfirmSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        try:
            confirm_password_reset_code(
                email=serializer.validated_data["email"],
                code=serializer.validated_data["code"],
                new_password=serializer.validated_data["new_password"],
                new_password_confirm=serializer.validated_data.get(
                    "new_password_confirm"
                ),
            )
        except PasswordResetServiceError as exc:
            return Response(exc.detail, status=status.HTTP_400_BAD_REQUEST)

        return Response(
            {"detail": "Пароль изменен. Войдите снова."},
            status=status.HTTP_200_OK,
        )


class MobilePasswordResetUpdatePasswordView(APIView):
    authentication_classes = []
    permission_classes = [permissions.AllowAny]
    renderer_classes = [JSONRenderer]
    parser_classes = [JSONParser]

    def post(self, request, *args, **kwargs):
        serializer = PasswordResetUpdatePasswordSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        try:
            update_password_for_email(
                email=serializer.validated_data["email"],
                new_password=serializer.validated_data["new_password"],
                new_password_confirm=serializer.validated_data[
                    "new_password_confirm"
                ],
            )
        except PasswordResetServiceError as exc:
            return Response(exc.detail, status=status.HTTP_400_BAD_REQUEST)

        return Response(
            {"detail": "Пароль изменен. Войдите снова."},
            status=status.HTTP_200_OK,
        )


class TeacherProfileViewSet(StudentScopeMixin, viewsets.ModelViewSet):
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


class TeacherSubjectViewSet(StudentScopeMixin, viewsets.ModelViewSet):
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


class DailyScheduleViewSet(StudentScopeMixin, viewsets.ModelViewSet):
    queryset = DailySchedule.objects.all()
    serializer_class = DailyScheduleSerializer

    def get_queryset(self):
        target_date = self.get_requested_date()

        if self.is_staff_user():
            queryset = DailySchedule.objects.select_related("student_group")
            if target_date:
                queryset = queryset.filter(week_day=get_week_day_code(target_date))
            return queryset

        profile = self.get_student_profile()
        if not profile or not profile.student_group_id:
            return DailySchedule.objects.none()

        queryset = DailySchedule.objects.select_related("student_group").filter(
            student_group=profile.student_group,
            is_active=True,
        )
        if target_date:
            queryset = queryset.filter(week_day=get_week_day_code(target_date))
        return queryset


class ScheduleLessonViewSet(StudentScopeMixin, viewsets.ModelViewSet):
    queryset = ScheduleLesson.objects.all()
    serializer_class = ScheduleLessonSerializer

    def get_queryset(self):
        target_date = self.get_requested_date()

        if self.is_staff_user():
            queryset = ScheduleLesson.objects.select_related(
                "daily_schedule",
                "daily_schedule__student_group",
                "subject",
                "teacher",
            )
            if target_date:
                queryset = queryset.filter(
                    daily_schedule__week_day=get_week_day_code(target_date)
                )
            return queryset

        profile = self.get_student_profile()
        if not profile or not profile.student_group_id:
            return ScheduleLesson.objects.none()

        queryset = ScheduleLesson.objects.select_related(
            "daily_schedule",
            "daily_schedule__student_group",
            "subject",
            "teacher",
        ).filter(
            daily_schedule__student_group=profile.student_group
        )
        if target_date:
            queryset = queryset.filter(
                daily_schedule__week_day=get_week_day_code(target_date)
            )
        return queryset

    def list(self, request, *args, **kwargs):
        target_date = self.get_requested_date()
        queryset = self.filter_queryset(self.get_queryset())

        page = self.paginate_queryset(queryset)
        if page is not None:
            lessons = (
                annotate_lessons_with_replacements(page, target_date)
                if target_date
                else page
            )
            serializer = self.get_serializer(lessons, many=True)
            return self.get_paginated_response(serializer.data)

        lessons = (
            annotate_lessons_with_replacements(queryset, target_date)
            if target_date
            else queryset
        )
        serializer = self.get_serializer(lessons, many=True)
        return Response(serializer.data)

    def retrieve(self, request, *args, **kwargs):
        lesson = self.get_object()
        target_date = self.get_requested_date()
        if target_date:
            lesson = annotate_lessons_with_replacements([lesson], target_date)[0]
        serializer = self.get_serializer(lesson)
        return Response(serializer.data)


class LessonReplacementViewSet(StudentScopeMixin, viewsets.ReadOnlyModelViewSet):
    queryset = LessonReplacement.objects.all()
    serializer_class = LessonReplacementSerializer

    def get_queryset(self):
        target_date = self.get_requested_date()

        queryset = LessonReplacement.objects.select_related(
            "original_lesson",
            "original_lesson__daily_schedule",
            "original_lesson__daily_schedule__student_group",
            "original_lesson__subject",
            "original_lesson__teacher",
            "replacement_subject",
            "replacement_teacher",
        )

        if self.is_staff_user():
            if target_date:
                queryset = queryset.filter(replacement_date=target_date)
            return queryset

        profile = self.get_student_profile()
        if not profile or not profile.student_group_id:
            return LessonReplacement.objects.none()

        queryset = queryset.filter(
            original_lesson__daily_schedule__student_group=profile.student_group
        )
        if target_date:
            queryset = queryset.filter(replacement_date=target_date)
        return queryset


class HomeworkViewSet(StudentScopeMixin, viewsets.ModelViewSet):
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
    parser_classes = [MultiPartParser, FormParser, JSONParser]
    student_write_methods = {"POST", "PUT", "PATCH", "DELETE"}

    def get_queryset(self):
        if self.is_staff_user():
            return HomeworkSubmission.objects.select_related(
                "homework",
                "student",
            ).order_by("-submitted_at")

        return HomeworkSubmission.objects.select_related(
            "homework",
            "student",
        ).filter(
            student=self.request.user
        ).order_by("-submitted_at")

    def perform_create(self, serializer):
        if self.is_staff_user():
            serializer.save()
        else:
            profile = self.get_student_profile()
            if not profile:
                raise PermissionDenied("Student profile is required.")
            self.ensure_student_can_access_homework(serializer.validated_data["homework"])
            serializer.save(student=profile.user)

    def perform_update(self, serializer):
        if self.is_staff_user():
            serializer.save()
            return

        profile = self.get_student_profile()
        if not profile:
            raise PermissionDenied("Student profile is required.")
        homework = serializer.validated_data.get("homework", serializer.instance.homework)
        self.ensure_student_can_access_homework(homework)
        serializer.save(student=profile.user)

    def can_modify_student_object(self, request, obj):
        return obj.student_id == request.user.id


class GradeViewSet(StudentScopeMixin, viewsets.ModelViewSet):
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
    student_write_methods = {"POST", "PUT", "PATCH", "DELETE"}

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
            self.ensure_student_can_access_homework(serializer.validated_data["homework"])
            serializer.save(author=self.request.user)

    def perform_update(self, serializer):
        if self.is_staff_user():
            serializer.save()
            return

        homework = serializer.validated_data.get("homework", serializer.instance.homework)
        self.ensure_student_can_access_homework(homework)
        serializer.save(author=self.request.user)

    def can_modify_student_object(self, request, obj):
        return obj.author_id == request.user.id


class AttendanceViewSet(StudentScopeMixin, viewsets.ModelViewSet):
    queryset = Attendance.objects.all()
    serializer_class = AttendanceSerializer

    def get_queryset(self):
        if self.is_staff_user():
            return Attendance.objects.select_related("student", "schedule_lesson")

        return Attendance.objects.select_related("student", "schedule_lesson").filter(
            student=self.request.user
        )


class AnnouncementViewSet(StudentScopeMixin, viewsets.ModelViewSet):
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

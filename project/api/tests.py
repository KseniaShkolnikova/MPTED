from datetime import date
from pathlib import Path
import shutil
from unittest.mock import patch
from urllib.parse import urlparse

from django.contrib.auth.hashers import check_password, make_password
from django.contrib.auth.models import User
from django.core import mail
from django.core.cache import cache
from django.core.files.uploadedfile import SimpleUploadedFile
from django.test import TestCase
from django.test.utils import override_settings
from django.urls import reverse
from django.utils import timezone
from rest_framework import status
from rest_framework.authtoken.models import Token
from rest_framework.test import APIClient

from .models import (
    Comment,
    DailySchedule,
    Homework,
    HomeworkSubmission,
    PasswordResetCode,
    ScheduleLesson,
    StudentGroup,
    StudentProfile,
    Subject,
    TeacherProfile,
)
from .password_reset import PASSWORD_RESET_GENERIC_RESPONSE


class ApiAccessTests(TestCase):
    @classmethod
    def setUpClass(cls):
        super().setUpClass()
        cls.temp_media_root = Path(__file__).resolve().parent.parent / "test_media_runtime"
        shutil.rmtree(cls.temp_media_root, ignore_errors=True)
        cls.temp_media_root.mkdir(parents=True, exist_ok=True)
        cls.media_override = override_settings(MEDIA_ROOT=cls.temp_media_root)
        cls.media_override.enable()

    @classmethod
    def tearDownClass(cls):
        cls.media_override.disable()
        shutil.rmtree(cls.temp_media_root, ignore_errors=True)
        super().tearDownClass()

    def setUp(self):
        self.client = APIClient()

        self.admin = User.objects.create_superuser(
            username="admin",
            password="admin123",
            email="admin@example.com",
        )
        self.teacher = User.objects.create_user(
            username="teacher",
            password="teacher123",
            email="teacher@example.com",
        )
        TeacherProfile.objects.create(
            user=self.teacher,
            patronymic="Иванович",
            qualification="Высшая категория",
        )

        self.student = User.objects.create_user(
            username="student",
            password="student123",
            email="student@example.com",
        )
        self.classmate = User.objects.create_user(
            username="classmate",
            password="classmate123",
            email="classmate@example.com",
        )
        self.other_student = User.objects.create_user(
            username="other_student",
            password="other123",
            email="other@example.com",
        )

        self.group = StudentGroup.objects.create(
            name="10А",
            year=2024,
            curator=self.teacher,
        )
        self.other_group = StudentGroup.objects.create(name="11Б", year=2024)

        self.student_profile = StudentProfile.objects.create(
            user=self.student,
            patronymic="Петрович",
            course=1,
            student_group=self.group,
        )
        StudentProfile.objects.create(
            user=self.classmate,
            patronymic="Сергеевич",
            course=1,
            student_group=self.group,
        )
        StudentProfile.objects.create(
            user=self.other_student,
            patronymic="Андреевич",
            course=1,
            student_group=self.other_group,
        )

        self.subject = Subject.objects.create(name="Математика")
        self.other_subject = Subject.objects.create(name="Физика")
        self.daily_schedule = DailySchedule.objects.create(
            student_group=self.group,
            week_day=DailySchedule.WeekDay.MONDAY,
        )
        self.other_daily_schedule = DailySchedule.objects.create(
            student_group=self.other_group,
            week_day=DailySchedule.WeekDay.MONDAY,
        )
        self.lesson = ScheduleLesson.objects.create(
            daily_schedule=self.daily_schedule,
            lesson_number=1,
            subject=self.subject,
            teacher=self.teacher,
        )
        self.other_lesson = ScheduleLesson.objects.create(
            daily_schedule=self.other_daily_schedule,
            lesson_number=1,
            subject=self.other_subject,
            teacher=self.teacher,
        )
        self.homework = Homework.objects.create(
            title="Свое задание",
            description="Для группы ученика",
            schedule_lesson=self.lesson,
            student_group=self.group,
            due_date=timezone.now(),
        )
        self.other_homework = Homework.objects.create(
            title="Чужое задание",
            description="Для другой группы",
            schedule_lesson=self.other_lesson,
            student_group=self.other_group,
            due_date=timezone.now(),
        )

    def test_student_cannot_use_admin_api_but_can_use_mobile_api(self):
        self.client.force_authenticate(user=self.student)

        admin_response = self.client.get(reverse("subject-list"))
        self.assertEqual(admin_response.status_code, status.HTTP_403_FORBIDDEN)

        mobile_response = self.client.get(
            reverse("mobile_api:mobile-subject-list"),
            HTTP_ACCEPT="application/json",
        )
        self.assertEqual(mobile_response.status_code, status.HTTP_200_OK)

        results = mobile_response.data["results"]
        self.assertEqual([item["name"] for item in results], ["Математика"])

    def test_api_roots_do_not_expose_route_lists(self):
        self.client.force_authenticate(user=self.admin)

        admin_root_response = self.client.get("/api/")
        mobile_root_response = self.client.get("/api/mobile/")

        self.assertEqual(admin_root_response.status_code, status.HTTP_404_NOT_FOUND)
        self.assertEqual(mobile_root_response.status_code, status.HTTP_404_NOT_FOUND)

    def test_student_can_get_own_mobile_profile(self):
        self.client.force_authenticate(user=self.student)

        response = self.client.get(
            reverse("mobile_api:mobile-studentprofile-list"),
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["user"]["id"], self.student.id)
        self.assertEqual(response.data["student_group"]["id"], self.group.id)

    def test_student_can_patch_allowed_mobile_profile_fields(self):
        self.client.force_authenticate(user=self.student)

        response = self.client.patch(
            reverse("mobile_api:mobile-studentprofile-list"),
            {
                "patronymic": "Updated",
                "phone": "+79990001122",
                "birth_date": "2007-03-04",
                "address": "New address",
            },
            format="json",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.student_profile.refresh_from_db()
        self.assertEqual(self.student_profile.patronymic, "Updated")
        self.assertEqual(self.student_profile.phone, "+79990001122")
        self.assertEqual(self.student_profile.birth_date, date(2007, 3, 4))
        self.assertEqual(self.student_profile.address, "New address")

    def test_student_cannot_patch_protected_mobile_profile_fields(self):
        self.client.force_authenticate(user=self.student)

        response = self.client.patch(
            reverse("mobile_api:mobile-studentprofile-list"),
            {
                "user": {"id": self.other_student.id},
                "user_id": self.other_student.id,
                "student_group": {"id": self.other_group.id},
                "student_group_id": self.other_group.id,
                "course": 4,
                "phone": "+70000000000",
            },
            format="json",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.student_profile.refresh_from_db()
        self.assertEqual(self.student_profile.user_id, self.student.id)
        self.assertEqual(self.student_profile.student_group_id, self.group.id)
        self.assertEqual(self.student_profile.course, 1)
        self.assertEqual(self.student_profile.phone, "+70000000000")
        self.assertEqual(response.data["user"]["id"], self.student.id)
        self.assertEqual(response.data["student_group"]["id"], self.group.id)
        self.assertEqual(response.data["course"], 1)

    def test_user_without_student_profile_cannot_use_mobile_profile(self):
        self.client.force_authenticate(user=self.teacher)

        response = self.client.get(
            reverse("mobile_api:mobile-studentprofile-list"),
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_anonymous_cannot_use_mobile_profile(self):
        response = self.client.get(
            reverse("mobile_api:mobile-studentprofile-list"),
            HTTP_ACCEPT="application/json",
        )

        self.assertIn(
            response.status_code,
            [status.HTTP_401_UNAUTHORIZED, status.HTTP_403_FORBIDDEN],
        )

    def test_student_cannot_open_mobile_browsable_api(self):
        self.client.force_authenticate(user=self.student)

        response = self.client.get(
            reverse("mobile_api:mobile-subject-list"),
            HTTP_ACCEPT="text/html",
        )

        self.assertEqual(response.status_code, status.HTTP_406_NOT_ACCEPTABLE)

    def test_teacher_cannot_use_mobile_api_or_get_api_token(self):
        self.client.force_authenticate(user=self.teacher)

        response = self.client.get(
            reverse("mobile_api:mobile-subject-list"),
            HTTP_ACCEPT="application/json",
        )
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

        self.client.force_authenticate(user=None)
        token_response = self.client.post(
            reverse("api_token_auth"),
            {"username": "teacher", "password": "teacher123"},
            format="json",
        )
        self.assertEqual(token_response.status_code, status.HTTP_403_FORBIDDEN)

    def test_student_cannot_comment_on_other_group_homework(self):
        self.client.force_authenticate(user=self.student)

        response = self.client.post(
            reverse("mobile_api:mobile-comment-list"),
            {"homework_id": self.other_homework.id, "text": "Не мое задание"},
            format="json",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)
        self.assertFalse(Comment.objects.filter(text="Не мое задание").exists())

    def test_student_can_submit_homework_with_multipart_without_student_id(self):
        self.client.force_authenticate(user=self.student)

        response = self.client.post(
            reverse("mobile_api:mobile-homeworksubmission-list"),
            {
                "homework_id": self.homework.id,
                "submission_text": "My answer",
                "submission_file": SimpleUploadedFile(
                    "answer.txt",
                    b"homework answer",
                    content_type="text/plain",
                ),
            },
            format="multipart",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_201_CREATED,
            response.content,
        )
        submission = HomeworkSubmission.objects.get(
            homework=self.homework,
            student=self.student,
        )
        self.assertEqual(submission.submission_text, "My answer")
        self.assertTrue(
            response.data["submission_file"].startswith("http://testserver/media/")
        )

    def test_student_cannot_submit_homework_for_other_group(self):
        self.client.force_authenticate(user=self.student)

        response = self.client.post(
            reverse("mobile_api:mobile-homeworksubmission-list"),
            {
                "homework_id": self.other_homework.id,
                "submission_text": "Should fail",
                "submission_file": SimpleUploadedFile(
                    "wrong.txt",
                    b"wrong group",
                    content_type="text/plain",
                ),
            },
            format="multipart",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_403_FORBIDDEN,
            response.content,
        )
        self.assertFalse(
            HomeworkSubmission.objects.filter(
                homework=self.other_homework,
                student=self.student,
            ).exists()
        )

    def test_mobile_homework_and_submission_files_have_public_urls(self):
        self.homework.attachment = SimpleUploadedFile(
            "task.txt",
            b"task attachment",
            content_type="text/plain",
        )
        self.homework.save(update_fields=["attachment"])

        submission = HomeworkSubmission.objects.create(
            homework=self.homework,
            student=self.student,
            submission_text="Done",
            submission_file=SimpleUploadedFile(
                "done.txt",
                b"submission attachment",
                content_type="text/plain",
            ),
        )

        self.client.force_authenticate(user=self.student)
        homework_response = self.client.get(
            reverse("mobile_api:mobile-homework-list"),
            HTTP_ACCEPT="application/json",
        )
        submission_response = self.client.get(
            reverse("mobile_api:mobile-homeworksubmission-list"),
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(homework_response.status_code, status.HTTP_200_OK)
        self.assertEqual(submission_response.status_code, status.HTTP_200_OK)

        homework_item = next(
            item
            for item in homework_response.data["results"]
            if item["id"] == self.homework.id
        )
        submission_item = next(
            item
            for item in submission_response.data["results"]
            if item["id"] == submission.id
        )

        self.assertTrue(
            homework_item["attachment"].startswith("http://testserver/media/")
        )
        self.assertTrue(
            submission_item["submission_file"].startswith("http://testserver/media/")
        )
        self.assertTrue(
            Path(self.homework.attachment.path).exists(),
            self.homework.attachment.path,
        )
        self.assertTrue(
            Path(submission.submission_file.path).exists(),
            submission.submission_file.path,
        )

        homework_file_response = self.client.get(
            urlparse(homework_item["attachment"]).path
        )
        submission_file_response = self.client.get(
            urlparse(submission_item["submission_file"]).path
        )

        self.assertEqual(
            homework_file_response.status_code,
            status.HTTP_200_OK,
            homework_item["attachment"],
        )
        self.assertEqual(
            submission_file_response.status_code,
            status.HTTP_200_OK,
            submission_item["submission_file"],
        )

    def test_student_cannot_edit_classmate_comment(self):
        comment = Comment.objects.create(
            homework=self.homework,
            author=self.classmate,
            text="Комментарий одногруппника",
        )
        self.client.force_authenticate(user=self.student)

        response = self.client.patch(
            reverse("mobile_api:mobile-comment-detail", args=[comment.id]),
            {"text": "Переписано"},
            format="json",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)
        comment.refresh_from_db()
        self.assertEqual(comment.text, "Комментарий одногруппника")
@override_settings(EMAIL_BACKEND="django.core.mail.backends.locmem.EmailBackend")
class PasswordResetApiTests(TestCase):
    def setUp(self):
        cache.clear()
        mail.outbox = []
        self.client = APIClient()

        self.student = User.objects.create_user(
            username="student_reset",
            password="OldPassword123!",
            email="student-reset@example.com",
        )
        self.other_user = User.objects.create_user(
            username="teacher_reset",
            password="TeacherPassword123!",
            email="teacher-reset@example.com",
        )
        self.staff_user = User.objects.create_user(
            username="staff_reset",
            password="StaffPassword123!",
            email="staff-reset@example.com",
            is_staff=True,
        )
        self.group = StudentGroup.objects.create(name="PR-10", year=2024)
        StudentProfile.objects.create(
            user=self.student,
            patronymic="Student",
            course=1,
            student_group=self.group,
        )

        self.request_url = reverse("mobile_api:mobile-password-reset-request")
        self.confirm_url = reverse("mobile_api:mobile-password-reset-confirm")
        self.update_password_url = reverse(
            "mobile_api:mobile-password-reset-update-password"
        )

    def create_reset_code(
        self,
        *,
        user=None,
        email=None,
        code="483921",
        expires_at=None,
        attempts=0,
        used_at=None,
    ):
        user = user or self.student
        email = email or user.email
        expires_at = expires_at or (timezone.now() + timezone.timedelta(minutes=10))
        return PasswordResetCode.objects.create(
            user=user,
            requested_email=email.lower(),
            code_hash=make_password(code),
            expires_at=expires_at,
            attempts=attempts,
            used_at=used_at,
            request_ip="127.0.0.1",
        )

    def test_request_with_existing_student_email_sends_mail_and_returns_generic_success(self):
        with patch("api.password_reset.generate_reset_code", return_value="483921"):
            response = self.client.post(
                self.request_url,
                {"email": self.student.email},
                format="json",
                HTTP_ACCEPT="application/json",
            )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["detail"], PASSWORD_RESET_GENERIC_RESPONSE)
        self.assertEqual(len(mail.outbox), 1)

        reset_code = PasswordResetCode.objects.get(user=self.student)
        self.assertEqual(reset_code.requested_email, self.student.email.lower())
        self.assertNotEqual(reset_code.code_hash, "483921")
        self.assertTrue(check_password("483921", reset_code.code_hash))
        self.assertGreater(reset_code.expires_at, reset_code.created_at)

    def test_request_with_unknown_email_returns_same_success_and_sends_no_mail(self):
        response = self.client.post(
            self.request_url,
            {"email": "missing@example.com"},
            format="json",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["detail"], PASSWORD_RESET_GENERIC_RESPONSE)
        self.assertEqual(len(mail.outbox), 0)
        self.assertFalse(PasswordResetCode.objects.exists())

    def test_request_for_user_without_student_profile_does_not_send_mail(self):
        response = self.client.post(
            self.request_url,
            {"email": self.other_user.email},
            format="json",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["detail"], PASSWORD_RESET_GENERIC_RESPONSE)
        self.assertEqual(len(mail.outbox), 0)
        self.assertFalse(
            PasswordResetCode.objects.filter(user=self.other_user).exists()
        )

    def test_request_for_staff_user_does_not_send_mail(self):
        response = self.client.post(
            self.request_url,
            {"email": self.staff_user.email},
            format="json",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["detail"], PASSWORD_RESET_GENERIC_RESPONSE)
        self.assertEqual(len(mail.outbox), 0)
        self.assertFalse(
            PasswordResetCode.objects.filter(user=self.staff_user).exists()
        )

    def test_confirm_with_valid_code_changes_password(self):
        self.create_reset_code(code="483921")

        response = self.client.post(
            self.confirm_url,
            {
                "email": self.student.email,
                "code": "483921",
                "new_password": "NewStrongPassword123!",
                "new_password_confirm": "NewStrongPassword123!",
            },
            format="json",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["detail"], "Пароль изменен. Войдите снова.")
        self.student.refresh_from_db()
        self.assertTrue(self.student.check_password("NewStrongPassword123!"))

    def test_confirm_with_wrong_code_returns_error(self):
        reset_code = self.create_reset_code(code="483921")

        response = self.client.post(
            self.confirm_url,
            {
                "email": self.student.email,
                "code": "111111",
                "new_password": "NewStrongPassword123!",
                "new_password_confirm": "NewStrongPassword123!",
            },
            format="json",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn("code", response.data)
        reset_code.refresh_from_db()
        self.assertEqual(reset_code.attempts, 1)
        self.assertTrue(self.student.check_password("OldPassword123!"))

    def test_confirm_with_expired_code_returns_error(self):
        reset_code = self.create_reset_code(
            code="483921",
            expires_at=timezone.now() - timezone.timedelta(minutes=1),
        )

        response = self.client.post(
            self.confirm_url,
            {
                "email": self.student.email,
                "code": "483921",
                "new_password": "NewStrongPassword123!",
                "new_password_confirm": "NewStrongPassword123!",
            },
            format="json",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn("code", response.data)
        reset_code.refresh_from_db()
        self.assertIsNotNone(reset_code.used_at)
        self.assertTrue(self.student.check_password("OldPassword123!"))

    def test_confirm_blocks_code_after_five_wrong_attempts(self):
        reset_code = self.create_reset_code(code="483921")

        for attempt in range(5):
            response = self.client.post(
                self.confirm_url,
                {
                    "email": self.student.email,
                    "code": "000000",
                    "new_password": "NewStrongPassword123!",
                    "new_password_confirm": "NewStrongPassword123!",
                },
                format="json",
                HTTP_ACCEPT="application/json",
            )

            self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
            self.assertIn("code", response.data)
            if attempt < 4:
                self.assertIn("Неверный", response.data["code"][0])
            else:
                self.assertIn("заблокирован", response.data["code"][0])

        reset_code.refresh_from_db()
        self.assertEqual(reset_code.attempts, 5)
        self.assertIsNotNone(reset_code.used_at)

    def test_confirm_with_weak_password_returns_password_validation_errors(self):
        self.create_reset_code(code="483921")

        response = self.client.post(
            self.confirm_url,
            {
                "email": self.student.email,
                "code": "483921",
                "new_password": "12345678",
                "new_password_confirm": "12345678",
            },
            format="json",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn("new_password", response.data)
        self.assertTrue(self.student.check_password("OldPassword123!"))

    def test_confirm_success_deletes_old_drf_token(self):
        reset_code = self.create_reset_code(code="483921")
        token = Token.objects.create(user=self.student)

        response = self.client.post(
            self.confirm_url,
            {
                "email": self.student.email,
                "code": "483921",
                "new_password": "NewStrongPassword123!",
                "new_password_confirm": "NewStrongPassword123!",
            },
            format="json",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertFalse(Token.objects.filter(key=token.key).exists())
        reset_code.refresh_from_db()
        self.assertIsNotNone(reset_code.used_at)

    def test_used_code_cannot_be_reused_after_successful_password_change(self):
        reset_code = self.create_reset_code(code="483921")

        first_response = self.client.post(
            self.confirm_url,
            {
                "email": self.student.email,
                "code": "483921",
                "new_password": "NewStrongPassword123!",
                "new_password_confirm": "NewStrongPassword123!",
            },
            format="json",
            HTTP_ACCEPT="application/json",
        )
        second_response = self.client.post(
            self.confirm_url,
            {
                "email": self.student.email,
                "code": "483921",
                "new_password": "AnotherStrongPassword123!",
                "new_password_confirm": "AnotherStrongPassword123!",
            },
            format="json",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(first_response.status_code, status.HTTP_200_OK)
        self.assertEqual(second_response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn("code", second_response.data)
        reset_code.refresh_from_db()
        self.assertIsNotNone(reset_code.used_at)
        self.student.refresh_from_db()
        self.assertTrue(self.student.check_password("NewStrongPassword123!"))

    def test_update_password_changes_password_by_email(self):
        response = self.client.post(
            self.update_password_url,
            {
                "email": self.student.email,
                "new_password": "FreshStrongPassword123!",
                "new_password_confirm": "FreshStrongPassword123!",
            },
            format="json",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["detail"], "Пароль изменен. Войдите снова.")
        self.student.refresh_from_db()
        self.assertTrue(self.student.check_password("FreshStrongPassword123!"))

    def test_update_password_requires_existing_student_email(self):
        response = self.client.post(
            self.update_password_url,
            {
                "email": "missing@example.com",
                "new_password": "FreshStrongPassword123!",
                "new_password_confirm": "FreshStrongPassword123!",
            },
            format="json",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn("email", response.data)
        self.student.refresh_from_db()
        self.assertTrue(self.student.check_password("OldPassword123!"))

    def test_update_password_rejects_mismatched_passwords(self):
        response = self.client.post(
            self.update_password_url,
            {
                "email": self.student.email,
                "new_password": "FreshStrongPassword123!",
                "new_password_confirm": "MismatchPassword123!",
            },
            format="json",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn("new_password_confirm", response.data)
        self.student.refresh_from_db()
        self.assertTrue(self.student.check_password("OldPassword123!"))

    def test_update_password_rejects_weak_password(self):
        response = self.client.post(
            self.update_password_url,
            {
                "email": self.student.email,
                "new_password": "12345678",
                "new_password_confirm": "12345678",
            },
            format="json",
            HTTP_ACCEPT="application/json",
        )

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn("new_password", response.data)
        self.student.refresh_from_db()
        self.assertTrue(self.student.check_password("OldPassword123!"))

from datetime import date

from django.contrib.auth.models import User
from django.test import TestCase
from django.urls import reverse
from django.utils import timezone
from rest_framework import status
from rest_framework.test import APIClient

from .models import (
    Comment,
    DailySchedule,
    Homework,
    ScheduleLesson,
    StudentGroup,
    StudentProfile,
    Subject,
    TeacherProfile,
)


class ApiAccessTests(TestCase):
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

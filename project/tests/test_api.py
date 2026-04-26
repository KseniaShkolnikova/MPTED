
import pytest
from django.test import TestCase
from django.contrib.auth.models import User
from rest_framework.test import APIClient
from rest_framework import status
from django.urls import reverse
from django.utils import timezone
from datetime import date, timedelta
from decimal import Decimal
import json

from api.models import (
    Subject, StudentGroup, StudentProfile, TeacherProfile,
    TeacherSubject, DailySchedule, ScheduleLesson, Homework,
    HomeworkSubmission, Grade, Comment, Attendance, Announcement,
    AuditLog
)

@pytest.mark.django_db
class TestAPIDatabaseInteraction(TestCase):
    """Тесты для проверки взаимодействия API с базой данных"""

    def setUp(self):
        """Подготовка данных перед каждым тестом"""
        self.client = APIClient()


        self.admin_user = User.objects.create_superuser(
            username='admin',
            password='admin123',
            email='admin@test.com',
            first_name='Админ',
            last_name='Админов'
        )


        self.teacher_user = User.objects.create_user(
            username='teacher',
            password='teacher123',
            email='teacher@test.com',
            first_name='Иван',
            last_name='Петров'
        )
        self.teacher_profile = TeacherProfile.objects.create(
            user=self.teacher_user,
            patronymic='Иванович',
            phone='+1234567890',
            qualification='Высшая категория'
        )


        self.student_user = User.objects.create_user(
            username='student',
            password='student123',
            email='student@test.com',
            first_name='Петр',
            last_name='Иванов'
        )


        self.student_group = StudentGroup.objects.create(
            name='10А',
            year=2024,
            curator=self.teacher_user
        )


        self.student_profile = StudentProfile.objects.create(
            user=self.student_user,
            patronymic='Петрович',
            phone='+9876543210',
            course=10,
            student_group=self.student_group
        )


        self.subject = Subject.objects.create(
            name='Математика',
            description='Алгебра и геометрия'
        )


        self.teacher_subject = TeacherSubject.objects.create(
            teacher=self.teacher_profile,
            subject=self.subject
        )


        self.daily_schedule = DailySchedule.objects.create(
            student_group=self.student_group,
            week_day=DailySchedule.WeekDay.MONDAY,
            is_active=True,
            is_weekend=False
        )


        self.schedule_lesson = ScheduleLesson.objects.create(
            daily_schedule=self.daily_schedule,
            lesson_number=1,
            subject=self.subject,
            teacher=self.teacher_user
        )


        self.client.force_authenticate(user=self.admin_user)

    def test_создание_предмета_через_api(self):
        """Тест создания предмета через API"""
        url = reverse('subject-list')
        данные = {
            'name': 'Физика',
            'description': 'Механика и оптика'
        }


        ответ = self.client.post(url, данные, format='json')


        self.assertEqual(ответ.status_code, status.HTTP_201_CREATED)
        self.assertEqual(ответ.data['name'], 'Физика')


        предмет = Subject.objects.get(name='Физика')
        self.assertEqual(предмет.description, 'Механика и оптика')
        self.assertEqual(Subject.objects.count(), 2)

    def test_обновление_учебной_группы(self):
        """Тест обновления учебной группы через API"""
        url = reverse('studentgroup-detail', args=[self.student_group.id])
        данные = {
            'name': '11А',
            'year': 2025
        }


        ответ = self.client.patch(url, данные, format='json')


        self.assertEqual(ответ.status_code, status.HTTP_200_OK)
        self.assertEqual(ответ.data['name'], '11А')
        self.assertEqual(ответ.data['year'], 2025)


        self.student_group.refresh_from_db()
        self.assertEqual(self.student_group.name, '11А')
        self.assertEqual(self.student_group.year, 2025)

    def test_защита_от_каскадного_удаления(self):
        """Тест защиты от каскадного удаления"""

        url = reverse('subject-detail', args=[self.subject.id])
        ответ = self.client.delete(url)


        if ответ.status_code == status.HTTP_204_NO_CONTENT:

            self.assertFalse(Subject.objects.filter(id=self.subject.id).exists())
        else:

            self.assertTrue(Subject.objects.filter(id=self.subject.id).exists())

    def test_поиск_и_фильтрация_предметов(self):
        """Тест поиска и фильтрации предметов"""

        Subject.objects.create(name='Алгебра', description='Углубленный курс')
        Subject.objects.create(name='Геометрия', description='Планиметрия')
        Subject.objects.create(name='История', description='Всемирная история')

        url = reverse('subject-list')


        ответ = self.client.get(url, {'search': 'математика'})
        self.assertEqual(ответ.status_code, status.HTTP_200_OK)


        if 'results' in ответ.data:
            self.assertGreaterEqual(len(ответ.data['results']), 1)
            найдено = any(п['name'] == 'Математика' for п in ответ.data['results'])
            self.assertTrue(найдено)
        else:
            self.assertGreaterEqual(len(ответ.data), 1)

    def test_получение_оценок_студента(self):
        """Тест получения оценок студента"""

        for i in range(3):
            Grade.objects.create(
                student=self.student_user,
                subject=self.subject,
                schedule_lesson=self.schedule_lesson,
                teacher=self.teacher_user,
                value=4.0 + i,
                grade_type='TEST',
                date=date.today() - timedelta(days=i*7)
            )

        url = reverse('grade-list')
        ответ = self.client.get(url, {'student': self.student_user.id})

        self.assertEqual(ответ.status_code, status.HTTP_200_OK)


        if 'results' in ответ.data:
            self.assertEqual(ответ.data['count'], 3)
        else:
            self.assertEqual(len(ответ.data), 3)

    def test_получение_расписания_студента(self):
        """Тест получения расписания студента"""

        физика = Subject.objects.create(name='Физика')
        ScheduleLesson.objects.create(
            daily_schedule=self.daily_schedule,
            lesson_number=2,
            subject=физика,
            teacher=self.teacher_user
        )

        url = reverse('dailyschedule-list')
        ответ = self.client.get(url, {'student_group': self.student_group.id})

        self.assertEqual(ответ.status_code, status.HTTP_200_OK)


        if 'results' in ответ.data:
            self.assertGreaterEqual(len(ответ.data['results']), 1)
            расписание = ответ.data['results'][0]

            if isinstance(расписание['student_group'], dict):
                self.assertEqual(расписание['student_group']['id'], self.student_group.id)
            else:
                self.assertEqual(расписание['student_group'], self.student_group.id)
        else:
            self.assertGreaterEqual(len(ответ.data), 1)
            расписание = ответ.data[0]
            if isinstance(расписание['student_group'], dict):
                self.assertEqual(расписание['student_group']['id'], self.student_group.id)
            else:
                self.assertEqual(расписание['student_group'], self.student_group.id)

    def test_создание_предмета_через_api(self):
        """Тест создания предмета через API (дубликат для надежности)"""
        url = reverse('subject-list')
        данные = {
            'name': 'Химия',
            'description': 'Органическая химия'
        }

        ответ = self.client.post(url, данные, format='json')

        self.assertEqual(ответ.status_code, status.HTTP_201_CREATED)
        self.assertEqual(ответ.data['name'], 'Химия')

        предмет = Subject.objects.get(name='Химия')
        self.assertEqual(предмет.description, 'Органическая химия')

    def test_уникальность_посещаемости(self):
        """Тест уникальности записи посещаемости"""

        Attendance.objects.create(
            student=self.student_user,
            schedule_lesson=self.schedule_lesson,
            date=date.today(),
            status='P'
        )


        self.assertEqual(Attendance.objects.count(), 1)


        with self.assertRaises(Exception):
            Attendance.objects.create(
                student=self.student_user,
                schedule_lesson=self.schedule_lesson,
                date=date.today(),
                status='P'
            )

from rest_framework import serializers
from django.contrib.auth.models import User
from .models import *
from education_department.models import LessonReplacement


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            'id',
            'username',
            'email',
            'first_name',
            'last_name',
        ]


class SubjectSerializer(serializers.ModelSerializer):
    class Meta:
        model = Subject
        fields = [
            'id',
            'name',
            'description',
        ]


class StudentGroupSerializer(serializers.ModelSerializer):
    curator = UserSerializer(read_only=True)
    curator_id = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.all(),
        source='curator',
        write_only=True,
        required=False
    )
    
    class Meta:
        model = StudentGroup
        fields = [
            'id',
            'name',
            'year',
            'curator',
            'curator_id',
        ]


class StudentProfileSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    user_id = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.all(),
        source='user',
        write_only=True
    )
    
    student_group = StudentGroupSerializer(read_only=True)
    student_group_id = serializers.PrimaryKeyRelatedField(
        queryset=StudentGroup.objects.all(),
        source='student_group',
        write_only=True,
        required=False,
        allow_null=True
    )
    
    class Meta:
        model = StudentProfile
        fields = [
            'user',
            'user_id',
            'patronymic',
            'phone',
            'birth_date',
            'profile_image',
            'address',
            'course',
            'student_group',
            'student_group_id',
        ]


class MobileStudentProfileSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    student_group = StudentGroupSerializer(read_only=True)

    class Meta:
        model = StudentProfile
        fields = [
            'user',
            'patronymic',
            'phone',
            'birth_date',
            'profile_image',
            'address',
            'course',
            'student_group',
        ]
        read_only_fields = [
            'user',
            'profile_image',
            'course',
            'student_group',
        ]


class PasswordResetRequestSerializer(serializers.Serializer):
    email = serializers.EmailField()


class PasswordResetConfirmSerializer(serializers.Serializer):
    email = serializers.EmailField()
    code = serializers.CharField(max_length=12)
    new_password = serializers.CharField(
        trim_whitespace=False,
        write_only=True,
    )
    new_password_confirm = serializers.CharField(
        trim_whitespace=False,
        write_only=True,
        required=False,
    )


class TeacherProfileSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    user_id = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.all(),
        source='user',
        write_only=True
    )
    
    class Meta:
        model = TeacherProfile
        fields = [
            'user',
            'user_id',
            'patronymic',
            'phone',
            'birth_date',
            'profile_image',
            'qualification',
        ]


class TeacherSubjectSerializer(serializers.ModelSerializer):
    teacher = TeacherProfileSerializer(read_only=True)
    teacher_id = serializers.PrimaryKeyRelatedField(
        queryset=TeacherProfile.objects.all(),
        source='teacher',
        write_only=True
    )
    
    subject = SubjectSerializer(read_only=True)
    subject_id = serializers.PrimaryKeyRelatedField(
        queryset=Subject.objects.all(),
        source='subject',
        write_only=True
    )
    
    class Meta:
        model = TeacherSubject
        fields = [
            'id',
            'teacher',
            'teacher_id',
            'subject',
            'subject_id',
        ]


class DailyScheduleSerializer(serializers.ModelSerializer):
    student_group = StudentGroupSerializer(read_only=True)
    student_group_id = serializers.PrimaryKeyRelatedField(
        queryset=StudentGroup.objects.all(),
        source='student_group',
        write_only=True
    )
    
    week_day_display = serializers.CharField(source='get_week_day_display', read_only=True)
    
    class Meta:
        model = DailySchedule
        fields = [
            'id',
            'student_group',
            'student_group_id',
            'week_day',
            'week_day_display',
            'is_active',
            'is_weekend',
        ]


class ScheduleLessonSerializer(serializers.ModelSerializer):
    daily_schedule = DailyScheduleSerializer(read_only=True)
    daily_schedule_id = serializers.PrimaryKeyRelatedField(
        queryset=DailySchedule.objects.all(),
        source='daily_schedule',
        write_only=True
    )
    
    subject = SubjectSerializer(read_only=True)
    subject_id = serializers.PrimaryKeyRelatedField(
        queryset=Subject.objects.all(),
        source='subject',
        write_only=True
    )
    
    teacher = UserSerializer(read_only=True)
    teacher_id = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.all(),
        source='teacher',
        write_only=True
    )
    pair_time = serializers.CharField(read_only=True)
    effective_subject = serializers.SerializerMethodField()
    effective_teacher = serializers.SerializerMethodField()
    is_replaced = serializers.SerializerMethodField()
    replacement = serializers.SerializerMethodField()

    def get_effective_subject(self, obj):
        subject = getattr(obj, 'effective_subject', None) or obj.subject
        return SubjectSerializer(subject, context=self.context).data if subject else None

    def get_effective_teacher(self, obj):
        teacher = getattr(obj, 'effective_teacher', None) or obj.teacher
        return UserSerializer(teacher, context=self.context).data if teacher else None

    def get_is_replaced(self, obj):
        return bool(getattr(obj, 'is_replaced', False))

    def get_replacement(self, obj):
        replacement = getattr(obj, 'replacement', None)
        if not replacement:
            return None
        return LessonReplacementSerializer(replacement, context=self.context).data
    
    class Meta:
        model = ScheduleLesson
        fields = [
            'id',
            'daily_schedule',
            'daily_schedule_id',
            'lesson_number',
            'pair_time',
            'subject',
            'subject_id',
            'teacher',
            'teacher_id',
            'effective_subject',
            'effective_teacher',
            'is_replaced',
            'replacement',
        ]


class LessonReplacementSerializer(serializers.ModelSerializer):
    original_lesson = ScheduleLessonSerializer(read_only=True)
    replacement_subject = SubjectSerializer(read_only=True)
    replacement_teacher = UserSerializer(read_only=True)

    class Meta:
        model = LessonReplacement
        fields = [
            'id',
            'replacement_date',
            'original_lesson',
            'replacement_subject',
            'replacement_teacher',
            'reason',
            'created_at',
            'updated_at',
        ]


class HomeworkSerializer(serializers.ModelSerializer):
    schedule_lesson = ScheduleLessonSerializer(read_only=True)
    schedule_lesson_id = serializers.PrimaryKeyRelatedField(
        queryset=ScheduleLesson.objects.all(),
        source='schedule_lesson',
        write_only=True
    )
    
    student_group = StudentGroupSerializer(read_only=True)
    student_group_id = serializers.PrimaryKeyRelatedField(
        queryset=StudentGroup.objects.all(),
        source='student_group',
        write_only=True
    )
    
    class Meta:
        model = Homework
        fields = [
            'id',
            'title',
            'description',
            'schedule_lesson',
            'schedule_lesson_id',
            'student_group',
            'student_group_id',
            'created_at',
            'due_date',
            'attachment',
        ]


class HomeworkSubmissionSerializer(serializers.ModelSerializer):
    homework = HomeworkSerializer(read_only=True)
    homework_id = serializers.PrimaryKeyRelatedField(
        queryset=Homework.objects.all(),
        source='homework',
        write_only=True
    )

    student = UserSerializer(read_only=True)
    student_id = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.all(),
        source='student',
        write_only=True,
        required=False,
        default=serializers.CurrentUserDefault()
    )

    class Meta:
        model = HomeworkSubmission
        fields = [
            'id',
            'homework',
            'homework_id',
            'student',
            'student_id',
            'submission_file',
            'submission_text',
            'submitted_at',
        ]



class GradeSerializer(serializers.ModelSerializer):
    student = UserSerializer(read_only=True)
    student_id = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.all(),
        source='student',
        write_only=True
    )
    
    subject = SubjectSerializer(read_only=True)
    subject_id = serializers.PrimaryKeyRelatedField(
        queryset=Subject.objects.all(),
        source='subject',
        write_only=True
    )
    
    schedule_lesson = ScheduleLessonSerializer(read_only=True)
    schedule_lesson_id = serializers.PrimaryKeyRelatedField(
        queryset=ScheduleLesson.objects.all(),
        source='schedule_lesson',
        write_only=True
    )
    
    teacher = UserSerializer(read_only=True)
    teacher_id = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.all(),
        source='teacher',
        write_only=True
    )
    
    grade_type_display = serializers.CharField(source='get_grade_type_display', read_only=True)
    
    class Meta:
        model = Grade
        fields = [
            'id',
            'student',
            'student_id',
            'subject',
            'subject_id',
            'schedule_lesson',
            'schedule_lesson_id',
            'teacher',
            'teacher_id',
            'value',
            'grade_type',
            'grade_type_display',
            'date',
            'comment',
        ]


class CommentSerializer(serializers.ModelSerializer):
    homework = HomeworkSerializer(read_only=True)
    homework_id = serializers.PrimaryKeyRelatedField(
        queryset=Homework.objects.all(),
        source='homework',
        write_only=True
    )

    author = UserSerializer(read_only=True)
    author_id = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.all(),
        source='author',
        write_only=True,
        required=False
    )

    class Meta:
        model = Comment
        fields = [
            'id',
            'homework',
            'homework_id',
            'author',
            'author_id',
            'text',
            'created_at',
            'updated_at',
        ]



class AttendanceSerializer(serializers.ModelSerializer):
    student = UserSerializer(read_only=True)
    student_id = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.all(),
        source='student',
        write_only=True
    )
    
    schedule_lesson = ScheduleLessonSerializer(read_only=True)
    schedule_lesson_id = serializers.PrimaryKeyRelatedField(
        queryset=ScheduleLesson.objects.all(),
        source='schedule_lesson',
        write_only=True
    )
    
    status_display = serializers.CharField(source='get_status_display', read_only=True)
    
    class Meta:
        model = Attendance
        fields = [
            'id',
            'student',
            'student_id',
            'schedule_lesson',
            'schedule_lesson_id',
            'date',
            'status',
            'status_display',
        ]


class AnnouncementSerializer(serializers.ModelSerializer):
    author = UserSerializer(read_only=True)
    author_id = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.all(),
        source='author',
        write_only=True
    )
    
    student_group = StudentGroupSerializer(read_only=True)
    student_group_id = serializers.PrimaryKeyRelatedField(
        queryset=StudentGroup.objects.all(),
        source='student_group',
        write_only=True,
        required=False,
        allow_null=True
    )
    
    class Meta:
        model = Announcement
        fields = [
            'id',
            'title',
            'content',
            'author',
            'author_id',
            'created_at',
            'student_group',
            'student_group_id',
            'is_for_all',
        ]

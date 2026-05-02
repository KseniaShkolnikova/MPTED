from django.db import migrations


TRIGGER_TABLES = [
    ("audit_announcement_trigger", "api_announcement"),
    ("audit_attendance_trigger", "api_attendance"),
    ("audit_auth_user_trigger", "auth_user"),
    ("audit_comment_trigger", "api_comment"),
    ("audit_dailyschedule_trigger", "api_dailyschedule"),
    ("audit_grade_trigger", "api_grade"),
    ("audit_homework_trigger", "api_homework"),
    ("audit_homeworksubmission_trigger", "api_homeworksubmission"),
    ("audit_schedulelesson_trigger", "api_schedulelesson"),
    ("audit_studentgroup_trigger", "api_studentgroup"),
    ("audit_studentprofile_trigger", "api_studentprofile"),
    ("audit_subject_trigger", "api_subject"),
    ("audit_teacherprofile_trigger", "api_teacherprofile"),
    ("audit_teachersubject_trigger", "api_teachersubject"),
]


CREATE_AUDIT_FUNCTION_SQL = """
CREATE OR REPLACE FUNCTION public.audit_log_trigger_function() RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_action TEXT;
    v_user_id INTEGER;
    v_old_values JSONB;
    v_new_values JSONB;
    v_model_name TEXT;
    v_object_id TEXT;
    current_user_name TEXT;
BEGIN
    IF TG_OP = 'INSERT' THEN
        v_action := 'CREATE';
        v_old_values := NULL;
        v_new_values := to_jsonb(NEW);
    ELSIF TG_OP = 'UPDATE' THEN
        v_action := 'UPDATE';
        v_old_values := to_jsonb(OLD);
        v_new_values := to_jsonb(NEW);
    ELSIF TG_OP = 'DELETE' THEN
        v_action := 'DELETE';
        v_old_values := to_jsonb(OLD);
        v_new_values := NULL;
    END IF;

    v_object_id := NULL;

    IF TG_TABLE_NAME IN (
        'api_subject', 'api_studentgroup', 'api_teachersubject',
        'api_dailyschedule', 'api_schedulelesson', 'api_homework',
        'api_homeworksubmission', 'api_grade', 'api_comment',
        'api_attendance', 'api_announcement'
    ) THEN
        IF TG_OP = 'DELETE' THEN
            IF OLD.id IS NOT NULL THEN
                v_object_id := OLD.id::TEXT;
            END IF;
        ELSE
            IF NEW.id IS NOT NULL THEN
                v_object_id := NEW.id::TEXT;
            END IF;
        END IF;
    ELSIF TG_TABLE_NAME = 'api_studentprofile' THEN
        IF TG_OP = 'DELETE' THEN
            IF OLD.user_id IS NOT NULL THEN
                v_object_id := OLD.user_id::TEXT;
            END IF;
        ELSE
            IF NEW.user_id IS NOT NULL THEN
                v_object_id := NEW.user_id::TEXT;
            END IF;
        END IF;
    ELSIF TG_TABLE_NAME = 'api_teacherprofile' THEN
        IF TG_OP = 'DELETE' THEN
            IF OLD.user_id IS NOT NULL THEN
                v_object_id := OLD.user_id::TEXT;
            END IF;
        ELSE
            IF NEW.user_id IS NOT NULL THEN
                v_object_id := NEW.user_id::TEXT;
            END IF;
        END IF;
    ELSIF TG_TABLE_NAME = 'auth_user' THEN
        IF TG_OP = 'DELETE' THEN
            IF OLD.id IS NOT NULL THEN
                v_object_id := OLD.id::TEXT;
            END IF;
        ELSE
            IF NEW.id IS NOT NULL THEN
                v_object_id := NEW.id::TEXT;
            END IF;
        END IF;
    END IF;

    v_model_name := TG_TABLE_NAME;
    IF v_model_name = 'api_subject' THEN
        v_model_name := 'Subject';
    ELSIF v_model_name = 'api_studentgroup' THEN
        v_model_name := 'StudentGroup';
    ELSIF v_model_name = 'api_studentprofile' THEN
        v_model_name := 'StudentProfile';
    ELSIF v_model_name = 'api_teacherprofile' THEN
        v_model_name := 'TeacherProfile';
    ELSIF v_model_name = 'api_teachersubject' THEN
        v_model_name := 'TeacherSubject';
    ELSIF v_model_name = 'api_dailyschedule' THEN
        v_model_name := 'DailySchedule';
    ELSIF v_model_name = 'api_schedulelesson' THEN
        v_model_name := 'ScheduleLesson';
    ELSIF v_model_name = 'api_homework' THEN
        v_model_name := 'Homework';
    ELSIF v_model_name = 'api_homeworksubmission' THEN
        v_model_name := 'HomeworkSubmission';
    ELSIF v_model_name = 'api_grade' THEN
        v_model_name := 'Grade';
    ELSIF v_model_name = 'api_comment' THEN
        v_model_name := 'Comment';
    ELSIF v_model_name = 'api_attendance' THEN
        v_model_name := 'Attendance';
    ELSIF v_model_name = 'api_announcement' THEN
        v_model_name := 'Announcement';
    ELSIF v_model_name = 'auth_user' THEN
        v_model_name := 'User';
    END IF;

    BEGIN
        v_user_id := NULLIF(current_setting('app.current_user_id', TRUE), '')::INTEGER;
    EXCEPTION WHEN OTHERS THEN
        v_user_id := NULL;
    END;

    IF v_user_id IS NULL THEN
        BEGIN
            current_user_name := current_user;
            SELECT id INTO v_user_id
            FROM auth_user
            WHERE username = current_user_name
            LIMIT 1;
        EXCEPTION WHEN OTHERS THEN
            v_user_id := NULL;
        END;
    END IF;

    INSERT INTO api_auditlog (
        user_id,
        action,
        model_name,
        object_id,
        old_values,
        new_values,
        ip_address,
        user_agent,
        request_path,
        request_method,
        timestamp,
        is_system_action
    ) VALUES (
        v_user_id,
        v_action,
        v_model_name,
        v_object_id,
        CASE WHEN v_old_values IS NOT NULL THEN v_old_values::JSON END,
        CASE WHEN v_new_values IS NOT NULL THEN v_new_values::JSON END,
        NULL,
        NULL,
        NULL,
        NULL,
        NOW(),
        (v_user_id IS NULL)
    );

    IF TG_OP = 'DELETE' THEN
        RETURN OLD;
    END IF;

    RETURN NEW;
END;
$$;
"""


def apply_audit_triggers(apps, schema_editor):
    if schema_editor.connection.vendor != "postgresql":
        return

    schema_editor.execute(CREATE_AUDIT_FUNCTION_SQL)

    for trigger_name, table_name in TRIGGER_TABLES:
        schema_editor.execute(
            f"DROP TRIGGER IF EXISTS {trigger_name} ON public.{table_name};"
        )
        schema_editor.execute(
            f"""
            CREATE TRIGGER {trigger_name}
            AFTER INSERT OR DELETE OR UPDATE ON public.{table_name}
            FOR EACH ROW EXECUTE FUNCTION public.audit_log_trigger_function();
            """
        )


def remove_audit_triggers(apps, schema_editor):
    if schema_editor.connection.vendor != "postgresql":
        return

    for trigger_name, table_name in TRIGGER_TABLES:
        schema_editor.execute(
            f"DROP TRIGGER IF EXISTS {trigger_name} ON public.{table_name};"
        )

    schema_editor.execute(
        "DROP FUNCTION IF EXISTS public.audit_log_trigger_function();"
    )


class Migration(migrations.Migration):

    dependencies = [
        ("api", "0005_passwordresetcode"),
    ]

    operations = [
        migrations.RunPython(
            apply_audit_triggers,
            remove_audit_triggers,
        ),
    ]

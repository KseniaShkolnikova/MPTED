--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.education_department_lessonreplacement DROP CONSTRAINT IF EXISTS education_department_replacement_teacher__c4fffc98_fk_auth_user;
ALTER TABLE IF EXISTS ONLY public.education_department_lessonreplacement DROP CONSTRAINT IF EXISTS education_department_replacement_subject__fcce4c62_fk_api_subje;
ALTER TABLE IF EXISTS ONLY public.education_department_lessonreplacement DROP CONSTRAINT IF EXISTS education_department_original_lesson_id_fa81ae34_fk_api_sched;
ALTER TABLE IF EXISTS ONLY public.education_department_lessonreplacement DROP CONSTRAINT IF EXISTS education_department_created_by_id_2fd1f472_fk_auth_user;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_user_id_c564eba6_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_content_type_id_c4bce8eb_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.backup_service_databasebackup DROP CONSTRAINT IF EXISTS backup_service_datab_created_by_id_2d1023bc_fk_auth_user;
ALTER TABLE IF EXISTS ONLY public.backup_service_backuplog DROP CONSTRAINT IF EXISTS backup_service_backuplog_user_id_c807c693_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.backup_service_backuplog DROP CONSTRAINT IF EXISTS backup_service_backu_backup_id_66f290e9_fk_backup_se;
ALTER TABLE IF EXISTS ONLY public.authtoken_token DROP CONSTRAINT IF EXISTS authtoken_token_user_id_35299eff_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_user_id_6a12ed8b_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_group_id_97559544_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_2f476e4b_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.api_teachersubject DROP CONSTRAINT IF EXISTS api_teachersubject_teacher_id_c19a5845_fk_api_teach;
ALTER TABLE IF EXISTS ONLY public.api_teachersubject DROP CONSTRAINT IF EXISTS api_teachersubject_subject_id_2fe1cb1f_fk_api_subject_id;
ALTER TABLE IF EXISTS ONLY public.api_teacherprofile DROP CONSTRAINT IF EXISTS api_teacherprofile_user_id_62a77e96_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.api_studentprofile DROP CONSTRAINT IF EXISTS api_studentprofile_user_id_552393d1_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.api_studentprofile DROP CONSTRAINT IF EXISTS api_studentprofile_student_group_id_884d8218_fk_api_stude;
ALTER TABLE IF EXISTS ONLY public.api_studentgroup DROP CONSTRAINT IF EXISTS api_studentgroup_curator_id_526e8903_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.api_schedulelesson DROP CONSTRAINT IF EXISTS api_schedulelesson_teacher_id_42e42734_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.api_schedulelesson DROP CONSTRAINT IF EXISTS api_schedulelesson_subject_id_2834210c_fk_api_subject_id;
ALTER TABLE IF EXISTS ONLY public.api_schedulelesson DROP CONSTRAINT IF EXISTS api_schedulelesson_daily_schedule_id_6061c1eb_fk_api_daily;
ALTER TABLE IF EXISTS ONLY public.api_homeworksubmission DROP CONSTRAINT IF EXISTS api_homeworksubmission_student_id_44163573_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.api_homeworksubmission DROP CONSTRAINT IF EXISTS api_homeworksubmission_homework_id_c940442b_fk_api_homework_id;
ALTER TABLE IF EXISTS ONLY public.api_homework DROP CONSTRAINT IF EXISTS api_homework_student_group_id_f0c6778a_fk_api_studentgroup_id;
ALTER TABLE IF EXISTS ONLY public.api_homework DROP CONSTRAINT IF EXISTS api_homework_schedule_lesson_id_80e076e8_fk_api_sched;
ALTER TABLE IF EXISTS ONLY public.api_grade DROP CONSTRAINT IF EXISTS api_grade_teacher_id_fd728fbb_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.api_grade DROP CONSTRAINT IF EXISTS api_grade_subject_id_491e7cc2_fk_api_subject_id;
ALTER TABLE IF EXISTS ONLY public.api_grade DROP CONSTRAINT IF EXISTS api_grade_student_id_83a2fc66_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.api_grade DROP CONSTRAINT IF EXISTS api_grade_schedule_lesson_id_e2750971_fk_api_schedulelesson_id;
ALTER TABLE IF EXISTS ONLY public.api_dailyschedule DROP CONSTRAINT IF EXISTS api_dailyschedule_student_group_id_43930f69_fk_api_stude;
ALTER TABLE IF EXISTS ONLY public.api_comment DROP CONSTRAINT IF EXISTS api_comment_homework_id_3931172d_fk_api_homework_id;
ALTER TABLE IF EXISTS ONLY public.api_comment DROP CONSTRAINT IF EXISTS api_comment_author_id_c45b2dbf_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.api_auditlog DROP CONSTRAINT IF EXISTS api_auditlog_user_id_b15d4175_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.api_attendance DROP CONSTRAINT IF EXISTS api_attendance_student_id_a3cfd463_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.api_attendance DROP CONSTRAINT IF EXISTS api_attendance_schedule_lesson_id_4b78f904_fk_api_sched;
ALTER TABLE IF EXISTS ONLY public.api_announcement DROP CONSTRAINT IF EXISTS api_announcement_student_group_id_200311ba_fk_api_stude;
ALTER TABLE IF EXISTS ONLY public.api_announcement DROP CONSTRAINT IF EXISTS api_announcement_author_id_15102650_fk_auth_user_id;
DROP TRIGGER IF EXISTS audit_teachersubject_trigger ON public.api_teachersubject;
DROP TRIGGER IF EXISTS audit_teacherprofile_trigger ON public.api_teacherprofile;
DROP TRIGGER IF EXISTS audit_subject_trigger ON public.api_subject;
DROP TRIGGER IF EXISTS audit_studentprofile_trigger ON public.api_studentprofile;
DROP TRIGGER IF EXISTS audit_studentgroup_trigger ON public.api_studentgroup;
DROP TRIGGER IF EXISTS audit_schedulelesson_trigger ON public.api_schedulelesson;
DROP TRIGGER IF EXISTS audit_homeworksubmission_trigger ON public.api_homeworksubmission;
DROP TRIGGER IF EXISTS audit_homework_trigger ON public.api_homework;
DROP TRIGGER IF EXISTS audit_grade_trigger ON public.api_grade;
DROP TRIGGER IF EXISTS audit_dailyschedule_trigger ON public.api_dailyschedule;
DROP TRIGGER IF EXISTS audit_comment_trigger ON public.api_comment;
DROP TRIGGER IF EXISTS audit_auth_user_trigger ON public.auth_user;
DROP TRIGGER IF EXISTS audit_attendance_trigger ON public.api_attendance;
DROP TRIGGER IF EXISTS audit_announcement_trigger ON public.api_announcement;
DROP INDEX IF EXISTS public.education_department_lessonreplacement_created_by_id_2fd1f472;
DROP INDEX IF EXISTS public.education_department_lesso_replacement_teacher_id_c4fffc98;
DROP INDEX IF EXISTS public.education_department_lesso_replacement_subject_id_fcce4c62;
DROP INDEX IF EXISTS public.education_department_lesso_replacement_date_6a50e108;
DROP INDEX IF EXISTS public.education_department_lesso_original_lesson_id_fa81ae34;
DROP INDEX IF EXISTS public.django_session_session_key_c0390e0f_like;
DROP INDEX IF EXISTS public.django_session_expire_date_a5c62663;
DROP INDEX IF EXISTS public.django_admin_log_user_id_c564eba6;
DROP INDEX IF EXISTS public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX IF EXISTS public.backup_service_databasebackup_created_by_id_2d1023bc;
DROP INDEX IF EXISTS public.backup_service_backuplog_user_id_c807c693;
DROP INDEX IF EXISTS public.backup_service_backuplog_backup_id_66f290e9;
DROP INDEX IF EXISTS public.authtoken_token_key_10f0b77e_like;
DROP INDEX IF EXISTS public.auth_user_username_6821ab7c_like;
DROP INDEX IF EXISTS public.auth_user_user_permissions_user_id_a95ead1b;
DROP INDEX IF EXISTS public.auth_user_user_permissions_permission_id_1fbb5f2c;
DROP INDEX IF EXISTS public.auth_user_groups_user_id_6a12ed8b;
DROP INDEX IF EXISTS public.auth_user_groups_group_id_97559544;
DROP INDEX IF EXISTS public.auth_permission_content_type_id_2f476e4b;
DROP INDEX IF EXISTS public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX IF EXISTS public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX IF EXISTS public.auth_group_name_a6ea08ec_like;
DROP INDEX IF EXISTS public.api_teachersubject_teacher_id_c19a5845;
DROP INDEX IF EXISTS public.api_teachersubject_subject_id_2fe1cb1f;
DROP INDEX IF EXISTS public.api_subject_name_2445dd86_like;
DROP INDEX IF EXISTS public.api_studentprofile_student_group_id_884d8218;
DROP INDEX IF EXISTS public.api_studentgroup_curator_id_526e8903;
DROP INDEX IF EXISTS public.api_schedulelesson_teacher_id_42e42734;
DROP INDEX IF EXISTS public.api_schedulelesson_subject_id_2834210c;
DROP INDEX IF EXISTS public.api_schedulelesson_daily_schedule_id_6061c1eb;
DROP INDEX IF EXISTS public.api_homeworksubmission_student_id_44163573;
DROP INDEX IF EXISTS public.api_homeworksubmission_homework_id_c940442b;
DROP INDEX IF EXISTS public.api_homework_student_group_id_f0c6778a;
DROP INDEX IF EXISTS public.api_homework_schedule_lesson_id_80e076e8;
DROP INDEX IF EXISTS public.api_grade_teacher_id_fd728fbb;
DROP INDEX IF EXISTS public.api_grade_subject_id_491e7cc2;
DROP INDEX IF EXISTS public.api_grade_student_id_83a2fc66;
DROP INDEX IF EXISTS public.api_grade_schedule_lesson_id_e2750971;
DROP INDEX IF EXISTS public.api_dailyschedule_student_group_id_43930f69;
DROP INDEX IF EXISTS public.api_comment_homework_id_3931172d;
DROP INDEX IF EXISTS public.api_comment_author_id_c45b2dbf;
DROP INDEX IF EXISTS public.api_auditlog_user_id_b15d4175;
DROP INDEX IF EXISTS public.api_auditlo_user_id_8f69e8_idx;
DROP INDEX IF EXISTS public.api_auditlo_timesta_da87a7_idx;
DROP INDEX IF EXISTS public.api_auditlo_model_n_a416ae_idx;
DROP INDEX IF EXISTS public.api_attendance_student_id_a3cfd463;
DROP INDEX IF EXISTS public.api_attendance_schedule_lesson_id_4b78f904;
DROP INDEX IF EXISTS public.api_announcement_student_group_id_200311ba;
DROP INDEX IF EXISTS public.api_announcement_author_id_15102650;
ALTER TABLE IF EXISTS ONLY public.education_department_lessonreplacement DROP CONSTRAINT IF EXISTS education_department_lessonreplacement_pkey;
ALTER TABLE IF EXISTS ONLY public.education_department_lessonreplacement DROP CONSTRAINT IF EXISTS education_department_les_replacement_date_origina_3b03f127_uniq;
ALTER TABLE IF EXISTS ONLY public.django_session DROP CONSTRAINT IF EXISTS django_session_pkey;
ALTER TABLE IF EXISTS ONLY public.django_migrations DROP CONSTRAINT IF EXISTS django_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_pkey;
ALTER TABLE IF EXISTS ONLY public.backup_service_databasebackup DROP CONSTRAINT IF EXISTS backup_service_databasebackup_pkey;
ALTER TABLE IF EXISTS ONLY public.backup_service_backupschedule DROP CONSTRAINT IF EXISTS backup_service_backupschedule_pkey;
ALTER TABLE IF EXISTS ONLY public.backup_service_backuplog DROP CONSTRAINT IF EXISTS backup_service_backuplog_pkey;
ALTER TABLE IF EXISTS ONLY public.authtoken_token DROP CONSTRAINT IF EXISTS authtoken_token_user_id_key;
ALTER TABLE IF EXISTS ONLY public.authtoken_token DROP CONSTRAINT IF EXISTS authtoken_token_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_user DROP CONSTRAINT IF EXISTS auth_user_username_key;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permissions_user_id_permission_id_14a6b632_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_user DROP CONSTRAINT IF EXISTS auth_user_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_user_id_group_id_94350c0c_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_name_key;
ALTER TABLE IF EXISTS ONLY public.api_teachersubject DROP CONSTRAINT IF EXISTS api_teachersubject_teacher_id_subject_id_1b83d189_uniq;
ALTER TABLE IF EXISTS ONLY public.api_teachersubject DROP CONSTRAINT IF EXISTS api_teachersubject_pkey;
ALTER TABLE IF EXISTS ONLY public.api_teacherprofile DROP CONSTRAINT IF EXISTS api_teacherprofile_pkey;
ALTER TABLE IF EXISTS ONLY public.api_subject DROP CONSTRAINT IF EXISTS api_subject_pkey;
ALTER TABLE IF EXISTS ONLY public.api_subject DROP CONSTRAINT IF EXISTS api_subject_name_key;
ALTER TABLE IF EXISTS ONLY public.api_studentprofile DROP CONSTRAINT IF EXISTS api_studentprofile_pkey;
ALTER TABLE IF EXISTS ONLY public.api_studentgroup DROP CONSTRAINT IF EXISTS api_studentgroup_pkey;
ALTER TABLE IF EXISTS ONLY public.api_studentgroup DROP CONSTRAINT IF EXISTS api_studentgroup_name_year_d53ad551_uniq;
ALTER TABLE IF EXISTS ONLY public.api_schedulelesson DROP CONSTRAINT IF EXISTS api_schedulelesson_pkey;
ALTER TABLE IF EXISTS ONLY public.api_schedulelesson DROP CONSTRAINT IF EXISTS api_schedulelesson_daily_schedule_id_lesson_e7dc0c98_uniq;
ALTER TABLE IF EXISTS ONLY public.api_homeworksubmission DROP CONSTRAINT IF EXISTS api_homeworksubmission_pkey;
ALTER TABLE IF EXISTS ONLY public.api_homeworksubmission DROP CONSTRAINT IF EXISTS api_homeworksubmission_homework_id_student_id_0f973ce8_uniq;
ALTER TABLE IF EXISTS ONLY public.api_homework DROP CONSTRAINT IF EXISTS api_homework_pkey;
ALTER TABLE IF EXISTS ONLY public.api_grade DROP CONSTRAINT IF EXISTS api_grade_pkey;
ALTER TABLE IF EXISTS ONLY public.api_dailyschedule DROP CONSTRAINT IF EXISTS api_dailyschedule_student_group_id_week_day_cdc4a0f4_uniq;
ALTER TABLE IF EXISTS ONLY public.api_dailyschedule DROP CONSTRAINT IF EXISTS api_dailyschedule_pkey;
ALTER TABLE IF EXISTS ONLY public.api_comment DROP CONSTRAINT IF EXISTS api_comment_pkey;
ALTER TABLE IF EXISTS ONLY public.api_auditlog DROP CONSTRAINT IF EXISTS api_auditlog_pkey;
ALTER TABLE IF EXISTS ONLY public.api_attendance DROP CONSTRAINT IF EXISTS api_attendance_student_id_schedule_lesson_id_date_b5aa0c39_uniq;
ALTER TABLE IF EXISTS ONLY public.api_attendance DROP CONSTRAINT IF EXISTS api_attendance_pkey;
ALTER TABLE IF EXISTS ONLY public.api_announcement DROP CONSTRAINT IF EXISTS api_announcement_pkey;
DROP TABLE IF EXISTS public.education_department_lessonreplacement;
DROP TABLE IF EXISTS public.django_session;
DROP TABLE IF EXISTS public.django_migrations;
DROP TABLE IF EXISTS public.django_content_type;
DROP TABLE IF EXISTS public.django_admin_log;
DROP TABLE IF EXISTS public.backup_service_databasebackup;
DROP TABLE IF EXISTS public.backup_service_backupschedule;
DROP TABLE IF EXISTS public.backup_service_backuplog;
DROP TABLE IF EXISTS public.authtoken_token;
DROP TABLE IF EXISTS public.auth_user_user_permissions;
DROP TABLE IF EXISTS public.auth_user_groups;
DROP TABLE IF EXISTS public.auth_user;
DROP TABLE IF EXISTS public.auth_permission;
DROP TABLE IF EXISTS public.auth_group_permissions;
DROP TABLE IF EXISTS public.auth_group;
DROP TABLE IF EXISTS public.api_teachersubject;
DROP TABLE IF EXISTS public.api_teacherprofile;
DROP TABLE IF EXISTS public.api_subject;
DROP TABLE IF EXISTS public.api_studentprofile;
DROP TABLE IF EXISTS public.api_studentgroup;
DROP TABLE IF EXISTS public.api_schedulelesson;
DROP TABLE IF EXISTS public.api_homeworksubmission;
DROP TABLE IF EXISTS public.api_homework;
DROP TABLE IF EXISTS public.api_grade;
DROP TABLE IF EXISTS public.api_dailyschedule;
DROP TABLE IF EXISTS public.api_comment;
DROP TABLE IF EXISTS public.api_auditlog;
DROP TABLE IF EXISTS public.api_attendance;
DROP TABLE IF EXISTS public.api_announcement;
DROP FUNCTION IF EXISTS public.audit_log_trigger_function();
--
-- Name: audit_log_trigger_function(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.audit_log_trigger_function() RETURNS trigger
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
    -- Определяем действие
    IF (TG_OP = 'INSERT') THEN
        v_action := 'CREATE';
        v_old_values := NULL;
        v_new_values := to_jsonb(NEW);
        
        -- Получаем ID объекта в зависимости от таблицы
        v_object_id := NULL;
        
        -- Для таблиц с полем id
        IF TG_TABLE_NAME IN (
            'api_subject', 'api_studentgroup', 'api_teachersubject',
            'api_dailyschedule', 'api_schedulelesson', 'api_homework',
            'api_homeworksubmission', 'api_grade', 'api_comment',
            'api_attendance', 'api_announcement'
        ) THEN
            -- Эти таблицы имеют поле id
            IF NEW.id IS NOT NULL THEN
                v_object_id := NEW.id::TEXT;
            END IF;
            
        -- Для таблиц профилей (user_id - первичный ключ)
        ELSIF TG_TABLE_NAME = 'api_studentprofile' THEN
            IF NEW.user_id IS NOT NULL THEN
                v_object_id := NEW.user_id::TEXT;
            END IF;
            
        ELSIF TG_TABLE_NAME = 'api_teacherprofile' THEN
            IF NEW.user_id IS NOT NULL THEN
                v_object_id := NEW.user_id::TEXT;
            END IF;
            
        -- Для таблицы auth_user
        ELSIF TG_TABLE_NAME = 'auth_user' THEN
            IF NEW.id IS NOT NULL THEN
                v_object_id := NEW.id::TEXT;
            END IF;
        END IF;
        
    ELSIF (TG_OP = 'UPDATE') THEN
        v_action := 'UPDATE';
        v_old_values := to_jsonb(OLD);
        v_new_values := to_jsonb(NEW);
        
        -- Получаем ID объекта в зависимости от таблицы
        v_object_id := NULL;
        
        -- Для таблиц с полем id
        IF TG_TABLE_NAME IN (
            'api_subject', 'api_studentgroup', 'api_teachersubject',
            'api_dailyschedule', 'api_schedulelesson', 'api_homework',
            'api_homeworksubmission', 'api_grade', 'api_comment',
            'api_attendance', 'api_announcement'
        ) THEN
            -- Эти таблицы имеют поле id
            IF NEW.id IS NOT NULL THEN
                v_object_id := NEW.id::TEXT;
            END IF;
            
        -- Для таблиц профилей (user_id - первичный ключ)
        ELSIF TG_TABLE_NAME = 'api_studentprofile' THEN
            IF NEW.user_id IS NOT NULL THEN
                v_object_id := NEW.user_id::TEXT;
            END IF;
            
        ELSIF TG_TABLE_NAME = 'api_teacherprofile' THEN
            IF NEW.user_id IS NOT NULL THEN
                v_object_id := NEW.user_id::TEXT;
            END IF;
            
        -- Для таблицы auth_user
        ELSIF TG_TABLE_NAME = 'auth_user' THEN
            IF NEW.id IS NOT NULL THEN
                v_object_id := NEW.id::TEXT;
            END IF;
        END IF;
        
    ELSIF (TG_OP = 'DELETE') THEN
        v_action := 'DELETE';
        v_old_values := to_jsonb(OLD);
        v_new_values := NULL;
        
        -- Получаем ID объекта в зависимости от таблицы
        v_object_id := NULL;
        
        -- Для таблиц с полем id
        IF TG_TABLE_NAME IN (
            'api_subject', 'api_studentgroup', 'api_teachersubject',
            'api_dailyschedule', 'api_schedulelesson', 'api_homework',
            'api_homeworksubmission', 'api_grade', 'api_comment',
            'api_attendance', 'api_announcement'
        ) THEN
            -- Эти таблицы имеют поле id
            IF OLD.id IS NOT NULL THEN
                v_object_id := OLD.id::TEXT;
            END IF;
            
        -- Для таблиц профилей (user_id - первичный ключ)
        ELSIF TG_TABLE_NAME = 'api_studentprofile' THEN
            IF OLD.user_id IS NOT NULL THEN
                v_object_id := OLD.user_id::TEXT;
            END IF;
            
        ELSIF TG_TABLE_NAME = 'api_teacherprofile' THEN
            IF OLD.user_id IS NOT NULL THEN
                v_object_id := OLD.user_id::TEXT;
            END IF;
            
        -- Для таблицы auth_user
        ELSIF TG_TABLE_NAME = 'auth_user' THEN
            IF OLD.id IS NOT NULL THEN
                v_object_id := OLD.id::TEXT;
            END IF;
        END IF;
        
    END IF;
    
    -- Определяем имя модели из имени таблицы
    v_model_name := TG_TABLE_NAME;
    
    -- Преобразуем имя таблицы в читаемый формат
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
    
    -- Пытаемся определить пользователя из контекста
    BEGIN
        -- Пытаемся получить текущего пользователя из сессии
        v_user_id := NULLIF(current_setting('app.current_user_id', TRUE), '')::INTEGER;
    EXCEPTION WHEN OTHERS THEN
        v_user_id := NULL;
    END;
    
    -- Если не удалось получить из контекста, пробуем найти по имени пользователя
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
    
    -- Вставляем запись в таблицу аудита
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
    
    -- Возвращаем соответствующий результат
    IF (TG_OP = 'DELETE') THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;
    
END;
$$;


ALTER FUNCTION public.audit_log_trigger_function() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: api_announcement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_announcement (
    id bigint NOT NULL,
    title character varying(200) NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    is_for_all boolean NOT NULL,
    author_id integer NOT NULL,
    student_group_id bigint
);


ALTER TABLE public.api_announcement OWNER TO postgres;

--
-- Name: api_announcement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.api_announcement ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_announcement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_attendance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_attendance (
    id bigint NOT NULL,
    date date NOT NULL,
    status character varying(1) NOT NULL,
    student_id integer NOT NULL,
    schedule_lesson_id bigint NOT NULL
);


ALTER TABLE public.api_attendance OWNER TO postgres;

--
-- Name: api_attendance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.api_attendance ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_attendance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_auditlog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_auditlog (
    id bigint NOT NULL,
    action character varying(20) NOT NULL,
    model_name character varying(100) NOT NULL,
    object_id character varying(100),
    old_values jsonb,
    new_values jsonb,
    ip_address inet,
    user_agent text,
    request_path character varying(500),
    request_method character varying(10),
    "timestamp" timestamp with time zone NOT NULL,
    is_system_action boolean NOT NULL,
    user_id integer
);


ALTER TABLE public.api_auditlog OWNER TO postgres;

--
-- Name: api_auditlog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.api_auditlog ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_auditlog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_comment (
    id bigint NOT NULL,
    text text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    author_id integer NOT NULL,
    homework_id bigint NOT NULL
);


ALTER TABLE public.api_comment OWNER TO postgres;

--
-- Name: api_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.api_comment ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_dailyschedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_dailyschedule (
    id bigint NOT NULL,
    week_day character varying(3) NOT NULL,
    is_active boolean NOT NULL,
    student_group_id bigint NOT NULL,
    is_weekend boolean NOT NULL
);


ALTER TABLE public.api_dailyschedule OWNER TO postgres;

--
-- Name: api_dailyschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.api_dailyschedule ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_dailyschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_grade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_grade (
    id bigint NOT NULL,
    value numeric(3,1) NOT NULL,
    grade_type character varying(10) NOT NULL,
    date date NOT NULL,
    comment text NOT NULL,
    student_id integer NOT NULL,
    teacher_id integer NOT NULL,
    schedule_lesson_id bigint NOT NULL,
    subject_id bigint NOT NULL
);


ALTER TABLE public.api_grade OWNER TO postgres;

--
-- Name: api_grade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.api_grade ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_grade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_homework; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_homework (
    id bigint NOT NULL,
    title character varying(200) NOT NULL,
    description text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    due_date timestamp with time zone NOT NULL,
    attachment character varying(100),
    schedule_lesson_id bigint NOT NULL,
    student_group_id bigint NOT NULL
);


ALTER TABLE public.api_homework OWNER TO postgres;

--
-- Name: api_homework_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.api_homework ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_homework_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_homeworksubmission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_homeworksubmission (
    id bigint NOT NULL,
    submission_file character varying(100) NOT NULL,
    submission_text text NOT NULL,
    submitted_at timestamp with time zone NOT NULL,
    homework_id bigint NOT NULL,
    student_id integer NOT NULL
);


ALTER TABLE public.api_homeworksubmission OWNER TO postgres;

--
-- Name: api_homeworksubmission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.api_homeworksubmission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_homeworksubmission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_schedulelesson; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_schedulelesson (
    id bigint NOT NULL,
    lesson_number integer NOT NULL,
    daily_schedule_id bigint NOT NULL,
    teacher_id integer NOT NULL,
    subject_id bigint NOT NULL
);


ALTER TABLE public.api_schedulelesson OWNER TO postgres;

--
-- Name: api_schedulelesson_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.api_schedulelesson ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_schedulelesson_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_studentgroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_studentgroup (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    year integer NOT NULL,
    curator_id integer
);


ALTER TABLE public.api_studentgroup OWNER TO postgres;

--
-- Name: api_studentgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.api_studentgroup ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_studentgroup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_studentprofile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_studentprofile (
    user_id integer NOT NULL,
    patronymic character varying(50) NOT NULL,
    phone character varying(20) NOT NULL,
    birth_date date,
    profile_image character varying(100),
    address text NOT NULL,
    course integer NOT NULL,
    student_group_id bigint
);


ALTER TABLE public.api_studentprofile OWNER TO postgres;

--
-- Name: api_subject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_subject (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.api_subject OWNER TO postgres;

--
-- Name: api_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.api_subject ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_subject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_teacherprofile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_teacherprofile (
    user_id integer NOT NULL,
    patronymic character varying(50) NOT NULL,
    phone character varying(20) NOT NULL,
    birth_date date,
    profile_image character varying(100),
    qualification character varying(100) NOT NULL
);


ALTER TABLE public.api_teacherprofile OWNER TO postgres;

--
-- Name: api_teachersubject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_teachersubject (
    id bigint NOT NULL,
    subject_id bigint NOT NULL,
    teacher_id integer NOT NULL
);


ALTER TABLE public.api_teachersubject OWNER TO postgres;

--
-- Name: api_teachersubject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.api_teachersubject ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_teachersubject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO postgres;

--
-- Name: backup_service_backuplog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backup_service_backuplog (
    id bigint NOT NULL,
    action character varying(20) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    details text NOT NULL,
    ip_address inet,
    user_id integer,
    backup_id bigint NOT NULL
);


ALTER TABLE public.backup_service_backuplog OWNER TO postgres;

--
-- Name: backup_service_backuplog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.backup_service_backuplog ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.backup_service_backuplog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: backup_service_backupschedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backup_service_backupschedule (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    is_active boolean NOT NULL,
    frequency character varying(20) NOT NULL,
    "time" time without time zone NOT NULL,
    day_of_week integer,
    day_of_month integer,
    interval_hours integer NOT NULL,
    keep_last integer NOT NULL,
    compression boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    last_run timestamp with time zone,
    next_run timestamp with time zone
);


ALTER TABLE public.backup_service_backupschedule OWNER TO postgres;

--
-- Name: backup_service_backupschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.backup_service_backupschedule ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.backup_service_backupschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: backup_service_databasebackup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backup_service_databasebackup (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    file_path character varying(500) NOT NULL,
    file_size bigint NOT NULL,
    backup_type character varying(20) NOT NULL,
    status character varying(20) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    completed_at timestamp with time zone,
    description text NOT NULL,
    error_message text NOT NULL,
    database_name character varying(255) NOT NULL,
    tables_count integer NOT NULL,
    row_count bigint NOT NULL,
    compression_ratio double precision,
    md5_hash character varying(32) NOT NULL,
    created_by_id integer
);


ALTER TABLE public.backup_service_databasebackup OWNER TO postgres;

--
-- Name: backup_service_databasebackup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.backup_service_databasebackup ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.backup_service_databasebackup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: education_department_lessonreplacement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.education_department_lessonreplacement (
    id bigint NOT NULL,
    replacement_date date NOT NULL,
    reason character varying(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    created_by_id integer,
    original_lesson_id bigint NOT NULL,
    replacement_subject_id bigint NOT NULL,
    replacement_teacher_id integer NOT NULL
);


ALTER TABLE public.education_department_lessonreplacement OWNER TO postgres;

--
-- Name: education_department_lessonreplacement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.education_department_lessonreplacement ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.education_department_lessonreplacement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: api_announcement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_announcement (id, title, content, created_at, is_for_all, author_id, student_group_id) FROM stdin;
1	Привет	эьо мое первое обьявления	2026-01-31 14:21:14.573159+03	t	6	\N
3	мапритвв	сампир	2026-01-31 14:23:51.1669+03	f	6	4
4	акувцы	ав	2026-01-31 15:34:20.438773+03	t	6	\N
5	Важное объявление	привет	2026-02-17 12:35:59.847608+03	f	22	4
\.


--
-- Data for Name: api_attendance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_attendance (id, date, status, student_id, schedule_lesson_id) FROM stdin;
1	2026-01-27	P	5	4
2	2026-01-29	P	5	9
5	2026-01-31	P	5	12
7	2026-01-31	L	5	11
10	2026-02-03	L	5	5
11	2026-02-03	A	5	7
16	2026-02-03	A	5	6
17	2026-02-07	L	5	21
18	2026-02-07	P	10	21
19	2026-02-12	P	5	20
21	2026-02-14	P	5	21
23	2026-02-17	P	5	23
24	2026-02-17	P	10	23
25	2026-02-18	P	10	19
26	2026-02-18	P	5	19
27	2026-02-19	P	10	20
28	2026-02-19	P	5	20
22	2026-02-14	P	10	21
20	2026-02-12	P	10	20
29	2026-02-21	P	5	21
30	2026-02-21	L	10	21
31	2026-03-11	P	5	19
32	2026-03-11	L	9	19
34	2026-03-26	P	9	20
36	2026-03-26	P	10	20
33	2026-03-26	L	5	20
35	2026-03-26	A	23	20
\.


--
-- Data for Name: api_auditlog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_auditlog (id, action, model_name, object_id, old_values, new_values, ip_address, user_agent, request_path, request_method, "timestamp", is_system_action, user_id) FROM stdin;
378	UPDATE	User	19	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$hCubDibc5vEG3GxPHm9zU3$qtObWnScdZ4fNZouMZ5AVHaW200oN0v4LImhrhq94dw=", "username": "ddd", "is_active": true, "last_name": "Васильев", "first_name": "Кирилл", "last_login": "2026-03-18T14:56:47.500476+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$hCubDibc5vEG3GxPHm9zU3$qtObWnScdZ4fNZouMZ5AVHaW200oN0v4LImhrhq94dw=", "username": "ddd", "is_active": true, "last_name": "Васильев", "first_name": "Кирилл", "last_login": "2026-03-18T14:56:47.500476+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-18 18:27:50.009312+03	t	\N
379	DELETE	StudentProfile	8	{"phone": "", "course": 1, "address": "", "user_id": 8, "birth_date": null, "patronymic": "", "profile_image": "", "student_group_id": 6}	\N	\N	\N	\N	\N	2026-03-18 18:28:10.410277+03	t	\N
380	DELETE	User	8	{"id": 8, "email": "sesha_sh2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$V3nRa1TXgsM7KurjV6J9SR$SQg2pvO5RR4UlsYVD1VWoYlYG0EsSNbSzYrCiKa9SiA=", "username": "trainer@mail.ru", "is_active": true, "last_name": "Пономарев", "first_name": "Петр", "last_login": null, "date_joined": "2026-01-31T15:32:17.25667+00:00", "is_superuser": false}	\N	\N	\N	\N	\N	2026-03-18 18:28:10.434279+03	t	\N
381	UPDATE	User	19	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$hCubDibc5vEG3GxPHm9zU3$qtObWnScdZ4fNZouMZ5AVHaW200oN0v4LImhrhq94dw=", "username": "ddd", "is_active": true, "last_name": "Васильев", "first_name": "Кирилл", "last_login": "2026-03-18T14:56:47.500476+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$hCubDibc5vEG3GxPHm9zU3$qtObWnScdZ4fNZouMZ5AVHaW200oN0v4LImhrhq94dw=", "username": "ddd", "is_active": false, "last_name": "Васильев", "first_name": "Кирилл", "last_login": "2026-03-18T14:56:47.500476+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-18 18:38:15.412441+03	t	\N
382	UPDATE	User	19	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$hCubDibc5vEG3GxPHm9zU3$qtObWnScdZ4fNZouMZ5AVHaW200oN0v4LImhrhq94dw=", "username": "ddd", "is_active": false, "last_name": "Васильев", "first_name": "Кирилл", "last_login": "2026-03-18T14:56:47.500476+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$hCubDibc5vEG3GxPHm9zU3$qtObWnScdZ4fNZouMZ5AVHaW200oN0v4LImhrhq94dw=", "username": "ddd", "is_active": true, "last_name": "Васильев", "first_name": "Кирилл", "last_login": "2026-03-18T14:56:47.500476+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-18 18:38:18.942259+03	t	\N
383	DELETE	StudentProfile	19	{"phone": "", "course": 3, "address": "", "user_id": 19, "birth_date": null, "patronymic": "Иванович", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	\N	2026-03-18 18:38:26.202824+03	t	\N
384	DELETE	User	19	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$hCubDibc5vEG3GxPHm9zU3$qtObWnScdZ4fNZouMZ5AVHaW200oN0v4LImhrhq94dw=", "username": "ddd", "is_active": true, "last_name": "Васильев", "first_name": "Кирилл", "last_login": "2026-03-18T14:56:47.500476+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	\N	\N	\N	\N	\N	2026-03-18 18:38:26.218312+03	t	\N
385	UPDATE	StudentGroup	6	{"id": 6, "name": "П50-3-22", "year": 1, "curator_id": 6}	{"id": 6, "name": "П50-3-22", "year": 2, "curator_id": 6}	\N	\N	\N	\N	2026-03-18 18:43:47.897421+03	t	\N
386	CREATE	Subject	7	\N	{"id": 7, "name": "user", "description": ""}	\N	\N	\N	\N	2026-03-18 18:44:08.82933+03	t	\N
387	DELETE	Subject	7	{"id": 7, "name": "user", "description": ""}	\N	\N	\N	\N	\N	2026-03-18 18:44:11.332222+03	t	\N
388	CREATE	TeacherSubject	6	\N	{"id": 6, "subject_id": 5, "teacher_id": 4}	\N	\N	\N	\N	2026-03-18 18:49:37.025765+03	t	\N
389	DELETE	TeacherSubject	6	{"id": 6, "subject_id": 5, "teacher_id": 4}	\N	\N	\N	\N	\N	2026-03-18 18:49:40.315426+03	t	\N
390	CREATE	TeacherSubject	7	\N	{"id": 7, "subject_id": 6, "teacher_id": 4}	\N	\N	\N	\N	2026-03-18 19:06:35.378097+03	t	\N
391	DELETE	TeacherSubject	7	{"id": 7, "subject_id": 6, "teacher_id": 4}	\N	\N	\N	\N	\N	2026-03-18 19:06:38.719175+03	t	\N
392	UPDATE	User	4	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": true, "last_name": "Калашенко", "first_name": "Матвей", "last_login": "2026-02-03T13:18:04.191742+00:00", "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": false, "last_name": "Калашенко", "first_name": "Матвей", "last_login": "2026-02-03T13:18:04.191742+00:00", "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-18 19:06:44.594179+03	t	\N
393	UPDATE	User	4	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": false, "last_name": "Калашенко", "first_name": "Матвей", "last_login": "2026-02-03T13:18:04.191742+00:00", "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": true, "last_name": "Калашенко", "first_name": "Матвей", "last_login": "2026-02-03T13:18:04.191742+00:00", "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-18 19:06:47.047336+03	t	\N
394	UPDATE	User	4	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": true, "last_name": "Калашенко", "first_name": "Матвей", "last_login": "2026-02-03T13:18:04.191742+00:00", "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": false, "last_name": "Калашенко", "first_name": "Матвей", "last_login": "2026-02-03T13:18:04.191742+00:00", "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-18 19:06:54.050401+03	t	\N
407	CREATE	Attendance	36	\N	{"id": 36, "date": "2026-03-26", "status": "P", "student_id": 10, "schedule_lesson_id": 20}	\N	\N	\N	\N	2026-03-28 17:14:17.081363+03	t	\N
395	UPDATE	User	4	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": false, "last_name": "Калашенко", "first_name": "Матвей", "last_login": "2026-02-03T13:18:04.191742+00:00", "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": true, "last_name": "Калашенко", "first_name": "Матвей", "last_login": "2026-02-03T13:18:04.191742+00:00", "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-18 19:06:57.517493+03	t	\N
396	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-03-13T08:46:54.027795+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-03-18T16:34:41.212038+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-18 19:34:41.212557+03	t	\N
397	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-03-13T08:48:08.819596+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-03-18T17:43:11.338689+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-18 20:43:11.339272+03	t	\N
398	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-03-18T16:34:41.212038+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-03-18T17:43:16.767409+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-18 20:43:16.767993+03	t	\N
399	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-03-18T17:43:11.338689+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-03-18T17:43:38.960088+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-18 20:43:38.960409+03	t	\N
400	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-03-18T17:43:16.767409+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-03-28T12:57:44.790215+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-28 15:57:44.791246+03	t	\N
401	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-03-18T17:43:38.960088+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-03-28T12:58:47.211386+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-28 15:58:47.211874+03	t	\N
402	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-03-28T12:57:44.790215+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-03-28T14:13:36.678145+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-28 17:13:36.679976+03	t	\N
403	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Шеметов", "first_name": "Василий", "last_login": "2026-03-13T08:44:25.959475+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Шеметов", "first_name": "Василий", "last_login": "2026-03-28T14:14:04.845966+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-28 17:14:04.847427+03	t	\N
404	CREATE	Attendance	33	\N	{"id": 33, "date": "2026-03-26", "status": "P", "student_id": 5, "schedule_lesson_id": 20}	\N	\N	\N	\N	2026-03-28 17:14:17.081363+03	t	\N
405	CREATE	Attendance	34	\N	{"id": 34, "date": "2026-03-26", "status": "P", "student_id": 9, "schedule_lesson_id": 20}	\N	\N	\N	\N	2026-03-28 17:14:17.081363+03	t	\N
406	CREATE	Attendance	35	\N	{"id": 35, "date": "2026-03-26", "status": "P", "student_id": 23, "schedule_lesson_id": 20}	\N	\N	\N	\N	2026-03-28 17:14:17.081363+03	t	\N
408	UPDATE	Attendance	33	{"id": 33, "date": "2026-03-26", "status": "P", "student_id": 5, "schedule_lesson_id": 20}	{"id": 33, "date": "2026-03-26", "status": "L", "student_id": 5, "schedule_lesson_id": 20}	\N	\N	\N	\N	2026-03-28 17:14:19.935058+03	t	\N
409	UPDATE	Attendance	35	{"id": 35, "date": "2026-03-26", "status": "P", "student_id": 23, "schedule_lesson_id": 20}	{"id": 35, "date": "2026-03-26", "status": "A", "student_id": 23, "schedule_lesson_id": 20}	\N	\N	\N	\N	2026-03-28 17:14:21.261538+03	t	\N
410	CREATE	Homework	8	\N	{"id": 8, "title": "апрто", "due_date": "2026-04-04T20:59:00+00:00", "attachment": "", "created_at": "2026-03-28T14:15:01.219224+00:00", "description": "всапиртоьблю", "student_group_id": 4, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-03-28 17:15:01.221582+03	t	\N
411	UPDATE	Homework	8	{"id": 8, "title": "апрто", "due_date": "2026-04-04T20:59:00+00:00", "attachment": "", "created_at": "2026-03-28T14:15:01.219224+00:00", "description": "всапиртоьблю", "student_group_id": 4, "schedule_lesson_id": 21}	{"id": 8, "title": "апрто", "due_date": "2026-04-04T20:59:00+00:00", "attachment": "homework_attachments/school_grades_report_20260222_1507_2.pdf", "created_at": "2026-03-28T14:15:01.219224+00:00", "description": "всапиртоьблю", "student_group_id": 4, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-03-28 17:15:01.263788+03	t	\N
412	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-03-28T12:58:47.211386+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-03-28T14:15:55.614888+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-28 17:15:55.615468+03	t	\N
413	CREATE	HomeworkSubmission	6	\N	{"id": 6, "student_id": 5, "homework_id": 8, "submitted_at": "2026-03-28T14:16:27.390977+00:00", "submission_file": "", "submission_text": ""}	\N	\N	\N	\N	2026-03-28 17:16:27.391176+03	t	\N
414	UPDATE	HomeworkSubmission	6	{"id": 6, "student_id": 5, "homework_id": 8, "submitted_at": "2026-03-28T14:16:27.390977+00:00", "submission_file": "", "submission_text": ""}	{"id": 6, "student_id": 5, "homework_id": 8, "submitted_at": "2026-03-28T14:16:27.390977+00:00", "submission_file": "homework_submissions/school_grades_report_20260222_1507_2.pdf", "submission_text": ""}	\N	\N	\N	\N	2026-03-28 17:16:27.409882+03	t	\N
415	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Шеметов", "first_name": "Василий", "last_login": "2026-03-28T14:14:04.845966+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Шеметов", "first_name": "Василий", "last_login": "2026-03-28T14:16:37.575783+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-28 17:16:37.576632+03	t	\N
416	CREATE	Grade	16	\N	{"id": 16, "date": "2026-03-28", "value": 3.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-03-28 18:43:47.126711+03	t	\N
417	UPDATE	Grade	16	{"id": 16, "date": "2026-03-28", "value": 3.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 21}	{"id": 16, "date": "2026-03-28", "value": 5.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-03-28 19:14:18.730173+03	t	\N
418	UPDATE	Grade	16	{"id": 16, "date": "2026-03-28", "value": 5.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 21}	{"id": 16, "date": "2026-03-28", "value": 3.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-03-28 19:14:22.016515+03	t	\N
419	UPDATE	Grade	16	{"id": 16, "date": "2026-03-28", "value": 3.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 21}	{"id": 16, "date": "2026-03-28", "value": 4.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-03-28 19:14:25.043215+03	t	\N
420	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-03-28T14:13:36.678145+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-03-28T16:14:40.933289+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-28 19:14:40.934116+03	t	\N
421	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-03-28T14:15:55.614888+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-03-28T16:14:46.830767+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-28 19:14:46.831136+03	t	\N
422	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-03-28T16:14:46.830767+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-03-28T22:26:09.883829+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-29 01:26:09.885438+03	t	\N
423	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-03-13T08:50:18.67368+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-03-28T22:26:43.4112+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-03-29 01:26:43.411673+03	t	\N
424	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-03-28T16:14:40.933289+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-03-28T22:27:14.304572+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-29 01:27:14.305065+03	t	\N
425	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-03-28T22:26:43.4112+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-03-30T09:50:36.264752+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-03-30 12:50:36.266751+03	t	\N
426	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-03-28T22:26:09.883829+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-03-30T09:51:05.064717+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-03-30 12:51:05.065494+03	t	\N
427	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-03-30T09:51:05.064717+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-04-02T10:41:00.505315+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-04-02 13:41:00.505711+03	t	\N
428	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-03-30T09:50:36.264752+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-04-02T10:41:32.607252+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-04-02 13:41:32.60831+03	t	\N
429	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-04-02T10:41:00.505315+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-04-02T10:42:08.718244+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-04-02 13:42:08.718666+03	t	\N
430	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-04-02T10:42:08.718244+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-04-02T10:42:47.111698+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-04-02 13:42:47.112565+03	t	\N
431	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-04-02T10:41:32.607252+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-04-02T10:43:40.066429+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-04-02 13:43:40.067453+03	t	\N
432	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Шеметов", "first_name": "Василий", "last_login": "2026-03-28T14:16:37.575783+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Шеметов", "first_name": "Василий", "last_login": "2026-04-02T10:46:21.995887+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-04-02 13:46:21.996775+03	t	\N
433	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-04-02T10:43:40.066429+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-04-02T10:48:40.935869+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-04-02 13:48:40.936407+03	t	\N
434	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-04-02T10:42:47.111698+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-04-02T10:57:23.829815+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-04-02 13:57:23.830688+03	t	\N
435	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-04-02T10:48:40.935869+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-04-02T10:57:34.142551+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-04-02 13:57:34.143088+03	t	\N
436	CREATE	User	24	\N	{"id": 24, "email": "gbfredws@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$ItU8hWuKFOmDJNxdbOlWff$4d0BI0TM7vhdiK7HCRCRJTlGaEazaKQf88Ko85RJVkU=", "username": "as", "is_active": true, "last_name": "fr", "first_name": "de", "last_login": null, "date_joined": "2026-04-02T10:58:06.051192+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-04-02 13:58:06.698268+03	t	\N
437	CREATE	TeacherProfile	24	\N	{"phone": "", "user_id": 24, "birth_date": null, "patronymic": "fr", "profile_image": "", "qualification": ""}	\N	\N	\N	\N	2026-04-02 13:58:06.698268+03	t	\N
438	DELETE	TeacherProfile	24	{"phone": "", "user_id": 24, "birth_date": null, "patronymic": "fr", "profile_image": "", "qualification": ""}	\N	\N	\N	\N	\N	2026-04-02 13:58:15.867521+03	t	\N
439	DELETE	User	24	{"id": 24, "email": "gbfredws@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$ItU8hWuKFOmDJNxdbOlWff$4d0BI0TM7vhdiK7HCRCRJTlGaEazaKQf88Ko85RJVkU=", "username": "as", "is_active": true, "last_name": "fr", "first_name": "de", "last_login": null, "date_joined": "2026-04-02T10:58:06.051192+00:00", "is_superuser": false}	\N	\N	\N	\N	\N	2026-04-02 13:58:15.867521+03	t	\N
\.


--
-- Data for Name: api_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_comment (id, text, created_at, updated_at, author_id, homework_id) FROM stdin;
\.


--
-- Data for Name: api_dailyschedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_dailyschedule (id, week_day, is_active, student_group_id, is_weekend) FROM stdin;
1	MON	t	4	f
2	TUE	t	4	f
6	THU	t	4	f
7	SAT	t	4	f
3	WED	t	4	f
4	FRI	t	4	t
8	MON	t	6	f
9	TUE	t	6	f
10	WED	t	6	f
11	THU	t	6	t
\.


--
-- Data for Name: api_grade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_grade (id, value, grade_type, date, comment, student_id, teacher_id, schedule_lesson_id, subject_id) FROM stdin;
1	5.0	HW	2026-01-27		5	2	3	1
3	5.0	TEST	2026-01-31	fd	5	6	12	4
4	2.0	ORAL	2026-02-03		7	4	4	3
5	5.0	CW	2026-02-03		7	4	10	1
6	5.0	HW	2026-02-08		5	22	19	6
7	4.0	HW	2026-02-13	ыф	5	22	19	6
8	2.0	HW	2026-02-17		5	22	21	6
9	4.0	HW	2026-02-17	акувц	5	22	21	6
10	5.0	HW	2026-02-17		5	22	21	6
14	5.0	TEST	2026-03-16		5	22	19	6
15	3.0	PROJ	2026-02-22		5	22	21	6
16	4.0	HW	2026-03-28		5	22	21	6
\.


--
-- Data for Name: api_homework; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_homework (id, title, description, created_at, due_date, attachment, schedule_lesson_id, student_group_id) FROM stdin;
7	Практ номер 3	Подготовка к контрольной работе	2026-02-22 16:06:18.317834+03	2026-03-01 23:59:00+03	homework_attachments/school_grades_report_20260222_1507.pdf	19	4
8	апрто	всапиртоьблю	2026-03-28 17:15:01.219224+03	2026-04-04 23:59:00+03	homework_attachments/school_grades_report_20260222_1507_2.pdf	21	4
\.


--
-- Data for Name: api_homeworksubmission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_homeworksubmission (id, submission_file, submission_text, submitted_at, homework_id, student_id) FROM stdin;
6	homework_submissions/school_grades_report_20260222_1507_2.pdf		2026-03-28 17:16:27.390977+03	8	5
\.


--
-- Data for Name: api_schedulelesson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_schedulelesson (id, lesson_number, daily_schedule_id, teacher_id, subject_id) FROM stdin;
3	2	1	4	1
4	2	4	4	1
5	1	2	4	1
6	5	2	4	1
7	2	2	4	1
9	1	6	4	3
10	2	7	4	3
11	1	7	4	1
12	4	7	6	4
14	5	1	6	4
15	3	3	4	1
16	4	2	6	5
17	1	8	6	5
18	3	9	4	1
19	1	3	22	6
20	3	6	22	6
21	5	7	22	6
22	2	6	4	1
23	3	2	22	6
24	2	9	22	6
25	2	8	4	1
26	1	10	22	6
\.


--
-- Data for Name: api_studentgroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_studentgroup (id, name, year, curator_id) FROM stdin;
4	п50-4-22	2	22
6	П50-3-22	2	6
\.


--
-- Data for Name: api_studentprofile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_studentprofile (user_id, patronymic, phone, birth_date, profile_image, address, course, student_group_id) FROM stdin;
7			\N			1	6
10	Васильевна		2006-01-03			2	4
5	Иванович		2026-01-29			3	4
9	cc		\N			2	4
23	рнпекау		\N			2	4
\.


--
-- Data for Name: api_subject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_subject (id, name, description) FROM stdin;
6	Литература	люблю
3	Мат моделирвоание	высшая математика
1	Русский язык	уав
5	Геометрия в программировании	
4	Физика	
\.


--
-- Data for Name: api_teacherprofile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_teacherprofile (user_id, patronymic, phone, birth_date, profile_image, qualification) FROM stdin;
4	Сергеевич		\N		Математика
6	Павлович		\N		
22	Патапович		\N		
\.


--
-- Data for Name: api_teachersubject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_teachersubject (id, subject_id, teacher_id) FROM stdin;
1	1	4
2	3	4
3	4	6
4	5	6
5	6	22
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
1	admin
3	teacher
2	student
4	education_department
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	3	add_permission
6	Can change permission	3	change_permission
7	Can delete permission	3	delete_permission
8	Can view permission	3	view_permission
9	Can add group	2	add_group
10	Can change group	2	change_group
11	Can delete group	2	delete_group
12	Can view group	2	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add Расписание на день	10	add_dailyschedule
26	Can change Расписание на день	10	change_dailyschedule
27	Can delete Расписание на день	10	delete_dailyschedule
28	Can view Расписание на день	10	view_dailyschedule
29	Can add Домашнее задание	12	add_homework
30	Can change Домашнее задание	12	change_homework
31	Can delete Домашнее задание	12	delete_homework
32	Can view Домашнее задание	12	view_homework
33	Can add Предмет	17	add_subject
34	Can change Предмет	17	change_subject
35	Can delete Предмет	17	delete_subject
36	Can view Предмет	17	view_subject
37	Can add Профиль учителя	18	add_teacherprofile
38	Can change Профиль учителя	18	change_teacherprofile
39	Can delete Профиль учителя	18	delete_teacherprofile
40	Can view Профиль учителя	18	view_teacherprofile
41	Can add Комментарий	9	add_comment
42	Can change Комментарий	9	change_comment
43	Can delete Комментарий	9	delete_comment
44	Can view Комментарий	9	view_comment
45	Can add Урок в расписании	14	add_schedulelesson
46	Can change Урок в расписании	14	change_schedulelesson
47	Can delete Урок в расписании	14	delete_schedulelesson
48	Can view Урок в расписании	14	view_schedulelesson
49	Can add Учебный класс	15	add_studentgroup
50	Can change Учебный класс	15	change_studentgroup
51	Can delete Учебный класс	15	delete_studentgroup
52	Can view Учебный класс	15	view_studentgroup
53	Can add Объявление	7	add_announcement
54	Can change Объявление	7	change_announcement
55	Can delete Объявление	7	delete_announcement
56	Can view Объявление	7	view_announcement
57	Can add Профиль ученика	16	add_studentprofile
58	Can change Профиль ученика	16	change_studentprofile
59	Can delete Профиль ученика	16	delete_studentprofile
60	Can view Профиль ученика	16	view_studentprofile
61	Can add Оценка	11	add_grade
62	Can change Оценка	11	change_grade
63	Can delete Оценка	11	delete_grade
64	Can view Оценка	11	view_grade
65	Can add Сданная работа	13	add_homeworksubmission
66	Can change Сданная работа	13	change_homeworksubmission
67	Can delete Сданная работа	13	delete_homeworksubmission
68	Can view Сданная работа	13	view_homeworksubmission
69	Can add Посещаемость	8	add_attendance
70	Can change Посещаемость	8	change_attendance
71	Can delete Посещаемость	8	delete_attendance
72	Can view Посещаемость	8	view_attendance
73	Can add Предмет учителя	19	add_teachersubject
74	Can change Предмет учителя	19	change_teachersubject
75	Can delete Предмет учителя	19	delete_teachersubject
76	Can view Предмет учителя	19	view_teachersubject
77	Can add Token	20	add_token
78	Can change Token	20	change_token
79	Can delete Token	20	delete_token
80	Can view Token	20	view_token
81	Can add Token	21	add_tokenproxy
82	Can change Token	21	change_tokenproxy
83	Can delete Token	21	delete_tokenproxy
84	Can view Token	21	view_tokenproxy
85	Can add Запись аудита	22	add_auditlog
86	Can change Запись аудита	22	change_auditlog
87	Can delete Запись аудита	22	delete_auditlog
88	Can view Запись аудита	22	view_auditlog
89	Can add Расписание бэкапов	24	add_backupschedule
90	Can change Расписание бэкапов	24	change_backupschedule
91	Can delete Расписание бэкапов	24	delete_backupschedule
92	Can view Расписание бэкапов	24	view_backupschedule
93	Can add Резервная копия	25	add_databasebackup
94	Can change Резервная копия	25	change_databasebackup
95	Can delete Резервная копия	25	delete_databasebackup
96	Can view Резервная копия	25	view_databasebackup
97	Can add Лог бэкапа	23	add_backuplog
98	Can change Лог бэкапа	23	change_backuplog
99	Can delete Лог бэкапа	23	delete_backuplog
100	Can view Лог бэкапа	23	view_backuplog
101	Can add Разовая замена урока	26	add_lessonreplacement
102	Can change Разовая замена урока	26	change_lessonreplacement
103	Can delete Разовая замена урока	26	delete_lessonreplacement
104	Can view Разовая замена урока	26	view_lessonreplacement
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
10	pbkdf2_sha256$1200000$YpMK98z2yR58FJMNuSCHs9$LMD0Ip6yLj3QaTmtb8SEDRex5AsO+C9msG8yrFCs/30=	\N	f	2006@mail.ru	Иван	школьниковро	2006@mail.ru	f	t	2026-02-03 14:25:22.936796+03
9	pbkdf2_sha256$1200000$yj9WZmt5URkWZKR1UA7SK4$o42RubUl6rqHGfZYlV161fctzlBt7p6hpuKXhAVM1r8=	\N	f	ad@mail.ru	Павел	Иванов	mail@mail.ru	f	t	2026-01-31 18:36:23.199562+03
7	pbkdf2_sha256$1200000$GtMU2umd2XWT03AKGgl2cQ$3U5sPQQc5tvNg8WL+fOkPyFU5LbnO3012UQ6MEi93ac=	2026-02-03 14:03:26.579499+03	f	admin@mail.ru	Михаил	Курпатов	sesha_shk3@mail.ru	f	t	2026-01-31 18:29:26.77964+03
23	pbkdf2_sha256$1200000$T70WNNdUwFb1TrTQZqwhx3$gFNYbqRTQ5LDkJB3pY4rwNXMARbzHyyKhkSO405nFFU=	\N	f	rfheb_enjj	Игнат	Кузнецов	www@mail.ru	f	t	2026-02-13 16:51:39.294237+03
6	pbkdf2_sha256$1200000$RlOXenbRLvap9crdB3EgrR$cb4PkmR5fd7A9+pQCNytKn3dhCoyNZoBpIW5OwYEhUE=	2026-01-31 15:19:02.136158+03	f	teacher@mail.tu	Ярослав	Филипов		f	t	2026-01-31 14:01:18+03
4	pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=	2026-02-03 16:18:04.191742+03	f	teacher@mail.ru	Матвей	Калашенко		f	t	2026-01-22 17:31:50+03
2	pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=	2026-03-29 01:27:14.304572+03	f	men@mail.ru				f	t	2026-01-19 14:27:45+03
22	pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=	2026-04-02 13:46:21.995887+03	f	teacher	Василий	Шеметов	trainer@fitzone.ru	f	t	2026-02-08 16:23:35.223821+03
5	pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=	2026-04-02 13:57:23.829815+03	f	sesha_shk2@mail.ru	Иван	Иван	sesha_shk2@mail.ru	f	t	2026-01-26 20:40:47.700627+03
1	pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=	2026-04-02 13:57:34.142551+03	t	sesha			sesha@mail.ru	t	t	2026-01-14 15:35:19.661306+03
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
3	4	3
4	5	2
5	6	3
6	7	2
8	9	2
9	10	2
21	2	4
22	22	3
23	23	2
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authtoken_token (key, created, user_id) FROM stdin;
f355c3dd35efd47158408007728bcb109251b06e	2026-01-19 15:48:04.041767+03	2
\.


--
-- Data for Name: backup_service_backuplog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backup_service_backuplog (id, action, "timestamp", details, ip_address, user_id, backup_id) FROM stdin;
1	create	2026-02-13 17:25:48.783229+03	Создана резервная копия backup_6_20260213_172548.sql	127.0.0.1	1	6
2	download	2026-02-13 17:25:59.81802+03		127.0.0.1	1	6
3	create	2026-02-17 15:57:51.448343+03	Создана резервная копия backup_7_20260217_155750.sql	127.0.0.1	1	7
4	create	2026-02-22 15:03:00.244315+03	Создана резервная копия backup_8_20260222_150259.sql	127.0.0.1	1	8
5	create	2026-02-23 19:23:32.550525+03	Создана резервная копия backup_9_20260223_192331.sql	127.0.0.1	1	9
6	download	2026-02-23 19:23:34.905124+03		127.0.0.1	1	9
7	create	2026-02-24 16:29:44.700303+03	Создана резервная копия backup_10_20260224_162943.sql	127.0.0.1	1	10
8	download	2026-02-24 16:35:10.6613+03		127.0.0.1	1	10
9	download	2026-03-18 19:07:28.946936+03		127.0.0.1	1	10
10	restore	2026-03-18 19:30:10.840556+03	Restored from backup file backup_11_20260318_190736.sql	127.0.0.1	1	11
12	create	2026-03-18 19:34:28.540805+03	Создана резервная копия backup_12_20260318_193427.sql	127.0.0.1	1	12
\.


--
-- Data for Name: backup_service_backupschedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backup_service_backupschedule (id, name, is_active, frequency, "time", day_of_week, day_of_month, interval_hours, keep_last, compression, created_at, updated_at, last_run, next_run) FROM stdin;
\.


--
-- Data for Name: backup_service_databasebackup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backup_service_databasebackup (id, name, filename, file_path, file_size, backup_type, status, created_at, completed_at, description, error_message, database_name, tables_count, row_count, compression_ratio, md5_hash, created_by_id) FROM stdin;
1	ыч			0	manual	failed	2026-02-13 17:19:51.802735+03	\N	амсв	[WinError 2] Не удается найти указанный файл		0	0	\N		1
2	fghj			0	manual	failed	2026-02-13 17:19:58.253581+03	\N	амсв	[WinError 2] Не удается найти указанный файл		0	0	\N		1
3	fghj			0	manual	failed	2026-02-13 17:21:00.422963+03	\N	амсв	[WinError 2] Не удается найти указанный файл		0	0	\N		1
5	user			0	manual	failed	2026-02-13 17:25:03.009223+03	\N	h	[WinError 2] Не удается найти указанный файл		0	0	\N		1
6	1	backup_6_20260213_172548.sql	C:\\Users\\sesha\\OneDrive\\Desktop\\MPTed\\project\\backups\\backup_6_20260213_172548.sql	192182	manual	completed	2026-02-13 17:25:48.093241+03	2026-02-13 17:25:48.780628+03	n		mpted	28	190	\N		1
7	dws	backup_7_20260217_155750.sql	C:\\Users\\sesha\\OneDrive\\Desktop\\MPTed\\project\\backups\\backup_7_20260217_155750.sql	217798	manual	completed	2026-02-17 15:57:50.845874+03	2026-02-17 15:57:51.445842+03			mpted	28	190	\N		1
8	вы	backup_8_20260222_150259.sql	C:\\Users\\sesha\\OneDrive\\Desktop\\MPTed\\project\\backups\\backup_8_20260222_150259.sql	238033	manual	completed	2026-02-22 15:02:59.473091+03	2026-02-22 15:03:00.241069+03			mpted	28	309	\N		1
9	ds	backup_9_20260223_192331.sql	C:\\Users\\sesha\\OneDrive\\Desktop\\MPTed\\project\\backups\\backup_9_20260223_192331.sql	269477	manual	completed	2026-02-23 19:23:31.406062+03	2026-02-23 19:23:32.546658+03			mpted	28	386	\N		1
10	ап	backup_10_20260224_162943.sql	C:\\Users\\sesha\\OneDrive\\Desktop\\MPTed\\project\\backups\\backup_10_20260224_162943.sql	290399	manual	completed	2026-02-24 16:29:43.591865+03	2026-02-24 16:29:44.697655+03			mpted	28	386	\N		1
11	Базовый			0	manual	completed	2026-03-18 19:07:36.57763+03	\N				0	0	\N		1
12	Базовый	backup_12_20260318_193427.sql	C:\\Users\\sesha\\OneDrive\\Desktop\\MPTed\\project\\backups\\backup_12_20260318_193427.sql	115705	manual	completed	2026-03-18 19:34:27.978975+03	2026-03-18 19:34:28.536119+03			mpted	28	340	\N		1
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2026-01-19 14:27:45.550318+03	2	men@mail.ru	1	[{"added": {}}]	4	1
2	2026-01-19 15:40:11.165377+03	1	admin	1	[{"added": {}}]	2	1
3	2026-01-19 15:45:17.560311+03	2	men@mail.ru	2	[{"changed": {"fields": ["Groups"]}}]	4	1
4	2026-01-20 13:56:32.557285+03	1	Математика	1	[{"added": {}}]	17	1
5	2026-01-21 14:35:16.762658+03	2	student	1	[{"added": {}}]	2	1
6	2026-01-21 14:35:54.376536+03	3	sesha_shk@mail.ru	1	[{"added": {}}]	4	1
7	2026-01-21 14:36:04.35459+03	3	sesha_shk@mail.ru	2	[{"changed": {"fields": ["Groups"]}}]	4	1
8	2026-01-22 17:31:29.548033+03	3	teacher	1	[{"added": {}}]	2	1
9	2026-01-22 17:31:50.901634+03	4	teacher@mail.ru	1	[{"added": {}}]	4	1
10	2026-01-22 17:31:56.930849+03	4	teacher@mail.ru	2	[{"changed": {"fields": ["Groups"]}}]	4	1
11	2026-01-22 17:39:42.195571+03	4	  сампир	1	[{"added": {}}]	18	1
12	2026-01-22 17:40:05.420106+03	1	  сампир - Математика	1	[{"added": {}}]	19	1
13	2026-01-27 19:32:14.444703+03	2	student	2	[]	2	1
14	2026-01-27 19:38:30.666775+03	1	BHHH BHH: 5 по Математика	1	[{"added": {}}]	11	1
15	2026-01-27 19:38:46.377929+03	1	BHHH BHH - 2026-01-27 - Присутствовал	1	[{"added": {}}]	8	1
16	2026-01-27 19:39:29.561806+03	1	аппп	1	[{"added": {}}]	12	1
17	2026-01-27 20:16:52.900029+03	1	аппп	2	[{"changed": {"fields": ["\\u0423\\u0447\\u0435\\u0431\\u043d\\u044b\\u0439 \\u043a\\u043b\\u0430\\u0441\\u0441"]}}]	12	1
18	2026-01-29 09:48:43.998481+03	2	Иван Иванов - 2026-01-29 - Присутствовал	1	[{"added": {}}]	8	1
19	2026-01-31 14:01:19.028436+03	6	teacher@mail.tu	1	[{"added": {}}]	4	1
20	2026-01-31 14:01:24.989787+03	6	teacher@mail.tu	2	[{"changed": {"fields": ["Groups"]}}]	4	1
21	2026-02-07 17:32:28.473376+03	3	sesha_shk@mail.ru	3		4	1
22	2026-02-07 17:37:01.183608+03	11	ddd	3		4	1
23	2026-02-07 17:39:16.328415+03	12	ddd	3		4	1
24	2026-02-07 17:40:45.016057+03	13	ddd	3		4	1
25	2026-02-07 18:14:27.131049+03	14	ddd	3		4	1
26	2026-02-07 18:18:53.851094+03	15	ddd	3		4	1
27	2026-02-07 18:20:28.645214+03	16	ddd	3		4	1
28	2026-02-07 18:26:49.209966+03	18	ddd	3		4	1
29	2026-02-07 18:39:26.132357+03	17	skolnikovaksenia64@gmail.com	3		4	1
30	2026-02-07 18:43:25.888692+03	20	me	3		4	1
31	2026-02-07 20:14:25.385909+03	4	education_department	1	[{"added": {}}]	2	1
32	2026-02-07 20:42:20.148756+03	2	men@mail.ru	2	[{"changed": {"fields": ["Groups"]}}]	4	1
33	2026-02-07 20:42:51.99372+03	2	men@mail.ru	2	[{"changed": {"fields": ["Groups"]}}]	4	1
34	2026-02-22 19:50:22.327436+03	6	cds	3		12	1
35	2026-02-22 19:50:25.314461+03	5	лллл	3		12	1
36	2026-02-22 19:50:28.166784+03	4	sw	3		12	1
37	2026-02-22 19:50:31.002827+03	1	аппп	3		12	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	group
3	auth	permission
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	api	announcement
8	api	attendance
9	api	comment
10	api	dailyschedule
11	api	grade
12	api	homework
13	api	homeworksubmission
14	api	schedulelesson
15	api	studentgroup
16	api	studentprofile
17	api	subject
18	api	teacherprofile
19	api	teachersubject
20	authtoken	token
21	authtoken	tokenproxy
22	api	auditlog
23	backup_service	backuplog
24	backup_service	backupschedule
25	backup_service	databasebackup
26	education_department	lessonreplacement
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2026-01-14 15:34:21.692513+03
2	auth	0001_initial	2026-01-14 15:34:22.228633+03
3	admin	0001_initial	2026-01-14 15:34:22.315433+03
4	admin	0002_logentry_remove_auto_add	2026-01-14 15:34:22.321773+03
5	admin	0003_logentry_add_action_flag_choices	2026-01-14 15:34:22.327041+03
6	contenttypes	0002_remove_content_type_name	2026-01-14 15:34:22.337377+03
7	auth	0002_alter_permission_name_max_length	2026-01-14 15:34:22.342618+03
8	auth	0003_alter_user_email_max_length	2026-01-14 15:34:22.347472+03
9	auth	0004_alter_user_username_opts	2026-01-14 15:34:22.352199+03
10	auth	0005_alter_user_last_login_null	2026-01-14 15:34:22.357536+03
11	auth	0006_require_contenttypes_0002	2026-01-14 15:34:22.358491+03
12	auth	0007_alter_validators_add_error_messages	2026-01-14 15:34:22.3629+03
13	auth	0008_alter_user_username_max_length	2026-01-14 15:34:22.401947+03
14	auth	0009_alter_user_last_name_max_length	2026-01-14 15:34:22.407233+03
15	auth	0010_alter_group_name_max_length	2026-01-14 15:34:22.414311+03
16	auth	0011_update_proxy_permissions	2026-01-14 15:34:22.418896+03
17	auth	0012_alter_user_first_name_max_length	2026-01-14 15:34:22.426595+03
18	sessions	0001_initial	2026-01-14 15:34:22.502786+03
19	api	0001_initial	2026-01-14 19:06:05.475395+03
20	authtoken	0001_initial	2026-01-19 15:47:54.62237+03
21	authtoken	0002_auto_20160226_1747	2026-01-19 15:47:54.655221+03
22	authtoken	0003_tokenproxy	2026-01-19 15:47:54.657945+03
23	authtoken	0004_alter_tokenproxy_options	2026-01-19 15:47:54.662163+03
24	api	0002_dailyschedule_is_weekend_and_more	2026-01-21 15:32:58.335626+03
25	api	0003_auditlog	2026-01-31 18:06:24.438471+03
26	backup_service	0001_initial	2026-02-13 17:13:43.027526+03
27	education_department	0001_initial	2026-03-18 20:07:19.945188+03
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
w1ulpmhoibxe1pe85c27dtevasbvfhy8	.eJxVjEsOwjAMBe-SNYri_kxYsu8ZIseOSQGlUtOuEHeHSl3A9s3Me5lA25rDVtMSJjEX05jT7xaJH6nsQO5UbrPluazLFO2u2INWO86SntfD_TvIVPO35jNjcoDQReeT8sAdKjpuQV0v4nuQxrWivUcFiQARHQ6eBk3aCbF5fwDpkzhi:1vmD0e:Std1KiDN2iW5DA_9dJlV0HiozO40IHYwHVkhxeRuiFc	2026-02-14 18:35:40.799446+03
3ugtduyr6wg2nm0o3omxyc7qp3ju11ho	.eJxVjEEOwiAURO_C2pBCC__j0n3PQIAPUjWQlHZlvLs06UJnOfPevJl1-5bt3uJqF2JXJtjlt_MuPGM5Bnq4cq881LKti-cHws-18blSfN1O9u8gu5a7nRANDNjjIIwewiSMV2MaMHqJFEAARnQyaQBFJJI0pFQ3ok46TIp9vtF-N3s:1vusT1:8I3C1uf52EM9rOnJMiS3_HWIJTx8BxmxR-aY4IPsZc0	2026-03-10 16:28:47.871832+03
2eutukcpvp0x8h379q44ovhcqyp93cxp	.eJxVjDsOwyAQBe9CHSHzW-yU6X0GtLAQnEQgGbuKcvdgyUXSzsx7b-Zw37LbW1zdQuzKDLv8Mo_hGcsh6IHlXnmoZVsXz4-En7bxuVJ83c727yBjy30NiBGNgEBWequ0TF5P4CWBsEmoDmAMo9R2GoxFmYakkBKYEHQvULDPF9yLN24:1w6WJC:Au7Z_lcsgHf_ghFOQOHJlVcDr7lUG7-oul9SFQksww8	2026-04-11 19:14:46.84558+03
3t7zh0v5rftap756t72rcd4l3tm1fy6s	.eJxVjEsOwjAMBe-SNYri_kxYsu8ZIseOSQGlUtOuEHeHSl3A9s3Me5lA25rDVtMSJjEX05jT7xaJH6nsQO5UbrPluazLFO2u2INWO86SntfD_TvIVPO35jNjcoDQReeT8sAdKjpuQV0v4nuQxrWivUcFiQARHQ6eBk3aCbF5fwDpkzhi:1w6c7e:Ca7IRB5ULUIC23RvTZTXnj9bKN7pFZKBzyrj3q7QbaM	2026-04-12 01:27:14.316462+03
xdal4rqwlf16wizqgt83nyt8rckyxnlx	.eJxVjEEOwiAURO_C2pBCC__j0n3PQIAPUjWQlHZlvLs06UJnOfPevJl1-5bt3uJqF2JXJtjlt_MuPGM5Bnq4cq881LKti-cHws-18blSfN1O9u8gu5a7nRANDNjjIIwewiSMV2MaMHqJFEAARnQyaQBFJJI0pFQ3ok46TIp9vtF-N3s:1w8FbM:X03Pm-hoFJuOu0FjIfP9mMBw2tGYf8d2SubxyJXKuQA	2026-04-16 13:48:40.942568+03
\.


--
-- Data for Name: education_department_lessonreplacement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.education_department_lessonreplacement (id, replacement_date, reason, created_at, updated_at, created_by_id, original_lesson_id, replacement_subject_id, replacement_teacher_id) FROM stdin;
1	2026-03-17		2026-03-18 20:42:51.613395+03	2026-03-18 20:42:51.613405+03	2	24	5	6
2	2026-03-19		2026-03-18 20:43:33.208905+03	2026-03-18 20:43:33.208921+03	2	9	5	6
3	2026-03-28		2026-03-28 15:58:22.005259+03	2026-03-28 15:58:22.005277+03	2	21	5	6
\.


--
-- Name: api_announcement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_announcement_id_seq', 5, true);


--
-- Name: api_attendance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_attendance_id_seq', 36, true);


--
-- Name: api_auditlog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_auditlog_id_seq', 439, true);


--
-- Name: api_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_comment_id_seq', 1, false);


--
-- Name: api_dailyschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_dailyschedule_id_seq', 11, true);


--
-- Name: api_grade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_grade_id_seq', 16, true);


--
-- Name: api_homework_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_homework_id_seq', 8, true);


--
-- Name: api_homeworksubmission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_homeworksubmission_id_seq', 6, true);


--
-- Name: api_schedulelesson_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_schedulelesson_id_seq', 26, true);


--
-- Name: api_studentgroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_studentgroup_id_seq', 6, true);


--
-- Name: api_subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_subject_id_seq', 7, true);


--
-- Name: api_teachersubject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_teachersubject_id_seq', 7, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 4, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 104, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 24, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 24, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: backup_service_backuplog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backup_service_backuplog_id_seq', 12, true);


--
-- Name: backup_service_backupschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backup_service_backupschedule_id_seq', 1, false);


--
-- Name: backup_service_databasebackup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backup_service_databasebackup_id_seq', 12, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 37, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 26, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 27, true);


--
-- Name: education_department_lessonreplacement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.education_department_lessonreplacement_id_seq', 3, true);


--
-- Name: api_announcement api_announcement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_announcement
    ADD CONSTRAINT api_announcement_pkey PRIMARY KEY (id);


--
-- Name: api_attendance api_attendance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_attendance
    ADD CONSTRAINT api_attendance_pkey PRIMARY KEY (id);


--
-- Name: api_attendance api_attendance_student_id_schedule_lesson_id_date_b5aa0c39_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_attendance
    ADD CONSTRAINT api_attendance_student_id_schedule_lesson_id_date_b5aa0c39_uniq UNIQUE (student_id, schedule_lesson_id, date);


--
-- Name: api_auditlog api_auditlog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_auditlog
    ADD CONSTRAINT api_auditlog_pkey PRIMARY KEY (id);


--
-- Name: api_comment api_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_comment
    ADD CONSTRAINT api_comment_pkey PRIMARY KEY (id);


--
-- Name: api_dailyschedule api_dailyschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_dailyschedule
    ADD CONSTRAINT api_dailyschedule_pkey PRIMARY KEY (id);


--
-- Name: api_dailyschedule api_dailyschedule_student_group_id_week_day_cdc4a0f4_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_dailyschedule
    ADD CONSTRAINT api_dailyschedule_student_group_id_week_day_cdc4a0f4_uniq UNIQUE (student_group_id, week_day);


--
-- Name: api_grade api_grade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_grade
    ADD CONSTRAINT api_grade_pkey PRIMARY KEY (id);


--
-- Name: api_homework api_homework_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_homework
    ADD CONSTRAINT api_homework_pkey PRIMARY KEY (id);


--
-- Name: api_homeworksubmission api_homeworksubmission_homework_id_student_id_0f973ce8_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_homeworksubmission
    ADD CONSTRAINT api_homeworksubmission_homework_id_student_id_0f973ce8_uniq UNIQUE (homework_id, student_id);


--
-- Name: api_homeworksubmission api_homeworksubmission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_homeworksubmission
    ADD CONSTRAINT api_homeworksubmission_pkey PRIMARY KEY (id);


--
-- Name: api_schedulelesson api_schedulelesson_daily_schedule_id_lesson_e7dc0c98_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_schedulelesson
    ADD CONSTRAINT api_schedulelesson_daily_schedule_id_lesson_e7dc0c98_uniq UNIQUE (daily_schedule_id, lesson_number);


--
-- Name: api_schedulelesson api_schedulelesson_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_schedulelesson
    ADD CONSTRAINT api_schedulelesson_pkey PRIMARY KEY (id);


--
-- Name: api_studentgroup api_studentgroup_name_year_d53ad551_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_studentgroup
    ADD CONSTRAINT api_studentgroup_name_year_d53ad551_uniq UNIQUE (name, year);


--
-- Name: api_studentgroup api_studentgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_studentgroup
    ADD CONSTRAINT api_studentgroup_pkey PRIMARY KEY (id);


--
-- Name: api_studentprofile api_studentprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_studentprofile
    ADD CONSTRAINT api_studentprofile_pkey PRIMARY KEY (user_id);


--
-- Name: api_subject api_subject_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_subject
    ADD CONSTRAINT api_subject_name_key UNIQUE (name);


--
-- Name: api_subject api_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_subject
    ADD CONSTRAINT api_subject_pkey PRIMARY KEY (id);


--
-- Name: api_teacherprofile api_teacherprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_teacherprofile
    ADD CONSTRAINT api_teacherprofile_pkey PRIMARY KEY (user_id);


--
-- Name: api_teachersubject api_teachersubject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_teachersubject
    ADD CONSTRAINT api_teachersubject_pkey PRIMARY KEY (id);


--
-- Name: api_teachersubject api_teachersubject_teacher_id_subject_id_1b83d189_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_teachersubject
    ADD CONSTRAINT api_teachersubject_teacher_id_subject_id_1b83d189_uniq UNIQUE (teacher_id, subject_id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: backup_service_backuplog backup_service_backuplog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backup_service_backuplog
    ADD CONSTRAINT backup_service_backuplog_pkey PRIMARY KEY (id);


--
-- Name: backup_service_backupschedule backup_service_backupschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backup_service_backupschedule
    ADD CONSTRAINT backup_service_backupschedule_pkey PRIMARY KEY (id);


--
-- Name: backup_service_databasebackup backup_service_databasebackup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backup_service_databasebackup
    ADD CONSTRAINT backup_service_databasebackup_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: education_department_lessonreplacement education_department_les_replacement_date_origina_3b03f127_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_department_lessonreplacement
    ADD CONSTRAINT education_department_les_replacement_date_origina_3b03f127_uniq UNIQUE (replacement_date, original_lesson_id);


--
-- Name: education_department_lessonreplacement education_department_lessonreplacement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_department_lessonreplacement
    ADD CONSTRAINT education_department_lessonreplacement_pkey PRIMARY KEY (id);


--
-- Name: api_announcement_author_id_15102650; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_announcement_author_id_15102650 ON public.api_announcement USING btree (author_id);


--
-- Name: api_announcement_student_group_id_200311ba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_announcement_student_group_id_200311ba ON public.api_announcement USING btree (student_group_id);


--
-- Name: api_attendance_schedule_lesson_id_4b78f904; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_attendance_schedule_lesson_id_4b78f904 ON public.api_attendance USING btree (schedule_lesson_id);


--
-- Name: api_attendance_student_id_a3cfd463; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_attendance_student_id_a3cfd463 ON public.api_attendance USING btree (student_id);


--
-- Name: api_auditlo_model_n_a416ae_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_auditlo_model_n_a416ae_idx ON public.api_auditlog USING btree (model_name, action);


--
-- Name: api_auditlo_timesta_da87a7_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_auditlo_timesta_da87a7_idx ON public.api_auditlog USING btree ("timestamp");


--
-- Name: api_auditlo_user_id_8f69e8_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_auditlo_user_id_8f69e8_idx ON public.api_auditlog USING btree (user_id, "timestamp");


--
-- Name: api_auditlog_user_id_b15d4175; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_auditlog_user_id_b15d4175 ON public.api_auditlog USING btree (user_id);


--
-- Name: api_comment_author_id_c45b2dbf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_comment_author_id_c45b2dbf ON public.api_comment USING btree (author_id);


--
-- Name: api_comment_homework_id_3931172d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_comment_homework_id_3931172d ON public.api_comment USING btree (homework_id);


--
-- Name: api_dailyschedule_student_group_id_43930f69; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_dailyschedule_student_group_id_43930f69 ON public.api_dailyschedule USING btree (student_group_id);


--
-- Name: api_grade_schedule_lesson_id_e2750971; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_grade_schedule_lesson_id_e2750971 ON public.api_grade USING btree (schedule_lesson_id);


--
-- Name: api_grade_student_id_83a2fc66; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_grade_student_id_83a2fc66 ON public.api_grade USING btree (student_id);


--
-- Name: api_grade_subject_id_491e7cc2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_grade_subject_id_491e7cc2 ON public.api_grade USING btree (subject_id);


--
-- Name: api_grade_teacher_id_fd728fbb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_grade_teacher_id_fd728fbb ON public.api_grade USING btree (teacher_id);


--
-- Name: api_homework_schedule_lesson_id_80e076e8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_homework_schedule_lesson_id_80e076e8 ON public.api_homework USING btree (schedule_lesson_id);


--
-- Name: api_homework_student_group_id_f0c6778a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_homework_student_group_id_f0c6778a ON public.api_homework USING btree (student_group_id);


--
-- Name: api_homeworksubmission_homework_id_c940442b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_homeworksubmission_homework_id_c940442b ON public.api_homeworksubmission USING btree (homework_id);


--
-- Name: api_homeworksubmission_student_id_44163573; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_homeworksubmission_student_id_44163573 ON public.api_homeworksubmission USING btree (student_id);


--
-- Name: api_schedulelesson_daily_schedule_id_6061c1eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_schedulelesson_daily_schedule_id_6061c1eb ON public.api_schedulelesson USING btree (daily_schedule_id);


--
-- Name: api_schedulelesson_subject_id_2834210c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_schedulelesson_subject_id_2834210c ON public.api_schedulelesson USING btree (subject_id);


--
-- Name: api_schedulelesson_teacher_id_42e42734; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_schedulelesson_teacher_id_42e42734 ON public.api_schedulelesson USING btree (teacher_id);


--
-- Name: api_studentgroup_curator_id_526e8903; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_studentgroup_curator_id_526e8903 ON public.api_studentgroup USING btree (curator_id);


--
-- Name: api_studentprofile_student_group_id_884d8218; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_studentprofile_student_group_id_884d8218 ON public.api_studentprofile USING btree (student_group_id);


--
-- Name: api_subject_name_2445dd86_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_subject_name_2445dd86_like ON public.api_subject USING btree (name varchar_pattern_ops);


--
-- Name: api_teachersubject_subject_id_2fe1cb1f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_teachersubject_subject_id_2fe1cb1f ON public.api_teachersubject USING btree (subject_id);


--
-- Name: api_teachersubject_teacher_id_c19a5845; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_teachersubject_teacher_id_c19a5845 ON public.api_teachersubject USING btree (teacher_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: backup_service_backuplog_backup_id_66f290e9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backup_service_backuplog_backup_id_66f290e9 ON public.backup_service_backuplog USING btree (backup_id);


--
-- Name: backup_service_backuplog_user_id_c807c693; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backup_service_backuplog_user_id_c807c693 ON public.backup_service_backuplog USING btree (user_id);


--
-- Name: backup_service_databasebackup_created_by_id_2d1023bc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backup_service_databasebackup_created_by_id_2d1023bc ON public.backup_service_databasebackup USING btree (created_by_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: education_department_lesso_original_lesson_id_fa81ae34; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX education_department_lesso_original_lesson_id_fa81ae34 ON public.education_department_lessonreplacement USING btree (original_lesson_id);


--
-- Name: education_department_lesso_replacement_date_6a50e108; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX education_department_lesso_replacement_date_6a50e108 ON public.education_department_lessonreplacement USING btree (replacement_date);


--
-- Name: education_department_lesso_replacement_subject_id_fcce4c62; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX education_department_lesso_replacement_subject_id_fcce4c62 ON public.education_department_lessonreplacement USING btree (replacement_subject_id);


--
-- Name: education_department_lesso_replacement_teacher_id_c4fffc98; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX education_department_lesso_replacement_teacher_id_c4fffc98 ON public.education_department_lessonreplacement USING btree (replacement_teacher_id);


--
-- Name: education_department_lessonreplacement_created_by_id_2fd1f472; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX education_department_lessonreplacement_created_by_id_2fd1f472 ON public.education_department_lessonreplacement USING btree (created_by_id);


--
-- Name: api_announcement audit_announcement_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_announcement_trigger AFTER INSERT OR DELETE OR UPDATE ON public.api_announcement FOR EACH ROW EXECUTE FUNCTION public.audit_log_trigger_function();


--
-- Name: api_attendance audit_attendance_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_attendance_trigger AFTER INSERT OR DELETE OR UPDATE ON public.api_attendance FOR EACH ROW EXECUTE FUNCTION public.audit_log_trigger_function();


--
-- Name: auth_user audit_auth_user_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_auth_user_trigger AFTER INSERT OR DELETE OR UPDATE ON public.auth_user FOR EACH ROW EXECUTE FUNCTION public.audit_log_trigger_function();


--
-- Name: api_comment audit_comment_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_comment_trigger AFTER INSERT OR DELETE OR UPDATE ON public.api_comment FOR EACH ROW EXECUTE FUNCTION public.audit_log_trigger_function();


--
-- Name: api_dailyschedule audit_dailyschedule_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_dailyschedule_trigger AFTER INSERT OR DELETE OR UPDATE ON public.api_dailyschedule FOR EACH ROW EXECUTE FUNCTION public.audit_log_trigger_function();


--
-- Name: api_grade audit_grade_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_grade_trigger AFTER INSERT OR DELETE OR UPDATE ON public.api_grade FOR EACH ROW EXECUTE FUNCTION public.audit_log_trigger_function();


--
-- Name: api_homework audit_homework_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_homework_trigger AFTER INSERT OR DELETE OR UPDATE ON public.api_homework FOR EACH ROW EXECUTE FUNCTION public.audit_log_trigger_function();


--
-- Name: api_homeworksubmission audit_homeworksubmission_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_homeworksubmission_trigger AFTER INSERT OR DELETE OR UPDATE ON public.api_homeworksubmission FOR EACH ROW EXECUTE FUNCTION public.audit_log_trigger_function();


--
-- Name: api_schedulelesson audit_schedulelesson_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_schedulelesson_trigger AFTER INSERT OR DELETE OR UPDATE ON public.api_schedulelesson FOR EACH ROW EXECUTE FUNCTION public.audit_log_trigger_function();


--
-- Name: api_studentgroup audit_studentgroup_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_studentgroup_trigger AFTER INSERT OR DELETE OR UPDATE ON public.api_studentgroup FOR EACH ROW EXECUTE FUNCTION public.audit_log_trigger_function();


--
-- Name: api_studentprofile audit_studentprofile_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_studentprofile_trigger AFTER INSERT OR DELETE OR UPDATE ON public.api_studentprofile FOR EACH ROW EXECUTE FUNCTION public.audit_log_trigger_function();


--
-- Name: api_subject audit_subject_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_subject_trigger AFTER INSERT OR DELETE OR UPDATE ON public.api_subject FOR EACH ROW EXECUTE FUNCTION public.audit_log_trigger_function();


--
-- Name: api_teacherprofile audit_teacherprofile_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_teacherprofile_trigger AFTER INSERT OR DELETE OR UPDATE ON public.api_teacherprofile FOR EACH ROW EXECUTE FUNCTION public.audit_log_trigger_function();


--
-- Name: api_teachersubject audit_teachersubject_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_teachersubject_trigger AFTER INSERT OR DELETE OR UPDATE ON public.api_teachersubject FOR EACH ROW EXECUTE FUNCTION public.audit_log_trigger_function();


--
-- Name: api_announcement api_announcement_author_id_15102650_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_announcement
    ADD CONSTRAINT api_announcement_author_id_15102650_fk_auth_user_id FOREIGN KEY (author_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_announcement api_announcement_student_group_id_200311ba_fk_api_stude; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_announcement
    ADD CONSTRAINT api_announcement_student_group_id_200311ba_fk_api_stude FOREIGN KEY (student_group_id) REFERENCES public.api_studentgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_attendance api_attendance_schedule_lesson_id_4b78f904_fk_api_sched; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_attendance
    ADD CONSTRAINT api_attendance_schedule_lesson_id_4b78f904_fk_api_sched FOREIGN KEY (schedule_lesson_id) REFERENCES public.api_schedulelesson(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_attendance api_attendance_student_id_a3cfd463_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_attendance
    ADD CONSTRAINT api_attendance_student_id_a3cfd463_fk_auth_user_id FOREIGN KEY (student_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_auditlog api_auditlog_user_id_b15d4175_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_auditlog
    ADD CONSTRAINT api_auditlog_user_id_b15d4175_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_comment api_comment_author_id_c45b2dbf_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_comment
    ADD CONSTRAINT api_comment_author_id_c45b2dbf_fk_auth_user_id FOREIGN KEY (author_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_comment api_comment_homework_id_3931172d_fk_api_homework_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_comment
    ADD CONSTRAINT api_comment_homework_id_3931172d_fk_api_homework_id FOREIGN KEY (homework_id) REFERENCES public.api_homework(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_dailyschedule api_dailyschedule_student_group_id_43930f69_fk_api_stude; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_dailyschedule
    ADD CONSTRAINT api_dailyschedule_student_group_id_43930f69_fk_api_stude FOREIGN KEY (student_group_id) REFERENCES public.api_studentgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_grade api_grade_schedule_lesson_id_e2750971_fk_api_schedulelesson_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_grade
    ADD CONSTRAINT api_grade_schedule_lesson_id_e2750971_fk_api_schedulelesson_id FOREIGN KEY (schedule_lesson_id) REFERENCES public.api_schedulelesson(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_grade api_grade_student_id_83a2fc66_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_grade
    ADD CONSTRAINT api_grade_student_id_83a2fc66_fk_auth_user_id FOREIGN KEY (student_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_grade api_grade_subject_id_491e7cc2_fk_api_subject_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_grade
    ADD CONSTRAINT api_grade_subject_id_491e7cc2_fk_api_subject_id FOREIGN KEY (subject_id) REFERENCES public.api_subject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_grade api_grade_teacher_id_fd728fbb_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_grade
    ADD CONSTRAINT api_grade_teacher_id_fd728fbb_fk_auth_user_id FOREIGN KEY (teacher_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_homework api_homework_schedule_lesson_id_80e076e8_fk_api_sched; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_homework
    ADD CONSTRAINT api_homework_schedule_lesson_id_80e076e8_fk_api_sched FOREIGN KEY (schedule_lesson_id) REFERENCES public.api_schedulelesson(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_homework api_homework_student_group_id_f0c6778a_fk_api_studentgroup_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_homework
    ADD CONSTRAINT api_homework_student_group_id_f0c6778a_fk_api_studentgroup_id FOREIGN KEY (student_group_id) REFERENCES public.api_studentgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_homeworksubmission api_homeworksubmission_homework_id_c940442b_fk_api_homework_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_homeworksubmission
    ADD CONSTRAINT api_homeworksubmission_homework_id_c940442b_fk_api_homework_id FOREIGN KEY (homework_id) REFERENCES public.api_homework(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_homeworksubmission api_homeworksubmission_student_id_44163573_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_homeworksubmission
    ADD CONSTRAINT api_homeworksubmission_student_id_44163573_fk_auth_user_id FOREIGN KEY (student_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_schedulelesson api_schedulelesson_daily_schedule_id_6061c1eb_fk_api_daily; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_schedulelesson
    ADD CONSTRAINT api_schedulelesson_daily_schedule_id_6061c1eb_fk_api_daily FOREIGN KEY (daily_schedule_id) REFERENCES public.api_dailyschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_schedulelesson api_schedulelesson_subject_id_2834210c_fk_api_subject_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_schedulelesson
    ADD CONSTRAINT api_schedulelesson_subject_id_2834210c_fk_api_subject_id FOREIGN KEY (subject_id) REFERENCES public.api_subject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_schedulelesson api_schedulelesson_teacher_id_42e42734_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_schedulelesson
    ADD CONSTRAINT api_schedulelesson_teacher_id_42e42734_fk_auth_user_id FOREIGN KEY (teacher_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_studentgroup api_studentgroup_curator_id_526e8903_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_studentgroup
    ADD CONSTRAINT api_studentgroup_curator_id_526e8903_fk_auth_user_id FOREIGN KEY (curator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_studentprofile api_studentprofile_student_group_id_884d8218_fk_api_stude; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_studentprofile
    ADD CONSTRAINT api_studentprofile_student_group_id_884d8218_fk_api_stude FOREIGN KEY (student_group_id) REFERENCES public.api_studentgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_studentprofile api_studentprofile_user_id_552393d1_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_studentprofile
    ADD CONSTRAINT api_studentprofile_user_id_552393d1_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_teacherprofile api_teacherprofile_user_id_62a77e96_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_teacherprofile
    ADD CONSTRAINT api_teacherprofile_user_id_62a77e96_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_teachersubject api_teachersubject_subject_id_2fe1cb1f_fk_api_subject_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_teachersubject
    ADD CONSTRAINT api_teachersubject_subject_id_2fe1cb1f_fk_api_subject_id FOREIGN KEY (subject_id) REFERENCES public.api_subject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_teachersubject api_teachersubject_teacher_id_c19a5845_fk_api_teach; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_teachersubject
    ADD CONSTRAINT api_teachersubject_teacher_id_c19a5845_fk_api_teach FOREIGN KEY (teacher_id) REFERENCES public.api_teacherprofile(user_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backup_service_backuplog backup_service_backu_backup_id_66f290e9_fk_backup_se; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backup_service_backuplog
    ADD CONSTRAINT backup_service_backu_backup_id_66f290e9_fk_backup_se FOREIGN KEY (backup_id) REFERENCES public.backup_service_databasebackup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backup_service_backuplog backup_service_backuplog_user_id_c807c693_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backup_service_backuplog
    ADD CONSTRAINT backup_service_backuplog_user_id_c807c693_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backup_service_databasebackup backup_service_datab_created_by_id_2d1023bc_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backup_service_databasebackup
    ADD CONSTRAINT backup_service_datab_created_by_id_2d1023bc_fk_auth_user FOREIGN KEY (created_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: education_department_lessonreplacement education_department_created_by_id_2fd1f472_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_department_lessonreplacement
    ADD CONSTRAINT education_department_created_by_id_2fd1f472_fk_auth_user FOREIGN KEY (created_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: education_department_lessonreplacement education_department_original_lesson_id_fa81ae34_fk_api_sched; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_department_lessonreplacement
    ADD CONSTRAINT education_department_original_lesson_id_fa81ae34_fk_api_sched FOREIGN KEY (original_lesson_id) REFERENCES public.api_schedulelesson(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: education_department_lessonreplacement education_department_replacement_subject__fcce4c62_fk_api_subje; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_department_lessonreplacement
    ADD CONSTRAINT education_department_replacement_subject__fcce4c62_fk_api_subje FOREIGN KEY (replacement_subject_id) REFERENCES public.api_subject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: education_department_lessonreplacement education_department_replacement_teacher__c4fffc98_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_department_lessonreplacement
    ADD CONSTRAINT education_department_replacement_teacher__c4fffc98_fk_auth_user FOREIGN KEY (replacement_teacher_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--


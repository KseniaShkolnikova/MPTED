--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

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
\.


--
-- Data for Name: api_auditlog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_auditlog (id, action, model_name, object_id, old_values, new_values, ip_address, user_agent, request_path, request_method, "timestamp", is_system_action, user_id) FROM stdin;
1	UPDATE	StudentGroup	4	{"id": 4, "name": "user", "year": 2, "curator_id": 6}	{"id": 4, "name": "п50-422", "year": 2, "curator_id": 6}	\N	\N	\N	\N	2026-01-31 18:27:26.113065+03	t	\N
2	DELETE	DailySchedule	5	{"id": 5, "week_day": "TUE", "is_active": true, "is_weekend": true, "student_group_id": 5}	\N	\N	\N	\N	\N	2026-01-31 18:28:08.272555+03	t	\N
3	DELETE	StudentGroup	5	{"id": 5, "name": "фыч", "year": 2, "curator_id": null}	\N	\N	\N	\N	\N	2026-01-31 18:28:08.272555+03	t	\N
4	CREATE	StudentGroup	6	\N	{"id": 6, "name": "аув", "year": 1, "curator_id": 4}	\N	\N	\N	\N	2026-01-31 18:28:43.410962+03	t	\N
5	CREATE	auth_user	7	\N	{"id": 7, "email": "sesha_shk3@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$GtMU2umd2XWT03AKGgl2cQ$3U5sPQQc5tvNg8WL+fOkPyFU5LbnO3012UQ6MEi93ac=", "username": "admin@mail.ru", "is_active": true, "last_name": "dc", "first_name": "dd", "last_login": null, "date_joined": "2026-01-31T15:29:26.77964+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-01-31 18:29:27.436721+03	t	\N
6	UPDATE	auth_user	7	{"id": 7, "email": "sesha_shk3@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$GtMU2umd2XWT03AKGgl2cQ$3U5sPQQc5tvNg8WL+fOkPyFU5LbnO3012UQ6MEi93ac=", "username": "admin@mail.ru", "is_active": true, "last_name": "dc", "first_name": "dd", "last_login": null, "date_joined": "2026-01-31T15:29:26.77964+00:00", "is_superuser": false}	{"id": 7, "email": "sesha_shk3@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$GtMU2umd2XWT03AKGgl2cQ$3U5sPQQc5tvNg8WL+fOkPyFU5LbnO3012UQ6MEi93ac=", "username": "admin@mail.ru", "is_active": true, "last_name": "dc", "first_name": "dd", "last_login": "2026-01-31T15:30:40.228636+00:00", "date_joined": "2026-01-31T15:29:26.77964+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-01-31 18:30:40.229145+03	t	\N
7	UPDATE	auth_user	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-01-31T14:49:54.852917+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-01-31T15:31:03.772228+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-01-31 18:31:03.772762+03	t	\N
8	CREATE	auth_user	8	\N	{"id": 8, "email": "sesha_sh2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$V3nRa1TXgsM7KurjV6J9SR$SQg2pvO5RR4UlsYVD1VWoYlYG0EsSNbSzYrCiKa9SiA=", "username": "trainer@mail.ru", "is_active": true, "last_name": "ss", "first_name": "s", "last_login": null, "date_joined": "2026-01-31T15:32:17.25667+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-01-31 18:32:17.901515+03	t	\N
9	CREATE	StudentProfile	7	\N	{"phone": "", "course": 1, "address": "", "user_id": 7, "birth_date": null, "patronymic": "", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	2026-01-31 18:35:05.73104+03	t	\N
10	UPDATE	StudentProfile	7	{"phone": "", "course": 1, "address": "", "user_id": 7, "birth_date": null, "patronymic": "", "profile_image": "", "student_group_id": null}	{"phone": "", "course": 1, "address": "", "user_id": 7, "birth_date": null, "patronymic": "", "profile_image": "", "student_group_id": 6}	\N	\N	\N	\N	2026-01-31 18:35:05.737677+03	t	\N
11	CREATE	StudentProfile	8	\N	{"phone": "", "course": 1, "address": "", "user_id": 8, "birth_date": null, "patronymic": "", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	2026-01-31 18:35:07.534475+03	t	\N
12	UPDATE	StudentProfile	8	{"phone": "", "course": 1, "address": "", "user_id": 8, "birth_date": null, "patronymic": "", "profile_image": "", "student_group_id": null}	{"phone": "", "course": 1, "address": "", "user_id": 8, "birth_date": null, "patronymic": "", "profile_image": "", "student_group_id": 6}	\N	\N	\N	\N	2026-01-31 18:35:07.543792+03	t	\N
13	UPDATE	User	7	{"id": 7, "email": "sesha_shk3@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$GtMU2umd2XWT03AKGgl2cQ$3U5sPQQc5tvNg8WL+fOkPyFU5LbnO3012UQ6MEi93ac=", "username": "admin@mail.ru", "is_active": true, "last_name": "dc", "first_name": "dd", "last_login": "2026-01-31T15:30:40.228636+00:00", "date_joined": "2026-01-31T15:29:26.77964+00:00", "is_superuser": false}	{"id": 7, "email": "sesha_shk3@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$GtMU2umd2XWT03AKGgl2cQ$3U5sPQQc5tvNg8WL+fOkPyFU5LbnO3012UQ6MEi93ac=", "username": "admin@mail.ru", "is_active": true, "last_name": "dc", "first_name": "dd", "last_login": "2026-01-31T15:35:15.245767+00:00", "date_joined": "2026-01-31T15:29:26.77964+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-01-31 18:35:15.246179+03	t	\N
14	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-01-31T15:31:03.772228+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-01-31T15:35:40.782838+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-01-31 18:35:40.783877+03	t	\N
15	CREATE	User	9	\N	{"id": 9, "email": "mail@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$yj9WZmt5URkWZKR1UA7SK4$o42RubUl6rqHGfZYlV161fctzlBt7p6hpuKXhAVM1r8=", "username": "ad@mail.ru", "is_active": true, "last_name": "cc", "first_name": "cc", "last_login": null, "date_joined": "2026-01-31T15:36:23.199562+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-01-31 18:36:23.847291+03	t	\N
16	CREATE	StudentProfile	9	\N	{"phone": "", "course": 2, "address": "", "user_id": 9, "birth_date": null, "patronymic": "cc", "profile_image": "", "student_group_id": 6}	\N	\N	\N	\N	2026-01-31 18:36:23.860543+03	t	\N
17	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-01-31T15:35:40.782838+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-01-31T21:12:21.316353+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-01 00:12:21.316911+03	t	\N
18	UPDATE	DailySchedule	3	{"id": 3, "week_day": "WED", "is_active": true, "is_weekend": true, "student_group_id": 4}	{"id": 3, "week_day": "WED", "is_active": true, "is_weekend": false, "student_group_id": 4}	\N	\N	\N	\N	2026-02-01 00:13:08.928191+03	t	\N
19	CREATE	ScheduleLesson	15	\N	{"id": 15, "subject_id": 1, "teacher_id": 4, "lesson_number": 3, "daily_schedule_id": 3}	\N	\N	\N	\N	2026-02-01 00:13:19.05196+03	t	\N
20	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-01-31T12:18:39.322086+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-01-31T21:13:40.665597+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-01 00:13:40.6663+03	t	\N
21	UPDATE	User	4	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": null, "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-01-31T21:14:37.589374+00:00", "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-01 00:14:37.589841+03	t	\N
22	CREATE	Attendance	6	\N	{"id": 6, "date": "2026-01-31", "status": "P", "student_id": 3, "schedule_lesson_id": 11}	\N	\N	\N	\N	2026-02-01 00:14:57.080372+03	t	\N
23	CREATE	Attendance	7	\N	{"id": 7, "date": "2026-01-31", "status": "L", "student_id": 5, "schedule_lesson_id": 11}	\N	\N	\N	\N	2026-02-01 00:14:59.163004+03	t	\N
24	CREATE	Attendance	8	\N	{"id": 8, "date": "2026-01-31", "status": "A", "student_id": 3, "schedule_lesson_id": 10}	\N	\N	\N	\N	2026-02-01 00:15:00.667801+03	t	\N
25	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-01-31T21:12:21.316353+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-03T10:53:05.110306+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 13:53:05.114294+03	t	\N
26	UPDATE	StudentProfile	9	{"phone": "", "course": 2, "address": "", "user_id": 9, "birth_date": null, "patronymic": "cc", "profile_image": "", "student_group_id": 6}	{"phone": "", "course": 2, "address": "", "user_id": 9, "birth_date": null, "patronymic": "cc", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	2026-02-03 13:54:00.145103+03	t	\N
27	UPDATE	StudentProfile	9	{"phone": "", "course": 2, "address": "", "user_id": 9, "birth_date": null, "patronymic": "cc", "profile_image": "", "student_group_id": null}	{"phone": "", "course": 2, "address": "", "user_id": 9, "birth_date": null, "patronymic": "cc", "profile_image": "", "student_group_id": 6}	\N	\N	\N	\N	2026-02-03 13:54:01.970885+03	t	\N
28	UPDATE	Subject	3	{"id": 3, "name": "апр", "description": "апр"}	{"id": 3, "name": "апр", "description": "апр"}	\N	\N	\N	\N	2026-02-03 13:54:15.464104+03	t	\N
29	UPDATE	DailySchedule	4	{"id": 4, "week_day": "FRI", "is_active": true, "is_weekend": false, "student_group_id": 4}	{"id": 4, "week_day": "FRI", "is_active": true, "is_weekend": true, "student_group_id": 4}	\N	\N	\N	\N	2026-02-03 13:54:45.104521+03	t	\N
30	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-01-31T21:13:40.665597+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-03T10:55:44.888464+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 13:55:44.889147+03	t	\N
31	UPDATE	User	4	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-01-31T21:14:37.589374+00:00", "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-03T10:56:49.370979+00:00", "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 13:56:49.371802+03	t	\N
32	CREATE	Grade	4	\N	{"id": 4, "date": "2026-02-03", "value": 2.0, "comment": "", "grade_type": "ORAL", "student_id": 7, "subject_id": 3, "teacher_id": 4, "schedule_lesson_id": 4}	\N	\N	\N	\N	2026-02-03 13:57:44.818471+03	t	\N
33	CREATE	Attendance	9	\N	{"id": 9, "date": "2026-02-03", "status": "P", "student_id": 3, "schedule_lesson_id": 5}	\N	\N	\N	\N	2026-02-03 13:57:54.863108+03	t	\N
34	CREATE	Attendance	10	\N	{"id": 10, "date": "2026-02-03", "status": "L", "student_id": 5, "schedule_lesson_id": 5}	\N	\N	\N	\N	2026-02-03 13:57:55.866265+03	t	\N
35	CREATE	Attendance	11	\N	{"id": 11, "date": "2026-02-03", "status": "A", "student_id": 5, "schedule_lesson_id": 7}	\N	\N	\N	\N	2026-02-03 13:57:57.197509+03	t	\N
36	CREATE	Attendance	12	\N	{"id": 12, "date": "2026-02-03", "status": "P", "student_id": 3, "schedule_lesson_id": 7}	\N	\N	\N	\N	2026-02-03 13:59:04.403835+03	t	\N
37	CREATE	Attendance	13	\N	{"id": 13, "date": "2026-02-03", "status": "L", "student_id": 5, "schedule_lesson_id": 8}	\N	\N	\N	\N	2026-02-03 13:59:06.576142+03	t	\N
38	CREATE	Attendance	14	\N	{"id": 14, "date": "2026-02-03", "status": "P", "student_id": 3, "schedule_lesson_id": 6}	\N	\N	\N	\N	2026-02-03 13:59:07.39923+03	t	\N
39	CREATE	Attendance	15	\N	{"id": 15, "date": "2026-02-03", "status": "A", "student_id": 3, "schedule_lesson_id": 8}	\N	\N	\N	\N	2026-02-03 13:59:08.162669+03	t	\N
40	CREATE	Attendance	16	\N	{"id": 16, "date": "2026-02-03", "status": "A", "student_id": 5, "schedule_lesson_id": 6}	\N	\N	\N	\N	2026-02-03 13:59:08.940958+03	t	\N
41	UPDATE	User	7	{"id": 7, "email": "sesha_shk3@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$GtMU2umd2XWT03AKGgl2cQ$3U5sPQQc5tvNg8WL+fOkPyFU5LbnO3012UQ6MEi93ac=", "username": "admin@mail.ru", "is_active": true, "last_name": "dc", "first_name": "dd", "last_login": "2026-01-31T15:35:15.245767+00:00", "date_joined": "2026-01-31T15:29:26.77964+00:00", "is_superuser": false}	{"id": 7, "email": "sesha_shk3@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$GtMU2umd2XWT03AKGgl2cQ$3U5sPQQc5tvNg8WL+fOkPyFU5LbnO3012UQ6MEi93ac=", "username": "admin@mail.ru", "is_active": true, "last_name": "dc", "first_name": "dd", "last_login": "2026-02-03T11:01:33.475051+00:00", "date_joined": "2026-01-31T15:29:26.77964+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 14:01:33.476768+03	t	\N
42	UPDATE	User	4	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-03T10:56:49.370979+00:00", "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-03T11:02:08.140289+00:00", "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 14:02:08.144218+03	t	\N
43	CREATE	Grade	5	\N	{"id": 5, "date": "2026-02-03", "value": 5.0, "comment": "", "grade_type": "CW", "student_id": 7, "subject_id": 1, "teacher_id": 4, "schedule_lesson_id": 10}	\N	\N	\N	\N	2026-02-03 14:02:26.994369+03	t	\N
44	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-03T10:55:44.888464+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-03T11:02:40.437698+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 14:02:40.439855+03	t	\N
45	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-03T10:53:05.110306+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-03T11:03:13.137309+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 14:03:13.138986+03	t	\N
46	UPDATE	User	7	{"id": 7, "email": "sesha_shk3@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$GtMU2umd2XWT03AKGgl2cQ$3U5sPQQc5tvNg8WL+fOkPyFU5LbnO3012UQ6MEi93ac=", "username": "admin@mail.ru", "is_active": true, "last_name": "dc", "first_name": "dd", "last_login": "2026-02-03T11:01:33.475051+00:00", "date_joined": "2026-01-31T15:29:26.77964+00:00", "is_superuser": false}	{"id": 7, "email": "sesha_shk3@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$GtMU2umd2XWT03AKGgl2cQ$3U5sPQQc5tvNg8WL+fOkPyFU5LbnO3012UQ6MEi93ac=", "username": "admin@mail.ru", "is_active": true, "last_name": "dc", "first_name": "dd", "last_login": "2026-02-03T11:03:26.579499+00:00", "date_joined": "2026-01-31T15:29:26.77964+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 14:03:26.580599+03	t	\N
47	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-03T11:03:13.137309+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-03T11:04:42.303682+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 14:04:42.306583+03	t	\N
48	CREATE	User	10	\N	{"id": 10, "email": "2006@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$YpMK98z2yR58FJMNuSCHs9$LMD0Ip6yLj3QaTmtb8SEDRex5AsO+C9msG8yrFCs/30=", "username": "2006@mail.ru", "is_active": true, "last_name": "школьниковро", "first_name": "Иван", "last_login": null, "date_joined": "2026-02-03T11:25:22.936796+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 14:25:25.058622+03	t	\N
49	CREATE	StudentProfile	10	\N	{"phone": "", "course": 2, "address": "", "user_id": 10, "birth_date": "2006-01-03", "patronymic": "Васильевна", "profile_image": "", "student_group_id": 4}	\N	\N	\N	\N	2026-02-03 14:25:25.142687+03	t	\N
50	UPDATE	User	10	{"id": 10, "email": "2006@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$YpMK98z2yR58FJMNuSCHs9$LMD0Ip6yLj3QaTmtb8SEDRex5AsO+C9msG8yrFCs/30=", "username": "2006@mail.ru", "is_active": true, "last_name": "школьниковро", "first_name": "Иван", "last_login": null, "date_joined": "2026-02-03T11:25:22.936796+00:00", "is_superuser": false}	{"id": 10, "email": "2006@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$YpMK98z2yR58FJMNuSCHs9$LMD0Ip6yLj3QaTmtb8SEDRex5AsO+C9msG8yrFCs/30=", "username": "2006@mail.ru", "is_active": false, "last_name": "школьниковро", "first_name": "Иван", "last_login": null, "date_joined": "2026-02-03T11:25:22.936796+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 14:25:59.734941+03	t	\N
51	UPDATE	User	10	{"id": 10, "email": "2006@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$YpMK98z2yR58FJMNuSCHs9$LMD0Ip6yLj3QaTmtb8SEDRex5AsO+C9msG8yrFCs/30=", "username": "2006@mail.ru", "is_active": false, "last_name": "школьниковро", "first_name": "Иван", "last_login": null, "date_joined": "2026-02-03T11:25:22.936796+00:00", "is_superuser": false}	{"id": 10, "email": "2006@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$YpMK98z2yR58FJMNuSCHs9$LMD0Ip6yLj3QaTmtb8SEDRex5AsO+C9msG8yrFCs/30=", "username": "2006@mail.ru", "is_active": true, "last_name": "школьниковро", "first_name": "Иван", "last_login": null, "date_joined": "2026-02-03T11:25:22.936796+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 14:26:04.149576+03	t	\N
52	UPDATE	StudentGroup	6	{"id": 6, "name": "аув", "year": 1, "curator_id": 4}	{"id": 6, "name": "аув", "year": 1, "curator_id": 4}	\N	\N	\N	\N	2026-02-03 14:26:48.749448+03	t	\N
53	CREATE	Subject	5	\N	{"id": 5, "name": "Суши", "description": ""}	\N	\N	\N	\N	2026-02-03 14:27:12.288945+03	t	\N
54	UPDATE	User	6	{"id": 6, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$RlOXenbRLvap9crdB3EgrR$cb4PkmR5fd7A9+pQCNytKn3dhCoyNZoBpIW5OwYEhUE=", "username": "teacher@mail.tu", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-01-31T12:19:02.136158+00:00", "date_joined": "2026-01-31T11:01:18+00:00", "is_superuser": false}	{"id": 6, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$RlOXenbRLvap9crdB3EgrR$cb4PkmR5fd7A9+pQCNytKn3dhCoyNZoBpIW5OwYEhUE=", "username": "teacher@mail.tu", "is_active": true, "last_name": "Мистер", "first_name": "Учитель", "last_login": "2026-01-31T12:19:02.136158+00:00", "date_joined": "2026-01-31T11:01:18+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 14:27:36.882755+03	t	\N
55	UPDATE	TeacherProfile	6	{"phone": "", "user_id": 6, "birth_date": null, "patronymic": "", "profile_image": "", "qualification": ""}	{"phone": "", "user_id": 6, "birth_date": null, "patronymic": "оо", "profile_image": "", "qualification": ""}	\N	\N	\N	\N	2026-02-03 14:27:36.891925+03	t	\N
56	CREATE	TeacherSubject	4	\N	{"id": 4, "subject_id": 5, "teacher_id": 6}	\N	\N	\N	\N	2026-02-03 14:28:03.127907+03	t	\N
57	DELETE	Attendance	13	{"id": 13, "date": "2026-02-03", "status": "L", "student_id": 5, "schedule_lesson_id": 8}	\N	\N	\N	\N	\N	2026-02-03 14:28:12.672038+03	t	\N
58	DELETE	Attendance	15	{"id": 15, "date": "2026-02-03", "status": "A", "student_id": 3, "schedule_lesson_id": 8}	\N	\N	\N	\N	\N	2026-02-03 14:28:12.672038+03	t	\N
59	DELETE	ScheduleLesson	8	{"id": 8, "subject_id": 1, "teacher_id": 4, "lesson_number": 3, "daily_schedule_id": 2}	\N	\N	\N	\N	\N	2026-02-03 14:28:12.672038+03	t	\N
60	CREATE	ScheduleLesson	16	\N	{"id": 16, "subject_id": 5, "teacher_id": 6, "lesson_number": 4, "daily_schedule_id": 2}	\N	\N	\N	\N	2026-02-03 14:28:21.784979+03	t	\N
61	CREATE	DailySchedule	8	\N	{"id": 8, "week_day": "MON", "is_active": true, "is_weekend": false, "student_group_id": 6}	\N	\N	\N	\N	2026-02-03 14:28:36.303205+03	t	\N
62	CREATE	ScheduleLesson	17	\N	{"id": 17, "subject_id": 5, "teacher_id": 6, "lesson_number": 1, "daily_schedule_id": 8}	\N	\N	\N	\N	2026-02-03 14:28:36.336513+03	t	\N
63	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-03T11:04:42.303682+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-03T12:53:29.944878+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 15:53:29.945502+03	t	\N
64	UPDATE	User	4	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-03T11:02:08.140289+00:00", "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-03T13:14:19.693396+00:00", "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 16:14:19.693844+03	t	\N
65	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-03T12:53:29.944878+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-03T13:15:22.217842+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 16:15:22.218367+03	t	\N
66	UPDATE	User	4	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-03T13:14:19.693396+00:00", "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	{"id": 4, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=", "username": "teacher@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-03T13:18:04.191742+00:00", "date_joined": "2026-01-22T14:31:50+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 16:18:04.193154+03	t	\N
67	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-03T11:02:40.437698+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-03T13:18:53.669631+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-03 16:18:53.673434+03	t	\N
68	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-03T13:15:22.217842+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T13:47:46.018435+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 16:47:46.019523+03	t	\N
69	CREATE	User	11	\N	{"id": 11, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0LKvFiFTuFXvxzp36G11wT$UT/mmbhuG7VE4ZgqGxmvj8OyvxHhYdm9VodQbL09J+o=", "username": "ddd", "is_active": true, "last_name": "rf", "first_name": "ed", "last_login": null, "date_joined": "2026-02-07T14:20:57.482044+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 17:21:00.255677+03	t	\N
70	CREATE	StudentProfile	11	\N	{"phone": "", "course": 3, "address": "", "user_id": 11, "birth_date": null, "patronymic": "fcd", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	2026-02-07 17:21:00.305877+03	t	\N
71	UPDATE	User	3	{"id": 3, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$4G4Z3xysLHzlkR4iavkNwZ$8p583qf2yNsEbYCL76UzMQAc4Yt7Qvx7Fn9Uj8HmMIc=", "username": "sesha_shk@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-01-27T16:29:00.20304+00:00", "date_joined": "2026-01-21T11:35:53+00:00", "is_superuser": false}	{"id": 3, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$4G4Z3xysLHzlkR4iavkNwZ$8p583qf2yNsEbYCL76UzMQAc4Yt7Qvx7Fn9Uj8HmMIc=", "username": "sesha_shk@mail.ru", "is_active": false, "last_name": "", "first_name": "", "last_login": "2026-01-27T16:29:00.20304+00:00", "date_joined": "2026-01-21T11:35:53+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 17:31:06.022365+03	t	\N
72	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-01-31T11:00:49.609461+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T14:31:41.952706+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-07 17:31:41.954565+03	t	\N
73	DELETE	StudentProfile	3	{"phone": "", "course": 1, "address": "", "user_id": 3, "birth_date": null, "patronymic": "", "profile_image": "", "student_group_id": 4}	\N	\N	\N	\N	\N	2026-02-07 17:32:28.511838+03	t	\N
74	DELETE	Grade	2	{"id": 2, "date": "2026-01-31", "value": 5.0, "comment": "htgfd", "grade_type": "HW", "student_id": 3, "subject_id": 4, "teacher_id": 6, "schedule_lesson_id": 14}	\N	\N	\N	\N	\N	2026-02-07 17:32:28.511838+03	t	\N
75	DELETE	Attendance	3	{"id": 3, "date": "2026-01-31", "status": "P", "student_id": 3, "schedule_lesson_id": 12}	\N	\N	\N	\N	\N	2026-02-07 17:32:28.511838+03	t	\N
76	DELETE	Attendance	6	{"id": 6, "date": "2026-01-31", "status": "P", "student_id": 3, "schedule_lesson_id": 11}	\N	\N	\N	\N	\N	2026-02-07 17:32:28.511838+03	t	\N
77	DELETE	Attendance	8	{"id": 8, "date": "2026-01-31", "status": "A", "student_id": 3, "schedule_lesson_id": 10}	\N	\N	\N	\N	\N	2026-02-07 17:32:28.511838+03	t	\N
78	DELETE	Attendance	9	{"id": 9, "date": "2026-02-03", "status": "P", "student_id": 3, "schedule_lesson_id": 5}	\N	\N	\N	\N	\N	2026-02-07 17:32:28.511838+03	t	\N
79	DELETE	Attendance	12	{"id": 12, "date": "2026-02-03", "status": "P", "student_id": 3, "schedule_lesson_id": 7}	\N	\N	\N	\N	\N	2026-02-07 17:32:28.511838+03	t	\N
80	DELETE	Attendance	14	{"id": 14, "date": "2026-02-03", "status": "P", "student_id": 3, "schedule_lesson_id": 6}	\N	\N	\N	\N	\N	2026-02-07 17:32:28.511838+03	t	\N
81	DELETE	User	3	{"id": 3, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$4G4Z3xysLHzlkR4iavkNwZ$8p583qf2yNsEbYCL76UzMQAc4Yt7Qvx7Fn9Uj8HmMIc=", "username": "sesha_shk@mail.ru", "is_active": false, "last_name": "", "first_name": "", "last_login": "2026-01-27T16:29:00.20304+00:00", "date_joined": "2026-01-21T11:35:53+00:00", "is_superuser": false}	\N	\N	\N	\N	\N	2026-02-07 17:32:28.511838+03	t	\N
82	DELETE	StudentProfile	11	{"phone": "", "course": 3, "address": "", "user_id": 11, "birth_date": null, "patronymic": "fcd", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	\N	2026-02-07 17:37:01.223248+03	t	\N
83	DELETE	User	11	{"id": 11, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0LKvFiFTuFXvxzp36G11wT$UT/mmbhuG7VE4ZgqGxmvj8OyvxHhYdm9VodQbL09J+o=", "username": "ddd", "is_active": true, "last_name": "rf", "first_name": "ed", "last_login": null, "date_joined": "2026-02-07T14:20:57.482044+00:00", "is_superuser": false}	\N	\N	\N	\N	\N	2026-02-07 17:37:01.223248+03	t	\N
84	CREATE	User	12	\N	{"id": 12, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$svJzCgDbMRX2PdcsZMEvWv$ud022dJhTilTP1SOG4Lr2fG1A5bcXFqB0i6Uy5xb6yw=", "username": "ddd", "is_active": true, "last_name": "школьниковро", "first_name": "men@mail.ru", "last_login": null, "date_joined": "2026-02-07T14:37:37.012748+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 17:37:38.583177+03	t	\N
85	CREATE	StudentProfile	12	\N	{"phone": "", "course": 3, "address": "", "user_id": 12, "birth_date": null, "patronymic": "Иванович", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	2026-02-07 17:37:38.618293+03	t	\N
86	DELETE	StudentProfile	12	{"phone": "", "course": 3, "address": "", "user_id": 12, "birth_date": null, "patronymic": "Иванович", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	\N	2026-02-07 17:39:16.348749+03	t	\N
87	DELETE	User	12	{"id": 12, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$svJzCgDbMRX2PdcsZMEvWv$ud022dJhTilTP1SOG4Lr2fG1A5bcXFqB0i6Uy5xb6yw=", "username": "ddd", "is_active": true, "last_name": "школьниковро", "first_name": "men@mail.ru", "last_login": null, "date_joined": "2026-02-07T14:37:37.012748+00:00", "is_superuser": false}	\N	\N	\N	\N	\N	2026-02-07 17:39:16.348749+03	t	\N
88	CREATE	User	13	\N	{"id": 13, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$T4pf0dRSkyClEW6Yhgi9sR$Oe28ywRz/cJYi228ItCrk56u7KEFHjkbthp9n7doEss=", "username": "ddd", "is_active": true, "last_name": "шко", "first_name": "trainer@mail.ru", "last_login": null, "date_joined": "2026-02-07T14:39:42.412117+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 17:39:43.970705+03	t	\N
89	CREATE	StudentProfile	13	\N	{"phone": "", "course": 2, "address": "", "user_id": 13, "birth_date": null, "patronymic": "Иванович", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	2026-02-07 17:39:44.010965+03	t	\N
90	DELETE	StudentProfile	13	{"phone": "", "course": 2, "address": "", "user_id": 13, "birth_date": null, "patronymic": "Иванович", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	\N	2026-02-07 17:40:45.0533+03	t	\N
91	DELETE	User	13	{"id": 13, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$T4pf0dRSkyClEW6Yhgi9sR$Oe28ywRz/cJYi228ItCrk56u7KEFHjkbthp9n7doEss=", "username": "ddd", "is_active": true, "last_name": "шко", "first_name": "trainer@mail.ru", "last_login": null, "date_joined": "2026-02-07T14:39:42.412117+00:00", "is_superuser": false}	\N	\N	\N	\N	\N	2026-02-07 17:40:45.0533+03	t	\N
92	CREATE	User	14	\N	{"id": 14, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$qwkIa21h31kcXjPm96sfCe$Dbe5zeWNvsiWMM+/19oPy9WULiBYWFxBjtdSywDwO+Q=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": null, "date_joined": "2026-02-07T14:41:03.954587+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 17:41:05.602494+03	t	\N
93	CREATE	StudentProfile	14	\N	{"phone": "", "course": 3, "address": "", "user_id": 14, "birth_date": null, "patronymic": "Иванович", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	2026-02-07 17:41:05.628444+03	t	\N
94	DELETE	StudentProfile	14	{"phone": "", "course": 3, "address": "", "user_id": 14, "birth_date": null, "patronymic": "Иванович", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	\N	2026-02-07 18:14:27.143967+03	t	\N
95	DELETE	User	14	{"id": 14, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$qwkIa21h31kcXjPm96sfCe$Dbe5zeWNvsiWMM+/19oPy9WULiBYWFxBjtdSywDwO+Q=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": null, "date_joined": "2026-02-07T14:41:03.954587+00:00", "is_superuser": false}	\N	\N	\N	\N	\N	2026-02-07 18:14:27.143967+03	t	\N
96	CREATE	User	15	\N	{"id": 15, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$HWAAwuiEzt5BSShSpL7kpr$TFWvVk/c3/2eI1drkgl7RfG4kgOopwRBJ71mNqwgNdI=", "username": "ddd", "is_active": true, "last_name": "школьниковро", "first_name": "trainer@mail.ru", "last_login": null, "date_joined": "2026-02-07T15:14:47.843729+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 18:14:48.488215+03	t	\N
97	CREATE	StudentProfile	15	\N	{"phone": "", "course": 3, "address": "", "user_id": 15, "birth_date": null, "patronymic": "Иванович", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	2026-02-07 18:14:48.496537+03	t	\N
98	DELETE	StudentProfile	15	{"phone": "", "course": 3, "address": "", "user_id": 15, "birth_date": null, "patronymic": "Иванович", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	\N	2026-02-07 18:18:53.857211+03	t	\N
99	DELETE	User	15	{"id": 15, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$HWAAwuiEzt5BSShSpL7kpr$TFWvVk/c3/2eI1drkgl7RfG4kgOopwRBJ71mNqwgNdI=", "username": "ddd", "is_active": true, "last_name": "школьниковро", "first_name": "trainer@mail.ru", "last_login": null, "date_joined": "2026-02-07T15:14:47.843729+00:00", "is_superuser": false}	\N	\N	\N	\N	\N	2026-02-07 18:18:53.857211+03	t	\N
100	CREATE	User	16	\N	{"id": 16, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$345z5qa8fou7mOgqz0FwcV$RuBvN2hsIDO6W1bkAGNB1A6o8BDTchsQ3gvn/D5HUKQ=", "username": "ddd", "is_active": true, "last_name": "шко", "first_name": "men@mail.ru", "last_login": null, "date_joined": "2026-02-07T15:19:13.392691+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 18:19:14.046736+03	t	\N
101	CREATE	StudentProfile	16	\N	{"phone": "", "course": 2, "address": "", "user_id": 16, "birth_date": null, "patronymic": "Иванович", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	2026-02-07 18:19:14.062051+03	t	\N
102	DELETE	StudentProfile	16	{"phone": "", "course": 2, "address": "", "user_id": 16, "birth_date": null, "patronymic": "Иванович", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	\N	2026-02-07 18:20:28.651843+03	t	\N
103	DELETE	User	16	{"id": 16, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$345z5qa8fou7mOgqz0FwcV$RuBvN2hsIDO6W1bkAGNB1A6o8BDTchsQ3gvn/D5HUKQ=", "username": "ddd", "is_active": true, "last_name": "шко", "first_name": "men@mail.ru", "last_login": null, "date_joined": "2026-02-07T15:19:13.392691+00:00", "is_superuser": false}	\N	\N	\N	\N	\N	2026-02-07 18:20:28.651843+03	t	\N
104	CREATE	User	17	\N	{"id": 17, "email": "skolnikovaksenia64@gmail.com", "is_staff": false, "password": "pbkdf2_sha256$1200000$GJ8P5StGrBuYk73U1VrdcY$DGtLxR5B6ACv92D0KVCVYnJZHXEs+q97CSs2I91W1fE=", "username": "skolnikovaksenia64@gmail.com", "is_active": true, "last_name": "шко", "first_name": "men@mail.ru", "last_login": null, "date_joined": "2026-02-07T15:20:52.237471+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 18:20:52.87815+03	t	\N
105	CREATE	StudentProfile	17	\N	{"phone": "", "course": 2, "address": "", "user_id": 17, "birth_date": null, "patronymic": "Иванович", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	2026-02-07 18:20:52.886864+03	t	\N
106	CREATE	User	18	\N	{"id": 18, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$yk7YKrXyslCS2f3IHem4ga$xkTpTjWjPplqF86um2C0/+wqofezK/mpFSoHDoaWVmY=", "username": "ddd", "is_active": true, "last_name": "школьников", "first_name": "men@mail.ru", "last_login": null, "date_joined": "2026-02-07T15:23:59.283882+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 18:23:59.922795+03	t	\N
107	CREATE	StudentProfile	18	\N	{"phone": "", "course": 1, "address": "", "user_id": 18, "birth_date": null, "patronymic": "Васильевна", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	2026-02-07 18:23:59.931666+03	t	\N
108	DELETE	StudentProfile	18	{"phone": "", "course": 1, "address": "", "user_id": 18, "birth_date": null, "patronymic": "Васильевна", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	\N	2026-02-07 18:26:49.225321+03	t	\N
109	DELETE	User	18	{"id": 18, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$yk7YKrXyslCS2f3IHem4ga$xkTpTjWjPplqF86um2C0/+wqofezK/mpFSoHDoaWVmY=", "username": "ddd", "is_active": true, "last_name": "школьников", "first_name": "men@mail.ru", "last_login": null, "date_joined": "2026-02-07T15:23:59.283882+00:00", "is_superuser": false}	\N	\N	\N	\N	\N	2026-02-07 18:26:49.225321+03	t	\N
110	CREATE	User	19	\N	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$jASc9dv7R34t2GLdRvWk9a$TSW9G3vNXkU7kmmQjdnJoYpQzYTNIu5+xKXGXrnfZrs=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": null, "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 18:27:05.521065+03	t	\N
111	CREATE	StudentProfile	19	\N	{"phone": "", "course": 3, "address": "", "user_id": 19, "birth_date": null, "patronymic": "Иванович", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	2026-02-07 18:27:05.531819+03	t	\N
112	UPDATE	User	19	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$jASc9dv7R34t2GLdRvWk9a$TSW9G3vNXkU7kmmQjdnJoYpQzYTNIu5+xKXGXrnfZrs=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": null, "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$jASc9dv7R34t2GLdRvWk9a$TSW9G3vNXkU7kmmQjdnJoYpQzYTNIu5+xKXGXrnfZrs=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": "2026-02-07T15:27:58.9434+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 18:27:58.943762+03	t	\N
113	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T13:47:46.018435+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T15:31:50.322491+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 18:31:50.322867+03	t	\N
114	UPDATE	StudentGroup	6	{"id": 6, "name": "аув", "year": 1, "curator_id": 4}	{"id": 6, "name": "аув", "year": 1, "curator_id": 6}	\N	\N	\N	\N	2026-02-07 18:32:30.095414+03	t	\N
115	UPDATE	StudentProfile	17	{"phone": "", "course": 2, "address": "", "user_id": 17, "birth_date": null, "patronymic": "Иванович", "profile_image": "", "student_group_id": null}	{"phone": "", "course": 2, "address": "", "user_id": 17, "birth_date": null, "patronymic": "Иванович", "profile_image": "", "student_group_id": 4}	\N	\N	\N	\N	2026-02-07 18:32:40.122449+03	t	\N
116	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T14:31:41.952706+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T15:39:16.002515+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-07 18:39:16.002928+03	t	\N
117	DELETE	StudentProfile	17	{"phone": "", "course": 2, "address": "", "user_id": 17, "birth_date": null, "patronymic": "Иванович", "profile_image": "", "student_group_id": 4}	\N	\N	\N	\N	\N	2026-02-07 18:39:26.139931+03	t	\N
118	DELETE	User	17	{"id": 17, "email": "skolnikovaksenia64@gmail.com", "is_staff": false, "password": "pbkdf2_sha256$1200000$GJ8P5StGrBuYk73U1VrdcY$DGtLxR5B6ACv92D0KVCVYnJZHXEs+q97CSs2I91W1fE=", "username": "skolnikovaksenia64@gmail.com", "is_active": true, "last_name": "шко", "first_name": "men@mail.ru", "last_login": null, "date_joined": "2026-02-07T15:20:52.237471+00:00", "is_superuser": false}	\N	\N	\N	\N	\N	2026-02-07 18:39:26.139931+03	t	\N
119	CREATE	User	20	\N	{"id": 20, "email": "skolnikovaksenia64@gmail.com", "is_staff": false, "password": "pbkdf2_sha256$1200000$Pqp3Fms4tSlo0F5990xcSp$Y3/RioPyaiP0F1WNz9zFQDqimET2nvAZ68NQj7jCoiw=", "username": "me", "is_active": true, "last_name": "школьников", "first_name": "Иван", "last_login": null, "date_joined": "2026-02-07T15:40:19.614585+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 18:40:20.267027+03	t	\N
120	CREATE	TeacherProfile	20	\N	{"phone": "", "user_id": 20, "birth_date": null, "patronymic": "Васильевна", "profile_image": "", "qualification": ""}	\N	\N	\N	\N	2026-02-07 18:40:20.279764+03	t	\N
121	DELETE	TeacherProfile	20	{"phone": "", "user_id": 20, "birth_date": null, "patronymic": "Васильевна", "profile_image": "", "qualification": ""}	\N	\N	\N	\N	\N	2026-02-07 18:43:25.895904+03	t	\N
122	DELETE	User	20	{"id": 20, "email": "skolnikovaksenia64@gmail.com", "is_staff": false, "password": "pbkdf2_sha256$1200000$Pqp3Fms4tSlo0F5990xcSp$Y3/RioPyaiP0F1WNz9zFQDqimET2nvAZ68NQj7jCoiw=", "username": "me", "is_active": true, "last_name": "школьников", "first_name": "Иван", "last_login": null, "date_joined": "2026-02-07T15:40:19.614585+00:00", "is_superuser": false}	\N	\N	\N	\N	\N	2026-02-07 18:43:25.895904+03	t	\N
123	CREATE	User	21	\N	{"id": 21, "email": "skolnikovaksenia64@gmail.com", "is_staff": false, "password": "pbkdf2_sha256$1200000$dsGGL6oebxeJgDpkwxKBRS$K05nHVvmu+8eIUR8tIt9UkDlGBIfUxQqoRnKpSU+Y9Q=", "username": "m", "is_active": true, "last_name": "шко", "first_name": "trainer@mail.ru", "last_login": null, "date_joined": "2026-02-07T15:43:48.697553+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 18:43:49.338626+03	t	\N
124	CREATE	TeacherProfile	21	\N	{"phone": "", "user_id": 21, "birth_date": null, "patronymic": "Васильевна", "profile_image": "", "qualification": ""}	\N	\N	\N	\N	2026-02-07 18:43:49.349087+03	t	\N
125	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T15:39:16.002515+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T17:41:33.849935+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-07 20:41:33.85038+03	t	\N
126	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T15:31:50.322491+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T15:31:50+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 20:42:20.123833+03	t	\N
127	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T15:31:50+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T17:42:28.472571+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 20:42:28.473151+03	t	\N
128	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T17:41:33.849935+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T17:42:46.322479+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-07 20:42:46.323004+03	t	\N
129	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T17:42:28.472571+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T17:42:28+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 20:42:51.976347+03	t	\N
130	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T17:42:28+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T17:43:00.75893+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-07 20:43:00.759562+03	t	\N
131	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T17:43:00.75893+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T12:43:19.934076+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 15:43:19.935113+03	t	\N
132	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-03T13:18:53.669631+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-08T12:43:29.969843+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 15:43:29.971132+03	t	\N
133	UPDATE	User	19	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$jASc9dv7R34t2GLdRvWk9a$TSW9G3vNXkU7kmmQjdnJoYpQzYTNIu5+xKXGXrnfZrs=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": "2026-02-07T15:27:58.9434+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$jASc9dv7R34t2GLdRvWk9a$TSW9G3vNXkU7kmmQjdnJoYpQzYTNIu5+xKXGXrnfZrs=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": "2026-02-08T12:47:56.466448+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 15:47:56.467106+03	t	\N
134	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-07T17:42:46.322479+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T12:48:05.493687+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-08 15:48:05.494122+03	t	\N
135	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T12:43:19.934076+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T12:48:14.521644+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 15:48:14.522157+03	t	\N
136	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-08T12:43:29.969843+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-08T12:52:09.265868+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 15:52:09.266769+03	t	\N
191	UPDATE	User	9	{"id": 9, "email": "mail@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$yj9WZmt5URkWZKR1UA7SK4$o42RubUl6rqHGfZYlV161fctzlBt7p6hpuKXhAVM1r8=", "username": "ad@mail.ru", "is_active": true, "last_name": "cc", "first_name": "cc", "last_login": null, "date_joined": "2026-01-31T15:36:23.199562+00:00", "is_superuser": false}	{"id": 9, "email": "mail@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$yj9WZmt5URkWZKR1UA7SK4$o42RubUl6rqHGfZYlV161fctzlBt7p6hpuKXhAVM1r8=", "username": "ad@mail.ru", "is_active": false, "last_name": "cc", "first_name": "cc", "last_login": null, "date_joined": "2026-01-31T15:36:23.199562+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-13 15:52:33.345185+03	t	\N
137	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T12:48:14.521644+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T12:58:41.372681+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 15:58:41.373986+03	t	\N
138	CREATE	DailySchedule	9	\N	{"id": 9, "week_day": "TUE", "is_active": true, "is_weekend": false, "student_group_id": 6}	\N	\N	\N	\N	2026-02-08 15:59:43.597353+03	t	\N
139	CREATE	ScheduleLesson	18	\N	{"id": 18, "subject_id": 1, "teacher_id": 4, "lesson_number": 3, "daily_schedule_id": 9}	\N	\N	\N	\N	2026-02-08 15:59:43.617464+03	t	\N
140	CREATE	DailySchedule	10	\N	{"id": 10, "week_day": "WED", "is_active": true, "is_weekend": false, "student_group_id": 6}	\N	\N	\N	\N	2026-02-08 15:59:45.973393+03	t	\N
141	UPDATE	DailySchedule	10	{"id": 10, "week_day": "WED", "is_active": true, "is_weekend": false, "student_group_id": 6}	{"id": 10, "week_day": "WED", "is_active": true, "is_weekend": true, "student_group_id": 6}	\N	\N	\N	\N	2026-02-08 15:59:45.982067+03	t	\N
142	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T12:48:05.493687+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T13:20:58.926277+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-08 16:20:58.926996+03	t	\N
143	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T12:58:41.372681+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T13:22:05.771747+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 16:22:05.772441+03	t	\N
144	UPDATE	User	19	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$jASc9dv7R34t2GLdRvWk9a$TSW9G3vNXkU7kmmQjdnJoYpQzYTNIu5+xKXGXrnfZrs=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": "2026-02-08T12:47:56.466448+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$jASc9dv7R34t2GLdRvWk9a$TSW9G3vNXkU7kmmQjdnJoYpQzYTNIu5+xKXGXrnfZrs=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": "2026-02-08T13:22:36.349346+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 16:22:36.349903+03	t	\N
145	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-08T12:52:09.265868+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-08T13:22:45.738121+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 16:22:45.738871+03	t	\N
146	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T13:20:58.926277+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T13:22:59.356825+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-08 16:22:59.357598+03	t	\N
147	CREATE	User	22	\N	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": null, "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 16:23:35.873696+03	t	\N
148	CREATE	TeacherProfile	22	\N	{"phone": "", "user_id": 22, "birth_date": null, "patronymic": "h", "profile_image": "", "qualification": ""}	\N	\N	\N	\N	2026-02-08 16:23:35.891428+03	t	\N
149	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": null, "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-08T13:23:48.761928+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 16:23:48.762562+03	t	\N
192	UPDATE	User	9	{"id": 9, "email": "mail@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$yj9WZmt5URkWZKR1UA7SK4$o42RubUl6rqHGfZYlV161fctzlBt7p6hpuKXhAVM1r8=", "username": "ad@mail.ru", "is_active": false, "last_name": "cc", "first_name": "cc", "last_login": null, "date_joined": "2026-01-31T15:36:23.199562+00:00", "is_superuser": false}	{"id": 9, "email": "mail@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$yj9WZmt5URkWZKR1UA7SK4$o42RubUl6rqHGfZYlV161fctzlBt7p6hpuKXhAVM1r8=", "username": "ad@mail.ru", "is_active": true, "last_name": "cc", "first_name": "cc", "last_login": null, "date_joined": "2026-01-31T15:36:23.199562+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-13 15:52:36.045006+03	t	\N
150	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T13:22:59.356825+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T13:24:31.124127+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-08 16:24:31.12488+03	t	\N
151	UPDATE	StudentGroup	4	{"id": 4, "name": "п50-422", "year": 2, "curator_id": 6}	{"id": 4, "name": "п50-422", "year": 2, "curator_id": 22}	\N	\N	\N	\N	2026-02-08 16:24:43.417194+03	t	\N
152	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-08T13:23:48.761928+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-08T13:24:51.912448+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 16:24:51.913244+03	t	\N
153	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T13:24:31.124127+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T13:25:12.562015+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-08 16:25:12.562932+03	t	\N
154	CREATE	Subject	6	\N	{"id": 6, "name": "Литература", "description": "люблю"}	\N	\N	\N	\N	2026-02-08 16:25:25.617082+03	t	\N
155	CREATE	TeacherSubject	5	\N	{"id": 5, "subject_id": 6, "teacher_id": 22}	\N	\N	\N	\N	2026-02-08 16:25:56.942585+03	t	\N
156	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T13:22:05.771747+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T13:26:09.72379+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 16:26:09.724242+03	t	\N
157	CREATE	ScheduleLesson	19	\N	{"id": 19, "subject_id": 6, "teacher_id": 22, "lesson_number": 1, "daily_schedule_id": 3}	\N	\N	\N	\N	2026-02-08 16:26:23.4718+03	t	\N
158	CREATE	ScheduleLesson	20	\N	{"id": 20, "subject_id": 6, "teacher_id": 22, "lesson_number": 3, "daily_schedule_id": 6}	\N	\N	\N	\N	2026-02-08 16:26:30.642162+03	t	\N
159	CREATE	ScheduleLesson	21	\N	{"id": 21, "subject_id": 6, "teacher_id": 22, "lesson_number": 5, "daily_schedule_id": 7}	\N	\N	\N	\N	2026-02-08 16:26:37.252621+03	t	\N
160	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-08T13:24:51.912448+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-08T13:26:46.13494+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 16:26:46.135879+03	t	\N
161	CREATE	Attendance	17	\N	{"id": 17, "date": "2026-02-07", "status": "L", "student_id": 5, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-02-08 16:26:59.039344+03	t	\N
162	CREATE	Attendance	18	\N	{"id": 18, "date": "2026-02-07", "status": "P", "student_id": 10, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-02-08 16:26:59.976003+03	t	\N
163	CREATE	Homework	5	\N	{"id": 5, "title": "лллл", "due_date": "2026-02-15T20:59:00+00:00", "attachment": "", "created_at": "2026-02-08T13:27:25.658099+00:00", "description": "мпритоль", "student_group_id": 4, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-08 16:27:25.658797+03	t	\N
164	UPDATE	Homework	5	{"id": 5, "title": "лллл", "due_date": "2026-02-15T20:59:00+00:00", "attachment": "", "created_at": "2026-02-08T13:27:25.658099+00:00", "description": "мпритоль", "student_group_id": 4, "schedule_lesson_id": 19}	{"id": 5, "title": "лллл", "due_date": "2026-02-15T20:59:00+00:00", "attachment": "homework_attachments/Снимок_экрана_2025-10-29_200322.png", "created_at": "2026-02-08T13:27:25.658099+00:00", "description": "мпритоль", "student_group_id": 4, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-08 16:27:25.674505+03	t	\N
165	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-08T13:22:45.738121+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-08T13:27:44.010953+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 16:27:44.011548+03	t	\N
258	DELETE	HomeworkSubmission	4	{"id": 4, "student_id": 5, "homework_id": 4, "submitted_at": "2026-02-17T12:52:51.567201+00:00", "submission_file": "homework_submissions/Структурная_схеам.drawio.png", "submission_text": "про"}	\N	\N	\N	\N	\N	2026-02-19 20:48:21.277685+03	t	\N
166	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-08T13:26:46.13494+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-08T13:27:56.676201+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 16:27:56.67703+03	t	\N
167	UPDATE	Homework	5	{"id": 5, "title": "лллл", "due_date": "2026-02-15T20:59:00+00:00", "attachment": "homework_attachments/Снимок_экрана_2025-10-29_200322.png", "created_at": "2026-02-08T13:27:25.658099+00:00", "description": "мпритоль", "student_group_id": 4, "schedule_lesson_id": 19}	{"id": 5, "title": "лллл", "due_date": "2026-02-15T20:59:00+00:00", "attachment": "homework_attachments/Снимок_экрана_2025-10-29_200322_t5a6Mn7.png", "created_at": "2026-02-08T13:27:25.658099+00:00", "description": "мпритоль", "student_group_id": 4, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-08 16:32:01.562856+03	t	\N
168	UPDATE	Homework	5	{"id": 5, "title": "лллл", "due_date": "2026-02-15T20:59:00+00:00", "attachment": "homework_attachments/Снимок_экрана_2025-10-29_200322_t5a6Mn7.png", "created_at": "2026-02-08T13:27:25.658099+00:00", "description": "мпритоль", "student_group_id": 4, "schedule_lesson_id": 19}	{"id": 5, "title": "лллл", "due_date": "2026-02-15T20:59:00+00:00", "attachment": "homework_attachments/cat1.jpg", "created_at": "2026-02-08T13:27:25.658099+00:00", "description": "мпритоль", "student_group_id": 4, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-08 16:32:24.086421+03	t	\N
169	UPDATE	Homework	5	{"id": 5, "title": "лллл", "due_date": "2026-02-15T20:59:00+00:00", "attachment": "homework_attachments/cat1.jpg", "created_at": "2026-02-08T13:27:25.658099+00:00", "description": "мпритоль", "student_group_id": 4, "schedule_lesson_id": 19}	{"id": 5, "title": "лллл", "due_date": "2026-02-15T20:59:00+00:00", "attachment": "homework_attachments/cat1.jpg", "created_at": "2026-02-08T13:27:25.658099+00:00", "description": "мпритоль", "student_group_id": 4, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-08 16:33:07.854543+03	t	\N
170	UPDATE	Homework	5	{"id": 5, "title": "лллл", "due_date": "2026-02-15T20:59:00+00:00", "attachment": "homework_attachments/cat1.jpg", "created_at": "2026-02-08T13:27:25.658099+00:00", "description": "мпритоль", "student_group_id": 4, "schedule_lesson_id": 19}	{"id": 5, "title": "лллл", "due_date": "2026-02-15T20:59:00+00:00", "attachment": "homework_attachments/План.docx", "created_at": "2026-02-08T13:27:25.658099+00:00", "description": "мпритоль", "student_group_id": 4, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-08 16:33:39.790919+03	t	\N
171	UPDATE	Homework	5	{"id": 5, "title": "лллл", "due_date": "2026-02-15T20:59:00+00:00", "attachment": "homework_attachments/План.docx", "created_at": "2026-02-08T13:27:25.658099+00:00", "description": "мпритоль", "student_group_id": 4, "schedule_lesson_id": 19}	{"id": 5, "title": "лллл", "due_date": "2026-02-15T20:59:00+00:00", "attachment": "homework_attachments/План.docx", "created_at": "2026-02-08T13:27:25.658099+00:00", "description": "мпритоль", "student_group_id": 4, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-08 16:33:59.046036+03	t	\N
172	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-08T13:27:44.010953+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-08T13:34:10.495462+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 16:34:10.496128+03	t	\N
173	CREATE	HomeworkSubmission	2	\N	{"id": 2, "student_id": 5, "homework_id": 5, "submitted_at": "2026-02-08T14:15:24.277978+00:00", "submission_file": "", "submission_text": "нпеаквуы"}	\N	\N	\N	\N	2026-02-08 17:15:24.278096+03	t	\N
174	UPDATE	HomeworkSubmission	2	{"id": 2, "student_id": 5, "homework_id": 5, "submitted_at": "2026-02-08T14:15:24.277978+00:00", "submission_file": "", "submission_text": "нпеаквуы"}	{"id": 2, "student_id": 5, "homework_id": 5, "submitted_at": "2026-02-08T14:15:24.277978+00:00", "submission_file": "homework_submissions/тз.docx", "submission_text": "нпеаквуы"}	\N	\N	\N	\N	2026-02-08 17:15:24.309337+03	t	\N
175	UPDATE	HomeworkSubmission	2	{"id": 2, "student_id": 5, "homework_id": 5, "submitted_at": "2026-02-08T14:15:24.277978+00:00", "submission_file": "homework_submissions/тз.docx", "submission_text": "нпеаквуы"}	{"id": 2, "student_id": 5, "homework_id": 5, "submitted_at": "2026-02-08T14:19:44.606104+00:00", "submission_file": "homework_submissions/тз_mlHzwCl.docx", "submission_text": "нпеаквуы"}	\N	\N	\N	\N	2026-02-08 17:19:44.610224+03	t	\N
176	UPDATE	HomeworkSubmission	2	{"id": 2, "student_id": 5, "homework_id": 5, "submitted_at": "2026-02-08T14:19:44.606104+00:00", "submission_file": "homework_submissions/тз_mlHzwCl.docx", "submission_text": "нпеаквуы"}	{"id": 2, "student_id": 5, "homework_id": 5, "submitted_at": "2026-02-08T14:19:49.635651+00:00", "submission_file": "homework_submissions/тз_OlHinBQ.docx", "submission_text": "нпеаквуы"}	\N	\N	\N	\N	2026-02-08 17:19:49.637074+03	t	\N
177	UPDATE	HomeworkSubmission	2	{"id": 2, "student_id": 5, "homework_id": 5, "submitted_at": "2026-02-08T14:19:49.635651+00:00", "submission_file": "homework_submissions/тз_OlHinBQ.docx", "submission_text": "нпеаквуы"}	{"id": 2, "student_id": 5, "homework_id": 5, "submitted_at": "2026-02-08T14:20:39.843368+00:00", "submission_file": "homework_submissions/тз_mvgw6Wg.docx", "submission_text": "нпеаквуы"}	\N	\N	\N	\N	2026-02-08 17:20:39.845539+03	t	\N
178	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-08T13:27:56.676201+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-08T14:21:02.417793+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-08 17:21:02.418195+03	t	\N
179	CREATE	Grade	6	\N	{"id": 6, "date": "2026-02-08", "value": 5.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-08 17:31:32.942944+03	t	\N
180	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-08T14:21:02.417793+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-13T12:37:10.178237+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-13 15:37:10.178681+03	t	\N
181	CREATE	Homework	6	\N	{"id": 6, "title": "cds", "due_date": "2026-02-20T20:59:00+00:00", "attachment": "", "created_at": "2026-02-13T12:37:33.096574+00:00", "description": "ds", "student_group_id": 4, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-02-13 15:37:33.097294+03	t	\N
182	UPDATE	Homework	6	{"id": 6, "title": "cds", "due_date": "2026-02-20T20:59:00+00:00", "attachment": "", "created_at": "2026-02-13T12:37:33.096574+00:00", "description": "ds", "student_group_id": 4, "schedule_lesson_id": 21}	{"id": 6, "title": "cds", "due_date": "2026-02-20T20:59:00+00:00", "attachment": "homework_attachments/тз.docx", "created_at": "2026-02-13T12:37:33.096574+00:00", "description": "ds", "student_group_id": 4, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-02-13 15:37:33.111091+03	t	\N
183	CREATE	Grade	7	\N	{"id": 7, "date": "2026-02-13", "value": 4.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-13 15:39:50.604687+03	t	\N
184	UPDATE	Grade	7	{"id": 7, "date": "2026-02-13", "value": 4.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 19}	{"id": 7, "date": "2026-02-13", "value": 3.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-13 15:39:55.425971+03	t	\N
185	UPDATE	Grade	7	{"id": 7, "date": "2026-02-13", "value": 3.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 19}	{"id": 7, "date": "2026-02-13", "value": 4.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-13 15:41:14.77091+03	t	\N
186	UPDATE	Grade	7	{"id": 7, "date": "2026-02-13", "value": 4.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 19}	{"id": 7, "date": "2026-02-13", "value": 2.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-13 15:41:25.538989+03	t	\N
187	UPDATE	Grade	7	{"id": 7, "date": "2026-02-13", "value": 2.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 19}	{"id": 7, "date": "2026-02-13", "value": 3.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-13 15:45:32.109072+03	t	\N
188	UPDATE	Grade	7	{"id": 7, "date": "2026-02-13", "value": 3.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 19}	{"id": 7, "date": "2026-02-13", "value": 4.0, "comment": "ыф", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-13 15:45:42.419057+03	t	\N
189	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T13:25:12.562015+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-13T12:46:01.313854+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-13 15:46:01.31441+03	t	\N
190	UPDATE	User	9	{"id": 9, "email": "mail@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$yj9WZmt5URkWZKR1UA7SK4$o42RubUl6rqHGfZYlV161fctzlBt7p6hpuKXhAVM1r8=", "username": "ad@mail.ru", "is_active": true, "last_name": "cc", "first_name": "cc", "last_login": null, "date_joined": "2026-01-31T15:36:23.199562+00:00", "is_superuser": false}	{"id": 9, "email": "mail@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$yj9WZmt5URkWZKR1UA7SK4$o42RubUl6rqHGfZYlV161fctzlBt7p6hpuKXhAVM1r8=", "username": "ad@mail.ru", "is_active": true, "last_name": "cc", "first_name": "cc", "last_login": null, "date_joined": "2026-01-31T15:36:23.199562+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-13 15:52:29.493834+03	t	\N
193	CREATE	User	23	\N	{"id": 23, "email": "www@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$T70WNNdUwFb1TrTQZqwhx3$gFNYbqRTQ5LDkJB3pY4rwNXMARbzHyyKhkSO405nFFU=", "username": "rfheb_enjj", "is_active": true, "last_name": "кнг6нек", "first_name": "грнепка", "last_login": null, "date_joined": "2026-02-13T13:51:39.294237+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-13 16:51:39.941713+03	t	\N
194	CREATE	StudentProfile	23	\N	{"phone": "", "course": 2, "address": "", "user_id": 23, "birth_date": null, "patronymic": "рнпекау", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	2026-02-13 16:51:39.997212+03	t	\N
195	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-08T13:26:09.72379+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-13T14:30:38.518324+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-13 17:30:38.519426+03	t	\N
196	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-13T12:46:01.313854+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-13T14:32:37.933924+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-13 17:32:37.934403+03	t	\N
197	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-13T14:30:38.518324+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-13T14:33:50.5236+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-13 17:33:50.523978+03	t	\N
198	UPDATE	User	19	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$jASc9dv7R34t2GLdRvWk9a$TSW9G3vNXkU7kmmQjdnJoYpQzYTNIu5+xKXGXrnfZrs=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": "2026-02-08T13:22:36.349346+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$jASc9dv7R34t2GLdRvWk9a$TSW9G3vNXkU7kmmQjdnJoYpQzYTNIu5+xKXGXrnfZrs=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": "2026-02-13T15:03:42.337834+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-13 18:03:42.339463+03	t	\N
199	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-08T13:34:10.495462+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-13T15:04:06.886208+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-13 18:04:06.886717+03	t	\N
200	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-13T12:37:10.178237+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-13T15:50:07.978936+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-13 18:50:07.979403+03	t	\N
201	CREATE	Attendance	19	\N	{"id": 19, "date": "2026-02-12", "status": "P", "student_id": 5, "schedule_lesson_id": 20}	\N	\N	\N	\N	2026-02-13 18:51:57.263213+03	t	\N
202	CREATE	Attendance	20	\N	{"id": 20, "date": "2026-02-12", "status": "L", "student_id": 10, "schedule_lesson_id": 20}	\N	\N	\N	\N	2026-02-13 18:51:58.186747+03	t	\N
203	UPDATE	Attendance	20	{"id": 20, "date": "2026-02-12", "status": "L", "student_id": 10, "schedule_lesson_id": 20}	{"id": 20, "date": "2026-02-12", "status": "A", "student_id": 10, "schedule_lesson_id": 20}	\N	\N	\N	\N	2026-02-13 18:51:58.880132+03	t	\N
204	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-13T14:33:50.5236+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-13T16:07:59.896307+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-13 19:07:59.896907+03	t	\N
205	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-13T14:32:37.933924+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-13T16:14:48.715649+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-13 19:14:48.716002+03	t	\N
206	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-13T16:07:59.896307+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-15T14:00:45.93487+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-15 17:00:45.935307+03	t	\N
207	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-13T15:04:06.886208+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-15T14:01:14.045786+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-15 17:01:14.046078+03	t	\N
208	CREATE	HomeworkSubmission	3	\N	{"id": 3, "student_id": 5, "homework_id": 6, "submitted_at": "2026-02-16T11:12:13.37657+00:00", "submission_file": "", "submission_text": " bnj"}	\N	\N	\N	\N	2026-02-16 14:12:13.37721+03	t	\N
209	UPDATE	HomeworkSubmission	3	{"id": 3, "student_id": 5, "homework_id": 6, "submitted_at": "2026-02-16T11:12:13.37657+00:00", "submission_file": "", "submission_text": " bnj"}	{"id": 3, "student_id": 5, "homework_id": 6, "submitted_at": "2026-02-16T11:12:13.37657+00:00", "submission_file": "homework_submissions/school_grades_report_20260213_1803.pdf", "submission_text": " bnj"}	\N	\N	\N	\N	2026-02-16 14:12:13.555697+03	t	\N
210	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-15T14:00:45.93487+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T08:54:38.597339+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 11:54:38.597794+03	t	\N
211	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-15T14:01:14.045786+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-17T09:09:28.523205+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 12:09:28.523701+03	t	\N
212	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-13T15:50:07.978936+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-17T09:17:49.348078+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 12:17:49.348468+03	t	\N
213	CREATE	Grade	8	\N	{"id": 8, "date": "2026-02-17", "value": 2.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-02-17 12:22:44.215419+03	t	\N
214	CREATE	Grade	9	\N	{"id": 9, "date": "2026-02-17", "value": 4.0, "comment": "акувц", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-02-17 12:22:47.753165+03	t	\N
215	CREATE	Grade	10	\N	{"id": 10, "date": "2026-02-17", "value": 5.0, "comment": "", "grade_type": "HW", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-02-17 12:23:04.216016+03	t	\N
216	CREATE	Announcement	5	\N	{"id": 5, "title": "ы", "content": "ч", "author_id": 22, "created_at": "2026-02-17T09:35:59.847608+00:00", "is_for_all": true, "student_group_id": null}	\N	\N	\N	\N	2026-02-17 12:35:59.847859+03	t	\N
217	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-13T16:14:48.715649+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T09:43:42.974628+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-17 12:43:42.97501+03	t	\N
218	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T08:54:38.597339+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T10:04:47.992768+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 13:04:47.993296+03	t	\N
219	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-17T09:09:28.523205+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-17T10:23:51.804314+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 13:23:51.80481+03	t	\N
220	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T10:04:47.992768+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T10:50:08.397337+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 13:50:08.40104+03	t	\N
221	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-17T09:17:49.348078+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-17T10:51:26.612331+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 13:51:26.614701+03	t	\N
222	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T09:43:42.974628+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T11:50:16.109124+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-17 14:50:16.110345+03	t	\N
223	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-17T10:23:51.804314+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-17T12:12:30.282756+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 15:12:30.283396+03	t	\N
224	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-17T12:12:30.282756+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-17T12:52:15.194389+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 15:52:15.194912+03	t	\N
225	CREATE	HomeworkSubmission	4	\N	{"id": 4, "student_id": 5, "homework_id": 4, "submitted_at": "2026-02-17T12:52:51.567201+00:00", "submission_file": "", "submission_text": "про"}	\N	\N	\N	\N	2026-02-17 15:52:51.56789+03	t	\N
226	UPDATE	HomeworkSubmission	4	{"id": 4, "student_id": 5, "homework_id": 4, "submitted_at": "2026-02-17T12:52:51.567201+00:00", "submission_file": "", "submission_text": "про"}	{"id": 4, "student_id": 5, "homework_id": 4, "submitted_at": "2026-02-17T12:52:51.567201+00:00", "submission_file": "homework_submissions/Структурная_схеам.drawio.png", "submission_text": "про"}	\N	\N	\N	\N	2026-02-17 15:52:51.582338+03	t	\N
227	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-17T10:51:26.612331+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-17T12:53:29.93823+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 15:53:29.938553+03	t	\N
228	CREATE	Attendance	21	\N	{"id": 21, "date": "2026-02-14", "status": "P", "student_id": 5, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-02-17 15:53:55.336341+03	t	\N
229	CREATE	Attendance	22	\N	{"id": 22, "date": "2026-02-14", "status": "L", "student_id": 10, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-02-17 15:53:56.768664+03	t	\N
230	UPDATE	Announcement	5	{"id": 5, "title": "ы", "content": "ч", "author_id": 22, "created_at": "2026-02-17T09:35:59.847608+00:00", "is_for_all": true, "student_group_id": null}	{"id": 5, "title": "ghbdtn", "content": "ч", "author_id": 22, "created_at": "2026-02-17T09:35:59.847608+00:00", "is_for_all": false, "student_group_id": 4}	\N	\N	\N	\N	2026-02-17 15:54:29.779834+03	t	\N
231	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T10:50:08.397337+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T12:54:52.667481+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 15:54:52.66799+03	t	\N
232	CREATE	ScheduleLesson	22	\N	{"id": 22, "subject_id": 1, "teacher_id": 4, "lesson_number": 2, "daily_schedule_id": 6}	\N	\N	\N	\N	2026-02-17 15:55:25.344897+03	t	\N
233	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-17T12:53:29.93823+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-17T12:55:36.609898+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 15:55:36.610496+03	t	\N
234	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T12:54:52.667481+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T12:56:06.123752+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 15:56:06.124297+03	t	\N
235	CREATE	ScheduleLesson	23	\N	{"id": 23, "subject_id": 6, "teacher_id": 22, "lesson_number": 3, "daily_schedule_id": 2}	\N	\N	\N	\N	2026-02-17 15:56:21.968228+03	t	\N
236	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T11:50:16.109124+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T12:56:32.080477+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-17 15:56:32.080934+03	t	\N
237	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-17T12:52:15.194389+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-17T13:15:14.863898+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 16:15:14.864521+03	t	\N
238	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-17T12:55:36.609898+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-17T13:15:24.294617+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 16:15:24.295173+03	t	\N
239	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-17T13:15:24.294617+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-17T13:17:50.106199+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 16:17:50.107602+03	t	\N
240	UPDATE	Announcement	5	{"id": 5, "title": "ghbdtn", "content": "ч", "author_id": 22, "created_at": "2026-02-17T09:35:59.847608+00:00", "is_for_all": false, "student_group_id": 4}	{"id": 5, "title": "Важное объявление", "content": "привет", "author_id": 22, "created_at": "2026-02-17T09:35:59.847608+00:00", "is_for_all": false, "student_group_id": 4}	\N	\N	\N	\N	2026-02-17 16:29:11.255397+03	t	\N
241	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T12:56:06.123752+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T13:35:40.630203+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 16:35:40.63091+03	t	\N
242	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T13:35:40.630203+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T13:37:35.905363+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 16:37:35.90573+03	t	\N
243	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-17T13:15:14.863898+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-17T13:44:20.68383+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 16:44:20.684614+03	t	\N
244	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-17T13:17:50.106199+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-17T13:45:16.958508+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 16:45:16.959241+03	t	\N
245	CREATE	Attendance	23	\N	{"id": 23, "date": "2026-02-17", "status": "P", "student_id": 5, "schedule_lesson_id": 23}	\N	\N	\N	\N	2026-02-17 16:45:31.992401+03	t	\N
246	CREATE	Attendance	24	\N	{"id": 24, "date": "2026-02-17", "status": "P", "student_id": 10, "schedule_lesson_id": 23}	\N	\N	\N	\N	2026-02-17 16:45:32.648717+03	t	\N
247	CREATE	Attendance	25	\N	{"id": 25, "date": "2026-02-18", "status": "P", "student_id": 10, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-17 16:45:41.95421+03	t	\N
248	CREATE	Attendance	26	\N	{"id": 26, "date": "2026-02-18", "status": "P", "student_id": 5, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-17 16:45:42.42789+03	t	\N
249	CREATE	Attendance	27	\N	{"id": 27, "date": "2026-02-19", "status": "P", "student_id": 10, "schedule_lesson_id": 20}	\N	\N	\N	\N	2026-02-17 16:45:46.430847+03	t	\N
250	CREATE	Attendance	28	\N	{"id": 28, "date": "2026-02-19", "status": "P", "student_id": 5, "schedule_lesson_id": 20}	\N	\N	\N	\N	2026-02-17 16:45:46.903371+03	t	\N
251	UPDATE	Attendance	22	{"id": 22, "date": "2026-02-14", "status": "L", "student_id": 10, "schedule_lesson_id": 21}	{"id": 22, "date": "2026-02-14", "status": "P", "student_id": 10, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-02-17 16:45:54.587619+03	t	\N
252	UPDATE	Attendance	20	{"id": 20, "date": "2026-02-12", "status": "A", "student_id": 10, "schedule_lesson_id": 20}	{"id": 20, "date": "2026-02-12", "status": "P", "student_id": 10, "schedule_lesson_id": 20}	\N	\N	\N	\N	2026-02-17 16:46:01.043885+03	t	\N
253	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-17T13:44:20.68383+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-17T13:46:07.73856+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-17 16:46:07.739155+03	t	\N
254	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-17T13:46:07.73856+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-18T08:56:51.764522+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-18 11:56:51.765139+03	t	\N
255	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T13:37:35.905363+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-18T09:02:12.865131+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-18 12:02:12.865532+03	t	\N
256	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-17T13:45:16.958508+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-18T09:08:49.769174+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-18 12:08:49.76962+03	t	\N
257	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-18T08:56:51.764522+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-19T17:46:40.521114+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-19 20:46:40.52172+03	t	\N
259	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-17T12:56:32.080477+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-19T18:09:29.836207+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-19 21:09:29.837787+03	t	\N
260	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-19T18:09:29.836207+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-20T16:06:47.369815+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-20 19:06:47.370676+03	t	\N
261	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-18T09:02:12.865131+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-20T16:35:31.316603+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-20 19:35:31.317158+03	t	\N
262	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-18T09:08:49.769174+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-20T16:35:40.241259+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-20 19:35:40.241926+03	t	\N
263	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-19T17:46:40.521114+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-20T16:37:31.829444+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-20 19:37:31.829967+03	t	\N
264	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-20T16:35:40.241259+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-20T18:39:39.32955+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-20 21:39:39.330087+03	t	\N
265	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-20T16:37:31.829444+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-20T18:40:12.544331+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-20 21:40:12.544674+03	t	\N
266	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "ива", "first_name": "Иван", "last_login": "2026-02-20T18:40:12.544331+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-02-20T18:40:12.544331+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-20 21:56:01.211563+03	t	\N
267	UPDATE	StudentProfile	5	{"phone": "", "course": 3, "address": "", "user_id": 5, "birth_date": "2026-01-29", "patronymic": "Иванович", "profile_image": "", "student_group_id": 4}	{"phone": "", "course": 3, "address": "", "user_id": 5, "birth_date": "2026-01-29", "patronymic": "Иванович", "profile_image": "", "student_group_id": 4}	\N	\N	\N	\N	2026-02-20 21:56:01.229732+03	t	\N
268	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-20T16:06:47.369815+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-20T18:59:38.196504+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-20 21:59:38.196961+03	t	\N
269	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-20T16:35:31.316603+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T12:03:16.643732+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 15:03:16.644189+03	t	\N
270	CREATE	DailySchedule	11	\N	{"id": 11, "week_day": "THU", "is_active": true, "is_weekend": false, "student_group_id": 6}	\N	\N	\N	\N	2026-02-22 15:43:23.604272+03	t	\N
271	UPDATE	DailySchedule	11	{"id": 11, "week_day": "THU", "is_active": true, "is_weekend": false, "student_group_id": 6}	{"id": 11, "week_day": "THU", "is_active": true, "is_weekend": true, "student_group_id": 6}	\N	\N	\N	\N	2026-02-22 15:43:23.652853+03	t	\N
272	UPDATE	DailySchedule	11	{"id": 11, "week_day": "THU", "is_active": true, "is_weekend": true, "student_group_id": 6}	{"id": 11, "week_day": "THU", "is_active": true, "is_weekend": false, "student_group_id": 6}	\N	\N	\N	\N	2026-02-22 15:43:25.214534+03	t	\N
273	CREATE	ScheduleLesson	24	\N	{"id": 24, "subject_id": 6, "teacher_id": 22, "lesson_number": 2, "daily_schedule_id": 9}	\N	\N	\N	\N	2026-02-22 15:43:55.459354+03	t	\N
274	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-20T18:39:39.32955+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-22T12:44:05.771462+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 15:44:05.772128+03	t	\N
275	CREATE	Attendance	29	\N	{"id": 29, "date": "2026-02-21", "status": "P", "student_id": 5, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-02-22 16:05:52.344561+03	t	\N
276	CREATE	Attendance	30	\N	{"id": 30, "date": "2026-02-21", "status": "L", "student_id": 10, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-02-22 16:05:52.955932+03	t	\N
277	CREATE	Homework	7	\N	{"id": 7, "title": "рнепкаув", "due_date": "2026-03-01T20:59:00+00:00", "attachment": "", "created_at": "2026-02-22T13:06:18.317834+00:00", "description": "авсыч", "student_group_id": 4, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-22 16:06:18.320688+03	t	\N
278	UPDATE	Homework	7	{"id": 7, "title": "рнепкаув", "due_date": "2026-03-01T20:59:00+00:00", "attachment": "", "created_at": "2026-02-22T13:06:18.317834+00:00", "description": "авсыч", "student_group_id": 4, "schedule_lesson_id": 19}	{"id": 7, "title": "рнепкаув", "due_date": "2026-03-01T20:59:00+00:00", "attachment": "homework_attachments/school_grades_report_20260222_1507.pdf", "created_at": "2026-02-22T13:06:18.317834+00:00", "description": "авсыч", "student_group_id": 4, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-22 16:06:18.332896+03	t	\N
279	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-02-20T18:40:12.544331+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-02-22T13:08:19.558713+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 16:08:19.559201+03	t	\N
280	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-22T12:44:05.771462+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-22T13:08:34.093404+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 16:08:34.094396+03	t	\N
281	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-20T18:59:38.196504+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T13:34:52.97608+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-22 16:34:52.976749+03	t	\N
282	UPDATE	StudentProfile	9	{"phone": "", "course": 2, "address": "", "user_id": 9, "birth_date": null, "patronymic": "cc", "profile_image": "", "student_group_id": 6}	{"phone": "", "course": 2, "address": "", "user_id": 9, "birth_date": null, "patronymic": "cc", "profile_image": "", "student_group_id": null}	\N	\N	\N	\N	2026-02-22 16:35:34.796724+03	t	\N
283	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T13:34:52.97608+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T13:36:36.329585+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-22 16:36:36.330975+03	t	\N
284	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-02-22T13:08:19.558713+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-02-22T13:37:02.370275+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 16:37:02.370691+03	t	\N
285	UPDATE	User	19	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$jASc9dv7R34t2GLdRvWk9a$TSW9G3vNXkU7kmmQjdnJoYpQzYTNIu5+xKXGXrnfZrs=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": "2026-02-13T15:03:42.337834+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$3eb3hwas5wNNptsWqQIm96$o2YFVKlScvrCFKAWDHRih2tBBxtg1vqUIlBO1uBKxuQ=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": "2026-02-13T15:03:42.337834+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 16:53:28.339207+03	t	\N
286	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T13:36:36.329585+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T13:53:37.512841+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-22 16:53:37.513257+03	t	\N
287	UPDATE	User	19	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$3eb3hwas5wNNptsWqQIm96$o2YFVKlScvrCFKAWDHRih2tBBxtg1vqUIlBO1uBKxuQ=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": "2026-02-13T15:03:42.337834+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$FmhfNdpGQbbP6ZSNW5Tcny$ZdrkLNHIs85ufgl2VBE9cGEMCIT7W4gR99ggXPPk5Ws=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": "2026-02-13T15:03:42.337834+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 16:54:30.536694+03	t	\N
288	UPDATE	User	19	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$FmhfNdpGQbbP6ZSNW5Tcny$ZdrkLNHIs85ufgl2VBE9cGEMCIT7W4gR99ggXPPk5Ws=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": "2026-02-13T15:03:42.337834+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$AgllohkNyCrjpnqGuajHKF$GBTA7IjdPYvUi3YgkJ/+uvSn9eEdkqYVj1ApquH9QX8=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": "2026-02-13T15:03:42.337834+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 16:55:38.848355+03	t	\N
289	UPDATE	User	19	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$AgllohkNyCrjpnqGuajHKF$GBTA7IjdPYvUi3YgkJ/+uvSn9eEdkqYVj1ApquH9QX8=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": "2026-02-13T15:03:42.337834+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$hCubDibc5vEG3GxPHm9zU3$qtObWnScdZ4fNZouMZ5AVHaW200oN0v4LImhrhq94dw=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": "2026-02-13T15:03:42.337834+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 16:56:21.150162+03	t	\N
290	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T13:53:37.512841+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T13:56:54.949185+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-22 16:56:54.950277+03	t	\N
291	UPDATE	User	19	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$hCubDibc5vEG3GxPHm9zU3$qtObWnScdZ4fNZouMZ5AVHaW200oN0v4LImhrhq94dw=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": "2026-02-13T15:03:42.337834+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	{"id": 19, "email": "sesha_shk@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$hCubDibc5vEG3GxPHm9zU3$qtObWnScdZ4fNZouMZ5AVHaW200oN0v4LImhrhq94dw=", "username": "ddd", "is_active": true, "last_name": "ВАСИЛЬЕВ", "first_name": "trainer@mail.ru", "last_login": "2026-02-22T13:57:47.096969+00:00", "date_joined": "2026-02-07T15:27:04.882064+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 16:57:47.097482+03	t	\N
292	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T13:56:54.949185+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T14:13:43.063492+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-22 17:13:43.063963+03	t	\N
293	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T14:13:43.063492+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T15:47:42.349625+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-22 18:47:42.350015+03	t	\N
294	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T12:03:16.643732+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T16:35:58.083169+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 19:35:58.083999+03	t	\N
295	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-22T13:08:34.093404+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-22T16:39:35.327056+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 19:39:35.327487+03	t	\N
296	UPDATE	Homework	7	{"id": 7, "title": "рнепкаув", "due_date": "2026-03-01T20:59:00+00:00", "attachment": "homework_attachments/school_grades_report_20260222_1507.pdf", "created_at": "2026-02-22T13:06:18.317834+00:00", "description": "авсыч", "student_group_id": 4, "schedule_lesson_id": 19}	{"id": 7, "title": "Практ номер 3", "due_date": "2026-03-01T20:59:00+00:00", "attachment": "homework_attachments/school_grades_report_20260222_1507.pdf", "created_at": "2026-02-22T13:06:18.317834+00:00", "description": "Подготовка к контрольной работе", "student_group_id": 4, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-22 19:41:37.333774+03	t	\N
297	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-02-22T13:37:02.370275+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-02-22T16:43:44.591171+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 19:43:44.591871+03	t	\N
298	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-22T16:39:35.327056+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-22T16:45:20.90768+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 19:45:20.908149+03	t	\N
299	CREATE	Grade	14	\N	{"id": 14, "date": "2026-03-16", "value": 5.0, "comment": "", "grade_type": "TEST", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-22 19:46:39.167741+03	t	\N
300	UPDATE	Grade	14	{"id": 14, "date": "2026-03-16", "value": 5.0, "comment": "", "grade_type": "TEST", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 19}	{"id": 14, "date": "2026-03-16", "value": 5.0, "comment": "", "grade_type": "TEST", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 19}	\N	\N	\N	\N	2026-02-22 19:47:02.665624+03	t	\N
301	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-02-22T16:43:44.591171+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-02-22T16:47:22.991987+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 19:47:22.992376+03	t	\N
302	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-22T16:45:20.90768+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-22T16:47:47.773632+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 19:47:47.774143+03	t	\N
303	CREATE	Grade	15	\N	{"id": 15, "date": "2026-02-22", "value": 3.0, "comment": "", "grade_type": "PROJ", "student_id": 5, "subject_id": 6, "teacher_id": 22, "schedule_lesson_id": 21}	\N	\N	\N	\N	2026-02-22 19:48:21.756084+03	t	\N
304	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-02-22T16:47:22.991987+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-02-22T16:48:34.818714+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 19:48:34.819414+03	t	\N
305	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T15:47:42.349625+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T16:50:02.386642+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-22 19:50:02.387303+03	t	\N
306	DELETE	HomeworkSubmission	3	{"id": 3, "student_id": 5, "homework_id": 6, "submitted_at": "2026-02-16T11:12:13.37657+00:00", "submission_file": "homework_submissions/school_grades_report_20260213_1803.pdf", "submission_text": " bnj"}	\N	\N	\N	\N	\N	2026-02-22 19:50:22.320674+03	t	\N
307	DELETE	Homework	6	{"id": 6, "title": "cds", "due_date": "2026-02-20T20:59:00+00:00", "attachment": "homework_attachments/тз.docx", "created_at": "2026-02-13T12:37:33.096574+00:00", "description": "ds", "student_group_id": 4, "schedule_lesson_id": 21}	\N	\N	\N	\N	\N	2026-02-22 19:50:22.320674+03	t	\N
308	DELETE	HomeworkSubmission	2	{"id": 2, "student_id": 5, "homework_id": 5, "submitted_at": "2026-02-08T14:20:39.843368+00:00", "submission_file": "homework_submissions/тз_mvgw6Wg.docx", "submission_text": "нпеаквуы"}	\N	\N	\N	\N	\N	2026-02-22 19:50:25.307581+03	t	\N
309	DELETE	Homework	5	{"id": 5, "title": "лллл", "due_date": "2026-02-15T20:59:00+00:00", "attachment": "homework_attachments/План.docx", "created_at": "2026-02-08T13:27:25.658099+00:00", "description": "мпритоль", "student_group_id": 4, "schedule_lesson_id": 19}	\N	\N	\N	\N	\N	2026-02-22 19:50:25.307581+03	t	\N
310	DELETE	Homework	4	{"id": 4, "title": "sw", "due_date": "2026-02-28T20:59:00+00:00", "attachment": "homework_attachments/ChatGPT_Image_30_янв._2026_г._17_52_42.png", "created_at": "2026-01-31T11:39:12.199578+00:00", "description": "xsыыы", "student_group_id": 4, "schedule_lesson_id": 14}	\N	\N	\N	\N	\N	2026-02-22 19:50:28.160379+03	t	\N
311	DELETE	HomeworkSubmission	1	{"id": 1, "student_id": 5, "homework_id": 1, "submitted_at": "2026-01-27T16:40:29.619392+00:00", "submission_file": "homework_submissions/тр.csv", "submission_text": "вкапенрго"}	\N	\N	\N	\N	\N	2026-02-22 19:50:30.996856+03	t	\N
312	DELETE	Homework	1	{"id": 1, "title": "аппп", "due_date": "2026-01-29T16:39:04+00:00", "attachment": "homework_attachments/Экономика.xlsx", "created_at": "2026-01-27T16:39:29.555932+00:00", "description": "сапр", "student_group_id": 4, "schedule_lesson_id": 4}	\N	\N	\N	\N	\N	2026-02-22 19:50:30.996856+03	t	\N
313	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-02-22T16:48:34.818714+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-02-22T16:50:37.191283+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 19:50:37.191917+03	t	\N
314	UPDATE	User	2	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T16:35:58.083169+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	{"id": 2, "email": "", "is_staff": false, "password": "pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=", "username": "men@mail.ru", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T18:36:00.120866+00:00", "date_joined": "2026-01-19T11:27:45+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 21:36:00.121625+03	t	\N
315	CREATE	ScheduleLesson	25	\N	{"id": 25, "subject_id": 1, "teacher_id": 4, "lesson_number": 2, "daily_schedule_id": 8}	\N	\N	\N	\N	2026-02-22 21:36:21.412763+03	t	\N
316	UPDATE	DailySchedule	10	{"id": 10, "week_day": "WED", "is_active": true, "is_weekend": true, "student_group_id": 6}	{"id": 10, "week_day": "WED", "is_active": true, "is_weekend": false, "student_group_id": 6}	\N	\N	\N	\N	2026-02-22 21:36:39.397731+03	t	\N
317	CREATE	ScheduleLesson	26	\N	{"id": 26, "subject_id": 6, "teacher_id": 22, "lesson_number": 1, "daily_schedule_id": 10}	\N	\N	\N	\N	2026-02-22 21:36:45.471201+03	t	\N
318	UPDATE	User	5	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-02-22T16:50:37.191283+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	{"id": 5, "email": "sesha_shk2@mail.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=", "username": "sesha_shk2@mail.ru", "is_active": true, "last_name": "Иван", "first_name": "Иван", "last_login": "2026-02-22T18:36:52.27591+00:00", "date_joined": "2026-01-26T17:40:47.700627+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 21:36:52.276431+03	t	\N
319	UPDATE	User	22	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-22T16:47:47.773632+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	{"id": 22, "email": "trainer@fitzone.ru", "is_staff": false, "password": "pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=", "username": "teacher", "is_active": true, "last_name": "Учитель", "first_name": "учит", "last_login": "2026-02-22T18:37:08.730576+00:00", "date_joined": "2026-02-08T13:23:35.223821+00:00", "is_superuser": false}	\N	\N	\N	\N	2026-02-22 21:37:08.731295+03	t	\N
320	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-22T16:50:02.386642+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-23T14:23:11.857118+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-23 17:23:11.857801+03	t	\N
321	UPDATE	User	1	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-23T14:23:11.857118+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	{"id": 1, "email": "sesha@mail.ru", "is_staff": true, "password": "pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=", "username": "sesha", "is_active": true, "last_name": "", "first_name": "", "last_login": "2026-02-23T16:23:19.982118+00:00", "date_joined": "2026-01-14T12:35:19.661306+00:00", "is_superuser": true}	\N	\N	\N	\N	2026-02-23 19:23:19.982696+03	t	\N
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
11	THU	t	6	f
10	WED	t	6	f
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
\.


--
-- Data for Name: api_homework; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_homework (id, title, description, created_at, due_date, attachment, schedule_lesson_id, student_group_id) FROM stdin;
7	Практ номер 3	Подготовка к контрольной работе	2026-02-22 16:06:18.317834+03	2026-03-01 23:59:00+03	homework_attachments/school_grades_report_20260222_1507.pdf	19	4
\.


--
-- Data for Name: api_homeworksubmission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_homeworksubmission (id, submission_file, submission_text, submitted_at, homework_id, student_id) FROM stdin;
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
6	аув	1	6
4	п50-422	2	22
\.


--
-- Data for Name: api_studentprofile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_studentprofile (user_id, patronymic, phone, birth_date, profile_image, address, course, student_group_id) FROM stdin;
7			\N			1	6
8			\N			1	6
10	Васильевна		2006-01-03			2	4
19	Иванович		\N			3	\N
23	рнпекау		\N			2	\N
5	Иванович		2026-01-29			3	4
9	cc		\N			2	\N
\.


--
-- Data for Name: api_subject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_subject (id, name, description) FROM stdin;
1	Математика	уав
4	ФИзика	
3	апр	апр
5	Суши	
6	Литература	люблю
\.


--
-- Data for Name: api_teacherprofile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_teacherprofile (user_id, patronymic, phone, birth_date, profile_image, qualification) FROM stdin;
4	сампир		\N		Математика
6	оо		\N		
21	Васильевна		\N		
22	h		\N		
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
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
21	pbkdf2_sha256$1200000$dsGGL6oebxeJgDpkwxKBRS$K05nHVvmu+8eIUR8tIt9UkDlGBIfUxQqoRnKpSU+Y9Q=	\N	f	m	trainer@mail.ru	шко	skolnikovaksenia64@gmail.com	f	t	2026-02-07 18:43:48.697553+03
2	pbkdf2_sha256$1200000$vpUuU5F7kjbF06Qbal2j0Z$ghxDg4sjzJTcc+v7NOHJFXyqxnJlSWjyKWNLJhRwLtQ=	2026-02-22 21:36:00.120866+03	f	men@mail.ru				f	t	2026-01-19 14:27:45+03
5	pbkdf2_sha256$1200000$gz8YjIpvHiFAyU5tZuKABO$9bzz4UbeWPECIi2KuOegNAUebbWuRbEBIB9BdRai7Ag=	2026-02-22 21:36:52.27591+03	f	sesha_shk2@mail.ru	Иван	Иван	sesha_shk2@mail.ru	f	t	2026-01-26 20:40:47.700627+03
22	pbkdf2_sha256$1200000$0xAY1fVdMUL4yVHoYiRlOe$VJB+ZVxyUItfVD2WBqAS3yG9MUU1iFT0s2NIz3DaTgU=	2026-02-22 21:37:08.730576+03	f	teacher	учит	Учитель	trainer@fitzone.ru	f	t	2026-02-08 16:23:35.223821+03
1	pbkdf2_sha256$1200000$buh5ckGmo4UCB53KjRwrNa$sx8v85193nvFsje24aE7P7U/Fu/zrUL2+tN5fU34+VM=	2026-02-23 19:23:19.982118+03	t	sesha			sesha@mail.ru	t	t	2026-01-14 15:35:19.661306+03
7	pbkdf2_sha256$1200000$GtMU2umd2XWT03AKGgl2cQ$3U5sPQQc5tvNg8WL+fOkPyFU5LbnO3012UQ6MEi93ac=	2026-02-03 14:03:26.579499+03	f	admin@mail.ru	dd	dc	sesha_shk3@mail.ru	f	t	2026-01-31 18:29:26.77964+03
9	pbkdf2_sha256$1200000$yj9WZmt5URkWZKR1UA7SK4$o42RubUl6rqHGfZYlV161fctzlBt7p6hpuKXhAVM1r8=	\N	f	ad@mail.ru	cc	cc	mail@mail.ru	f	t	2026-01-31 18:36:23.199562+03
10	pbkdf2_sha256$1200000$YpMK98z2yR58FJMNuSCHs9$LMD0Ip6yLj3QaTmtb8SEDRex5AsO+C9msG8yrFCs/30=	\N	f	2006@mail.ru	Иван	школьниковро	2006@mail.ru	f	t	2026-02-03 14:25:22.936796+03
6	pbkdf2_sha256$1200000$RlOXenbRLvap9crdB3EgrR$cb4PkmR5fd7A9+pQCNytKn3dhCoyNZoBpIW5OwYEhUE=	2026-01-31 15:19:02.136158+03	f	teacher@mail.tu	Учитель	Мистер		f	t	2026-01-31 14:01:18+03
23	pbkdf2_sha256$1200000$T70WNNdUwFb1TrTQZqwhx3$gFNYbqRTQ5LDkJB3pY4rwNXMARbzHyyKhkSO405nFFU=	\N	f	rfheb_enjj	грнепка	кнг6нек	www@mail.ru	f	t	2026-02-13 16:51:39.294237+03
4	pbkdf2_sha256$1200000$SLeaoT1FP9WDyKElBISuL7$kgSHAgE+t9gizhYfJjfrcyyxZmGpp3y3QVzgdaxj1T4=	2026-02-03 16:18:04.191742+03	f	teacher@mail.ru				f	t	2026-01-22 17:31:50+03
8	pbkdf2_sha256$1200000$V3nRa1TXgsM7KurjV6J9SR$SQg2pvO5RR4UlsYVD1VWoYlYG0EsSNbSzYrCiKa9SiA=	\N	f	trainer@mail.ru	s	ss	sesha_sh2@mail.ru	f	t	2026-01-31 18:32:17.25667+03
19	pbkdf2_sha256$1200000$hCubDibc5vEG3GxPHm9zU3$qtObWnScdZ4fNZouMZ5AVHaW200oN0v4LImhrhq94dw=	2026-02-22 16:57:47.096969+03	f	ddd	trainer@mail.ru	ВАСИЛЬЕВ	sesha_shk@mail.ru	f	t	2026-02-07 18:27:04.882064+03
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
3	4	3
4	5	2
5	6	3
6	7	2
7	8	2
8	9	2
9	10	2
18	19	2
20	21	3
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
4	user			0	manual	failed	2026-02-13 17:21:13.411888+03	\N	s	[WinError 2] Не удается найти указанный файл		0	0	\N		1
5	user			0	manual	failed	2026-02-13 17:25:03.009223+03	\N	h	[WinError 2] Не удается найти указанный файл		0	0	\N		1
6	1	backup_6_20260213_172548.sql	C:\\Users\\sesha\\OneDrive\\Desktop\\MPTed\\project\\backups\\backup_6_20260213_172548.sql	192182	manual	completed	2026-02-13 17:25:48.093241+03	2026-02-13 17:25:48.780628+03	n		mpted	28	190	\N		1
7	dws	backup_7_20260217_155750.sql	C:\\Users\\sesha\\OneDrive\\Desktop\\MPTed\\project\\backups\\backup_7_20260217_155750.sql	217798	manual	completed	2026-02-17 15:57:50.845874+03	2026-02-17 15:57:51.445842+03			mpted	28	190	\N		1
8	вы	backup_8_20260222_150259.sql	C:\\Users\\sesha\\OneDrive\\Desktop\\MPTed\\project\\backups\\backup_8_20260222_150259.sql	238033	manual	completed	2026-02-22 15:02:59.473091+03	2026-02-22 15:03:00.241069+03			mpted	28	309	\N		1
9	ds			0	manual	pending	2026-02-23 19:23:31.406062+03	\N				0	0	\N		1
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
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
09r9mqj05y1bmidcxif25pprcisxrqpj	.eJxVjEEOwiAURO_C2pBCC__j0n3PQIAPUjWQlHZlvLs06UJnOfPevJl1-5bt3uJqF2JXJtjlt_MuPGM5Bnq4cq881LKti-cHws-18blSfN1O9u8gu5a7nRANDNjjIIwewiSMV2MaMHqJFEAARnQyaQBFJJI0pFQ3ok46TIp9vtF-N3s:1vuYiO:e-7IMAUWSJKTdngkFnjckiHm8-CN5b0eF-U4uc6R490	2026-03-09 19:23:20.075336+03
w1ulpmhoibxe1pe85c27dtevasbvfhy8	.eJxVjEsOwjAMBe-SNYri_kxYsu8ZIseOSQGlUtOuEHeHSl3A9s3Me5lA25rDVtMSJjEX05jT7xaJH6nsQO5UbrPluazLFO2u2INWO86SntfD_TvIVPO35jNjcoDQReeT8sAdKjpuQV0v4nuQxrWivUcFiQARHQ6eBk3aCbF5fwDpkzhi:1vmD0e:Std1KiDN2iW5DA_9dJlV0HiozO40IHYwHVkhxeRuiFc	2026-02-14 18:35:40.799446+03
\.


--
-- Name: api_announcement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_announcement_id_seq', 5, true);


--
-- Name: api_attendance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_attendance_id_seq', 30, true);


--
-- Name: api_auditlog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_auditlog_id_seq', 321, true);


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

SELECT pg_catalog.setval('public.api_grade_id_seq', 15, true);


--
-- Name: api_homework_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_homework_id_seq', 7, true);


--
-- Name: api_homeworksubmission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_homeworksubmission_id_seq', 4, true);


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

SELECT pg_catalog.setval('public.api_subject_id_seq', 6, true);


--
-- Name: api_teachersubject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_teachersubject_id_seq', 5, true);


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

SELECT pg_catalog.setval('public.auth_permission_id_seq', 100, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 23, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 23, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: backup_service_backuplog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backup_service_backuplog_id_seq', 4, true);


--
-- Name: backup_service_backupschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backup_service_backupschedule_id_seq', 1, false);


--
-- Name: backup_service_databasebackup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backup_service_databasebackup_id_seq', 9, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 37, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 25, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 26, true);


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
-- PostgreSQL database dump complete
--


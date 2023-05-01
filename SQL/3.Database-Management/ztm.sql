--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15rc2

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

--
-- Name: ztm; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE ztm WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';


\connect ztm

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

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: feedback_deprecated; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.feedback_deprecated AS (
	student_id uuid,
	rating smallint,
	feedback text
);


--
-- Name: rating; Type: DOMAIN; Schema: public; Owner: -
--

CREATE DOMAIN public.rating AS smallint
	CONSTRAINT rating_check CHECK (((VALUE > 0) AND (VALUE <= 5)));


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: course; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course (
    course_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    description text,
    subject_id uuid NOT NULL,
    teacher_id uuid NOT NULL,
    feedback_deprecated public.feedback_deprecated[]
);


--
-- Name: enrollment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enrollment (
    course_id uuid NOT NULL,
    student_id uuid NOT NULL,
    enrollment_date date NOT NULL
);


--
-- Name: feedback; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feedback (
    student_id uuid NOT NULL,
    course_id uuid NOT NULL,
    feedback text,
    rating public.rating
);


--
-- Name: student; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student (
    student_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    date_of_birth date NOT NULL,
    email text
);


--
-- Name: subject; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subject (
    subject_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    subject text NOT NULL,
    description text
);


--
-- Name: teacher; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teacher (
    teacher_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    date_of_birth date NOT NULL,
    email text
);


--
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.course (course_id, name, description, subject_id, teacher_id, feedback_deprecated) VALUES
	('fbdbc06b-be57-4959-973e-ca8ad453bdc8', 'SQL Zero to Mastery', 'Learn Database and SQL A to Z', '4f31bcce-d898-446c-acdd-fc6171635e2b', '20384682-4ff7-45f1-88e4-2373ee8803d9', '{"(c2094c84-bc3e-4c15-a291-d393e0a828ca,5,feedback)"}');


--
-- Data for Name: enrollment; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.enrollment (course_id, student_id, enrollment_date) VALUES
	('fbdbc06b-be57-4959-973e-ca8ad453bdc8', 'c2094c84-bc3e-4c15-a291-d393e0a828ca', '2023-04-30');


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.feedback (student_id, course_id, feedback, rating) VALUES
	('c2094c84-bc3e-4c15-a291-d393e0a828ca', 'fbdbc06b-be57-4959-973e-ca8ad453bdc8', 'Great Course!', 5);


--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.student (student_id, first_name, last_name, date_of_birth, email) VALUES
	('c2094c84-bc3e-4c15-a291-d393e0a828ca', 'Rajdip', 'Das', '2001-08-30', 'dasrajdip@gmail.com');


--
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.subject (subject_id, subject, description) VALUES
	('4f31bcce-d898-446c-acdd-fc6171635e2b', 'SQL', 'Learn SQL Syntax');


--
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.teacher (teacher_id, first_name, last_name, date_of_birth, email) VALUES
	('20384682-4ff7-45f1-88e4-2373ee8803d9', 'Rajdip', 'Das', '2001-08-30', 'dasrajdip@gmail.com');


--
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (course_id);


--
-- Name: enrollment pk_enrollment; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT pk_enrollment PRIMARY KEY (course_id, student_id);


--
-- Name: feedback pk_feedback; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT pk_feedback PRIMARY KEY (student_id, course_id);


--
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);


--
-- Name: subject subject_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (subject_id);


--
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (teacher_id);


--
-- Name: course course_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subject(subject_id);


--
-- Name: course course_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teacher(teacher_id);


--
-- Name: enrollment enrollment_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(course_id);


--
-- Name: enrollment enrollment_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- Name: feedback feedback_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(course_id);


--
-- Name: feedback feedback_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- PostgreSQL database dump complete
--


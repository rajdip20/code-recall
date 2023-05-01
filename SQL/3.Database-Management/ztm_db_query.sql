-- CREATE TABLE student (
--     student_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
--     first_name VARCHAR(255) NOT NULL,
--     last_name VARCHAR(255) NOT NULL,
--     date_of_birth DATE NOT NULL
-- );

-- CREATE DOMAIN Rating SMALLINT
-- CHECK (VALUE > 0 AND VALUE <= 5);
-- 
-- CREATE TYPE Feedback AS (
--     student_id UUID,
--     rating SMALLINT,
--     feedback TEXT
-- );

-- CREATE TABLE subject (
--     subject_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
--     subject TEXT NOT NULL,
--     description TEXT
-- );

-- CREATE TABLE teacher (
--     teacher_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
--     first_name VARCHAR(255) NOT NULL,
--     last_name VARCHAR(255) NOT NULL,
--     date_of_birth DATE NOT NULL,
--     email TEXT
-- );

-- ALTER TABLE student ADD COLUMN email TEXT;

-- CREATE TABLE course (
--     course_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
--     "name" TEXT NOT NULL,
--     description TEXT,
--     subject_id UUID REFERENCES subject(subject_id),
--     teacher_id UUID REFERENCES teacher(teacher_id),
--     feedback feedback[]
-- );

-- CREATE TABLE enrollment (
--     course_id UUID REFERENCES course(course_id),
--     student_id UUID REFERENCES student(student_id),
--     enrollment_date DATE NOT NULL,
--     CONSTRAINT pk_enrollment PRIMARY KEY (course_id, student_id)
-- );


-- INSERT INTO student (
--     first_name,
--     last_name,
--     email,
--     date_of_birth
-- ) VALUES (
--     'Rajdip',
--     'Das',
--     'dasrajdip@gmail.com',
--     '2001-08-30'::DATE
-- );

-- INSERT INTO teacher (
--     first_name,
--     last_name,
--     email,
--     date_of_birth
-- ) VALUES (
--     'Rajdip',
--     'Das',
--     'dasrajdip@gmail.com',
--     '2001-08-30'::DATE
-- );

-- INSERT INTO subject (
--     subject,
--     description
-- ) VALUES (
--     'SQL',
--     'Learn SQL Syntax'
-- );

-- INSERT INTO course (
--     "name",
--     description
-- ) VALUES (
--     'SQL Zero to Mastery',
--     'Learn Database and SQL A to Z'
-- );

-- UPDATE course SET subject_id = '4f31bcce-d898-446c-acdd-fc6171635e2b' WHERE subject_id IS NULL;

-- ALTER TABLE course ALTER COLUMN subject_id SET NOT NULL;

-- UPDATE course SET teacher_id = '20384682-4ff7-45f1-88e4-2373ee8803d9' WHERE teacher_id IS NULL;

-- ALTER TABLE course ALTER COLUMN teacher_id SET NOT NULL;

-- INSERT INTO enrollment (
--     student_id,
--     course_id,
--     enrollment_date
-- ) VALUES (
--     'c2094c84-bc3e-4c15-a291-d393e0a828ca',
--     'fbdbc06b-be57-4959-973e-ca8ad453bdc8',
--     NOW()::DATE
-- );

-- UPDATE course SET feedback = ARRAY_APPEND(
--     feedback,
--     ROW(
--         'c2094c84-bc3e-4c15-a291-d393e0a828ca',
--         5,
--         'feedback'
--     )::feedback
-- )
-- WHERE course_id = 'fbdbc06b-be57-4959-973e-ca8ad453bdc8';

-- CREATE TABLE feedback (
--     student_id UUID NOT NULL REFERENCES student(student_id),
--     course_id UUID NOT NULL REFERENCES course(course_id),
--     feedback TEXT,
--     rating rating,
--     CONSTRAINT pk_feedback PRIMARY KEY (student_id, course_id)
-- );

-- INSERT INTO feedback (
--     student_id,
--     course_id,
--     feedback,
--     rating
-- ) VALUES (
--     'c2094c84-bc3e-4c15-a291-d393e0a828ca',
--     'fbdbc06b-be57-4959-973e-ca8ad453bdc8',
--     'Great Course!',
--     5
-- );


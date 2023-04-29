/* GIVE ME A LIST OF ALL EMPLOYEES IN THE COMPANY */
-- SELECT * FROM "public"."employees";

/* HOW MANY DEPARTMENTS ARE THERE IN THE COMPANY */
-- SELECT COUNT(dept_name) FROM "public"."departments";

/* HOW MANY TIMES HAS EMPLOYEE 10001 HAD A RAISE? */
-- SELECT * FROM "public"."salaries" WHERE emp_no=10001;

/* WHAT TITLE DOES 10006 HAVE? */
-- SELECT * FROM "public"."titles" WHERE emp_no=10006;

/* RENAME a column (NOT PERMANENT CHANGE) */
-- SELECT emp_no AS "Employee #", birth_date AS "Birthday", first_name AS "First name" FROM "public"."employees";

/* COLUMN CONCATENATION */
-- SELECT emp_no, CONCAT(first_name, ' ', last_name) AS "full name" FROM "public"."employees";

/* HOW MANY PEOPLE WORK IN THIS COMPANY */
-- SELECT COUNT(emp_no) FROM employees;

/* GET THE HIGHEST SALARY AVAILABLE */
-- SELECT MAX(salary) FROM salaries;

/* GET THE TOTAL AMOUNT OF SALARIES PAID */
-- SELECT SUM(salary) FROM salaries;

/* WHAT IS THE AVERAGE SALARY FOR THE COMPANY? */
-- SELECT AVG(salary) FROM salaries;

/* WHAT YEAR WAS THE YOUNGEST PERSON BORN IN THE COMPANY? */
-- SELECT MAX(birth_date) FROM employees;

/* SELECT THE EMPLOYEE WITH THE NAME MAYUMI SCHUELLER */
-- SELECT first_name, last_name FROM employees WHERE first_name='Mayumi' AND last_name='Schueller';

/* FILTER OUT FIRST 2 NAME */
-- SELECT first_name, last_name, hire_date FROM employees
-- WHERE (first_name='Georgi' AND last_name='Facello' AND hire_date='1986-06-26')
-- OR (first_name='Bezalel' AND last_name='Simmel');

/* FIND THE AGE OF ALL EMPLOYEES WHO'S NAME STARTS WITH M */
-- SELECT first_name, last_name, EXTRACT(YEAR FROM AGE(birth_date)) AS "age" FROM employees WHERE first_name ILIKE 'M%';

/* HOW MANY PEOPLE'S NAME START WITH A AND END WITH R? */
-- SELECT COUNT(emp_no) FROM employees WHERE first_name ILIKE 'A%R';


/* DATES AND TIMEZONE */

-- CREATE TABLE timezones (
--     ts TIMESTAMP WITHOUT TIME ZONE,
--     tz TIMESTAMP WITH TIME ZONE
-- )

-- INSERT INTO timezones VALUES(
--     TIMESTAMP WITHOUT TIME ZONE '2000-01-01 10:00:00-05',
--     TIMESTAMP WITH TIME ZONE '2000-01-01 10:00:00-05'
-- );

-- SELECT * FROM timezones;

-- SELECT CURRENT_DATE;

-- SELECT TO_CHAR(CURRENT_DATE, 'dd/mm/yyyy');

-- SELECT TO_CHAR(CURRENT_DATE, 'WW');

-- SELECT AGE(DATE '2001-08-30');

-- SELECT EXTRACT(DAY FROM DATE '2001/08/30') AS "day";

-- SELECT DATE_TRUNC('month', DATE '2001/08/30');


/* GET ME ALL THE EMPLOYEES ABOVE 60, USE THE APPROPRIATE DATE FUNCTIONS */
-- SELECT *, AGE(birth_date) as "age" FROM employees WHERE EXTRACT(YEAR FROM AGE(birth_date))>60;

/* HOW MANY EMPLOYEES WERE HIRED IN FEBRUARY? */
-- SELECT COUNT(emp_no) FROM employees WHERE EXTRACT(MONTH FROM hire_date)=2;

/* HOW MANY EMPLOYEES WERE BORN IN NOVEMBER */
-- SELECT COUNT(emp_no) FROM employees WHERE EXTRACT(MONTH FROM birth_date)=11;

/* WHO IS THE OLDEST EMPLOYEE? (USE THE ANALYTICAL FUNCTION MAX) */
-- SELECT MAX(AGE(birth_date)) FROM employees;

/* WHAT UNIQUE TITLES DO WE HAVE? */
-- SELECT DISTINCT title FROM titles;

/* HOW MANY UNIQUE BIRTH DATES ARE THERE? */
-- SELECT COUNT(DISTINCT birth_date) AS "total birth_date" FROM employees;

/* SORT EMPLOYEES BY FIRST NAME ASCENDING AND LAST NAME DESCENDING */
-- SELECT * FROM employees ORDER BY first_name, last_name DESC;

/* SORT EMPLOYEES BY AGE */
-- SELECT * FROM employees ORDER BY birth_date;

/* SORT EMPLOYEES WHO'S NAME STARTS WITH A "K" BY HIRE_DATE */
-- SELECT * FROM employees WHERE first_name ILIKE 'K%' ORDER BY hire_date;


/* MULTI TABLE SELECT */
-- SELECT a.emp_no, CONCAT(a.first_name,' ' ,a.last_name) AS "name", b.salary 
-- FROM employees AS a, salaries AS b
-- WHERE a.emp_no = b.emp_no ORDER BY a.emp_no;


/* INNER JOIN */
-- SELECT a.emp_no, CONCAT(a.first_name, ' ', a.last_name), b.salary, b.from_date, c.title
-- FROM employees AS a
-- INNER JOIN salaries AS b ON b.emp_no = a.emp_no
-- INNER JOIN titles AS c ON c.emp_no = a.emp_no
-- ORDER BY a.emp_no ASC, b.from_date ASC;


/* LEFT JOIN */
/* HOW MANY EMPLOYEES AREN'T MANAGER */
-- SELECT COUNT(emp.emp_no)
-- FROM employees AS emp
-- LEFT JOIN dept_manager AS dep ON emp.emp_no = dep.emp_no
-- WHERE dep.emp_no IS NULL;

/* WANT TO KNOW EVERY SALARY RAISE AND ALSO KNOW WHICH ONES WERE A PROMOTION */
-- SELECT a.emp_no, CONCAT(a.first_name, ' ', a.last_name), b.salary, COALESCE(c.title, 'no title change')
-- FROM employees AS a
-- INNER JOIN salaries AS b ON b.emp_no = a.emp_no
-- LEFT JOIN titles AS c ON c.emp_no = a.emp_no
-- AND (c.from_date = b.from_date OR c.from_date = b.from_date + INTERVAL '2 days')
-- ORDER BY a.emp_no;

/* SHOW ME FOR EACH EMPLOYEE WHICH DEPARTMENT THEY WORK IN */
-- SELECT a.emp_no, CONCAT(a.first_name, ' ', a.last_name) AS "name", c.dept_name FROM employees AS a
-- INNER JOIN dept_emp AS b ON b.emp_no = a.emp_no
-- INNER JOIN departments AS c ON c.dept_no = b.dept_no
-- ORDER BY a.emp_no;

/* HOW MANY PEOPLE WERE HIRED ON ANY GIVEN HIRE DATE? */
-- SELECT hire_date, COUNT(emp_no) AS "amount" FROM employees GROUP BY hire_date ORDER BY "amount" DESC;

/* SHOW ME ALL THE EMPLOYEES, HIRED AFTER 1991 AND COUNT THE AMOUNT OF POSITIONS THEY'VE HAD */
-- SELECT a.emp_no, CONCAT(a.first_name, ' ', a.last_name) AS "name", COUNT(b.title) AS "amount of titles" FROM employees AS a
-- INNER JOIN titles AS b USING(emp_no)
-- WHERE EXTRACT(YEAR FROM a.hire_date)>1991
-- GROUP BY a.emp_no
-- ORDER BY "amount of titles" DESC;

/* SHOW ME ALL THE EMPLOYEES THAT WORK IN THE DEPARTMENT DEVELOPMENT AND THE FROM AND TO DATE. */
-- SELECT a.emp_no, CONCAT(a.first_name, ' ', a.last_name) AS "name", b.from_date, b.to_date
-- FROM employees as a
-- JOIN dept_emp AS b USING(emp_no)
-- WHERE b.dept_no = 'd005'
-- GROUP BY a.emp_no, b.from_date, b.to_date
-- ORDER BY a.emp_no, b.to_date;

/* SHOW ME ALL THE EMPLOYEES, HIRED AFTER 1991, THAT HAVE HAD MORE THAN 2 TITLES */
-- SELECT a.emp_no, CONCAT(a.first_name, ' ', a.last_name) AS "name", COUNT(b.title) AS "amount of titles"
-- FROM employees AS a
-- INNER JOIN titles AS b USING(emp_no)
-- WHERE EXTRACT(YEAR FROM a.hire_date)>1991
-- GROUP BY a.emp_no
-- HAVING COUNT(b.title)>2
-- ORDER BY a.emp_no;

/* SHOW ME ALL THE EMPLOYEES THAT HAVE HAD MORE THAN 15 SALARY CHANGES THAT WORK IN THE DEPARTMENT DEVELOPMENT */
-- SELECT a.emp_no, CONCAT(a.first_name, ' ', a.last_name) AS "name", COUNT(c.salary) AS "total salary raise"
-- FROM employees AS a
-- INNER JOIN dept_emp AS b ON a.emp_no = b.emp_no
-- INNER JOIN salaries AS c ON a.emp_no = c.emp_no
-- WHERE b.dept_no = 'd005'
-- GROUP BY a.emp_no
-- HAVING COUNT(c.salary)>15
-- ORDER BY a.emp_no;

/* SHOW ME ALL THE EMPLOYEES THAT HAVE WORKED FOR MULTIPLE DEPARTMENTS */
-- SELECT a.emp_no, CONCAT(a.first_name, ' ', a.last_name) AS "name", COUNT(b.dept_no) AS "sum of departments"
-- FROM employees AS a
-- INNER JOIN dept_emp AS b USING(emp_no)
-- GROUP BY a.emp_no
-- HAVING COUNT(b.dept_no) > 1
-- ORDER BY a.emp_no;

/* CALCULATE THE TOTAL AMOUNT OF EMPLOYEES PER DEPARTMENT AND THE TOTAL USING GROUPING SETS */
-- SELECT GROUPING(c.dept_no), c.dept_no, COUNT(c.emp_no)
-- FROM dept_emp AS c
-- GROUP BY
--     GROUPING SETS(
--         (c.dept_no),
--         ()
--     )
-- ORDER BY c.dept_no;

/* CALCULATE THE TOTAL AVERAGE SALARY PER DEPARTMENT AND THE TOTAL USING GROUPING SETS */
-- select grouping(b.dept_no), b.dept_no, AVG(a.salary)
-- FROM salaries as a
-- INNER JOIN dept_emp as b USING (emp_no)
-- GROUP BY
-- 	GROUPING SETS (
-- 		(b.dept_no),
--      	()
-- 	)
-- order by b.dept_no

/* GET THE MOST RECENT SALARY PER EMPLOYEE */
-- SELECT  DISTINCT b.emp_no, b.first_name, d.dept_name, LAST_VALUE(a.salary)
-- OVER(
--     PARTITION BY b.emp_no
--     ORDER BY a.from_date
--     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
-- ) AS "Current Salary"
-- FROM salaries AS a
-- INNER JOIN employees AS b USING(emp_no)
-- INNER JOIN dept_emp AS c USING(emp_no)
-- INNER JOIN departments AS d USING(dept_no)
-- ORDER BY b.emp_no;

/* CREATE A VIEW "90-95" THAT: SHOWS ME ALL THE EMPLOYEES, HIRED BETWEEN 1990 AND 1995 */
-- CREATE VIEW "90-95" AS
-- SELECT *
-- FROM employees AS e
-- WHERE EXTRACT (YEAR FROM e.hire_date) BETWEEN 1990 AND 1995
-- ORDER BY e.emp_no;

/* CREATE A VIEW "BIGBUCKS" THAT: SHOWS ME ALL EMPLOYEES THAT HAVE EVER HAD A SALARY OVER 80000 */
-- CREATE VIEW "bigbucks" AS
-- SELECT e.emp_no, s.salary
-- FROM employees as e
-- JOIN salaries as s USING(emp_no)
-- WHERE s.salary > 80000
-- ORDER BY s.salary;

/* FILTER EMPLOYEES WHO HAVE EMP_NO 110183 AS A MANAGER */
-- SELECT emp_no, first_name, last_name
-- FROM employees
-- WHERE emp_no IN (
--     SELECT emp_no
--     FROM dept_emp
--     WHERE dept_no = (
--         SELECT dept_no 
--         FROM dept_manager
--         WHERE emp_no = 110183
--     )
-- )
-- ORDER BY emp_no

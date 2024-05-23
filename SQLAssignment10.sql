--RUN THE STATEMENTS IN ORDER
--DO NOT PUT A C0MM1T IN YOUR SCRIPT
--query1
INSERT INTO instructor
(instructor_id, salutation, first_name, last_name, street_address, zip, phone, CREATED_BY, CREATED_DATE, MODIFIED_BY, MODIFIED_DATE)
VALUES
(815, 'Dr', 'Waldo', 'Wildcat', '1234 Stewart Stadium Way', '07002', NULL, 'Jake Ildefonso', SYSDATE, 'Jake Ildefonso', SYSDATE);
SAVEPOINT q1;
--query2
INSERT INTO SECTION
(SECTION_ID,
COURSE_NO,
SECTION_NO,
START_DATE_TIME,
LOCATION,
INSTRUCTOR_ID,
CAPACITY,
CREATED_BY,
CREATED_DATE,
MODIFIED_BY,
MODIFIED_DATE)
VALUES
(48,--SECTION_ID
142,--COURSE_NO
4,--SECTION_NO
SYSDATE,--START_DATE_TIME
'L211',--LOCATION
815,--INSTRUCTOR_ID
15,--CAPACITY
'Jake Ildefonso',--CREATED_BY
SYSDATE,--CREATED_DATE
'Jake Ildefonso',--MODIFIED_BY
SYSDATE--MODIFIED_DATE
);
SAVEPOINT q2;
--query3
INSERT INTO enrollment
(STUDENT_ID,
SECTION_ID,
ENROLL_DATE,
FINAL_GRADE,
CREATED_BY,
CREATED_DATE,
MODIFIED_BY,
MODIFIED_DATE)
--Values under here
SELECT student_id,--STUDENT_ID
48,--SECTION_ID
SYSDATE,--ENROLL_DATE   
NULL,--FINAL_GRADE
'Jake Ildefonso',--CREATED_BY
SYSDATE,--CREATED_DATE
'Jake Ildefonso',--MODIFIED_BY
SYSDATE--MODIFIED_DATE
FROM student WHERE employer = 'Miro Life Insurance';
SAVEPOINT q3;
--query(s)4

--DELETE FROM enrollment
--WHERE student_id = 147 AND section_id = 120;
--THIS DOESNT WORK BECAUSE IT HAS CHILD RECORDS / DEPENDENT RECORDS THAT MUST BE DELETED FIRST

DELETE FROM grade
WHERE student_id = 147 AND section_id = 120;
DELETE FROM enrollment
WHERE student_id = 147 AND section_id = 120;
SAVEPOINT q4;
--query5

DELETE FROM grade
WHERE student_id = 180 AND section_id = 119;
DELETE FROM enrollment
WHERE student_id = 180 AND section_id = 119;
SAVEPOINT q5;
--query6

UPDATE instructor
SET phone = 4815162342
WHERE instructor_id = 815;
SAVEPOINT q6;
--query7

UPDATE grade
SET numeric_grade = 100
WHERE grade_type_code = 'HM' AND section_id = 119 AND grade_code_occurrence = 1;
SAVEPOINT q7;
--query8

UPDATE grade
SET numeric_grade = numeric_grade * 1.1
WHERE section_id = 119 AND grade_type_code = 'FI';
--query9

SELECT s.section_id, location, NVL(COUNT(*), 0) as enrolled
FROM section s
LEFT OUTER JOIN enrollment e ON s.section_id = e.section_id
WHERE course_no = 142
GROUP BY s.section_id, location;
--query10

SELECT DISTINCT first_name, last_name, phone
FROM instructor i
INNER JOIN section s ON i.instructor_id = s.instructor_id
INNER JOIN course c ON c.course_no = s.course_no
WHERE c.course_no = 142
ORDER BY first_name, last_name;
--query11

SELECT s.student_id, first_name, last_name, ROUND(AVG(numeric_grade),2) as Average
from student s
INNER JOIN enrollment e ON s.student_id = e.student_id
INNER JOIN grade g ON e.student_id = g.student_id
WHERE e.section_id = 119
GROUP BY s.student_id, first_name, last_name
ORDER BY student_id;
--query 12

SELECT i.instructor_id, first_name, last_name, COUNT(*) as NumStudents
from section s
INNER JOIN instructor i ON s.instructor_id = i.instructor_id
INNER JOIN enrollment e ON e.section_id = s.section_id
WHERE location = 'L211'
GROUP BY i.instructor_id, first_name, last_name
HAVING COUNT(*) > 3;
--query13

SELECT (salutation || ' ' || first_name || ' ' || last_name) AS instructor, phone
FROM instructor i
INNER JOIN section s ON i.instructor_id = s.instructor_id
INNER JOIN course c ON s.course_no = c.course_no
WHERE c.course_no = 142
MINUS
SELECT (salutation || ' ' || first_name || ' ' || last_name) AS instructor, phone
FROM instructor i
INNER JOIN section s ON i.instructor_id = s.instructor_id
INNER JOIN course c ON s.course_no = c.course_no
WHERE c.course_no <> 142;
--query14

SELECT first_name, last_name, e.section_id, se.course_no, NVL(NumGrades, 0) as NumGrades
FROM student s
INNER JOIN enrollment e ON s.student_id = e.student_id
INNER JOIN section se ON e.section_id = se.section_id
LEFT OUTER JOIN
(SELECT student_id, section_id, COUNT(*) AS NumGrades
FROM Grade
GROUP BY student_id, section_id) g
ON g. student_id = e.student_id
AND g.section_id = e.section_id
WHERE NumGrades IS NULL;
--query15

SELECT DISTINCT To_char(start_date_time, 'HH:MIAM') as StartTime, COUNT(*) as NumCourses
FROM (
SELECT DISTINCT co.course_no, start_date_time
FROM course co
INNER JOIN section se ON co.course_no = se.course_no) s
INNER JOIN course c ON c.course_no = s.course_no
GROUP BY start_date_time
--query 1
SELECT first_name, last_name, phone
FROM student
INNER JOIN zipcode zc
ON student.zip = zc.zip
WHERE zc.state = 'NJ' AND zc.city = 'Jersey City'
ORDER BY last_name, first_name;

--query 2
SELECT section.course_no, section.description
FROM section
INNER JOIN course
ON course.course_no = section.course_no
INNER JOIN instructor
ON section.instructor_id = instructor.instructor_id
WHERE first_name = 'Tom' AND last_name = 'Wojick' AND course.course_no BETWEEN 100 AND 199
ORDER BY section.course_no;

--query 3
SELECT gt.grade_type_code, description, number_per_section, percent_of_final_grade, s.section_id
FROM grade_type gt
INNER JOIN grade_type_weight gtw
    ON gt.grade_type_code = gtw.grade_type_code
INNER JOIN section s
    ON gtw.section_id = s.section_id
WHERE course_no = '350'
ORDER BY gt.description, s.section_id;

--query 4
SELECT DISTINCT first_name, last_name, to_char(enroll_date, 'MON DD, YYYY HH:Mi') AS Long_date
FROM student s
INNER JOIN enrollment e
    ON s.student_id = e.student_id
WHERE to_char(enroll_date, 'Mon YYYY') = 'Jan 2007'
ORDER BY Long_date, last_name, first_name;

--query 5
SELECT last_name || ', ' || first_name AS fullname, to_char(enroll_date, 'MM/DD/YYYY') AS ENROLLDATE, course_no, grade_type_code, grade_code_occurrence, numeric_grade
FROM student s
INNER JOIN enrollment e ON s.student_id = e.student_id
INNER JOIN section sc ON e.section_id = sc.section_id
INNER JOIN grade g ON e.student_id = g.student_id
WHERE last_name LIKE 'W%' AND first_name LIKE 'D%'
ORDER BY last_name, course_no, grade_type_code, grade_code_occurrence, numeric_grade;

--query 6
SELECT section_id, section_no, description
FROM section s
INNER JOIN course c ON s.course_no = c.course_no
WHERE c.prerequisite IS NULL
ORDER BY section_id;

--query 7
SELECT DISTINCT first_name, last_name, to_char(enroll_date, 'DD MON YYYY HH:Mi AM') AS ENROLLDATE
FROM student s
INNER JOIN enrollment e
    ON s.student_id= e.student_id
WHERE e.enroll_date < TO_DATE('02/07/2007 10:18AM', 'MM/DD/YYYY HH:MiAM')
ORDER BY last_name, first_name;

--query 8
SELECT course_no, gt.description
FROM section s
INNER JOIN grade_type_weight gtw ON s.section_id = gtw.section_id
INNER JOIN grade_type gt ON gtw.grade_type_code = gt.grade_type_code
WHERE gt.grade_type_code = 'PA'
ORDER BY course_no;

--query 9
SELECT s.section_id, gtw.grade_type_code, numeric_grade
FROM section s
INNER JOIN grade_type_weight gtw ON s.section_id = gtw.section_id
INNER JOIN grade g ON gtw.section_id = g.section_id
WHERE drop_lowest = 'Y' AND numeric_grade < 73
ORDER BY numeric_grade DESC;

--query 10
SELECT c.course_no, c.description, c.prerequisite, prereq.description AS prereq_description
FROM course c
INNER JOIN course prereq ON c.prerequisite = prereq.course_no
WHERE c.course_no BETWEEN 100 AND 199
ORDER BY course_no;
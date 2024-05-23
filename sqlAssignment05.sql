--query 1
SELECT ROUND(AVG(cost),2) as "Average Cost"
FROM course;

--query 2
SELECT DISTINCT COUNT(student_id) as "Janruary Registration"
FROM student
WHERE to_char(registration_date, 'MM YYYY') = '01 2007';

--query 3
SELECT AVG(numeric_grade) AS AVERAGE, MAX(numeric_grade) AS HIGHEST, MIN(numeric_grade) AS LOWEST
FROM grade
WHERE section_id = 94 AND grade_type_code = 'FI';

--query 4
SELECT city, state, count(*) AS zipcodes
FROM zipcode
GROUP BY city, state
HAVING count(*) > 1
ORDER BY zipcodes desc, city desc, state;

--query 5
SELECT section_id, enroll_date, count(*) as enrolled
FROM enrollment
WHERE to_char(enroll_date, 'MM/DD/YYYY') = '02/11/2007'
GROUP BY section_id, enroll_date
ORDER BY  enrolled desc, section_id;

--query 6 probable theres an issue
SELECT s.student_id, first_name, last_name, e.section_id, ROUND(avg(numeric_grade),4) as avgGrade
FROM student s
INNER JOIN enrollment e ON s.student_id = e.student_id
INNER JOIN grade g ON e.student_id = g.student_id
WHERE e.section_id = 116
GROUP BY s.student_id, first_name, last_name, e.section_id
ORDER BY avgGrade desc,student_id;

--query 7
SELECT s.student_id, first_name, last_name, COUNT(*) as sections
FROM student s
INNER JOIN enrollment e ON s.student_id = e.student_id
GROUP BY s.student_id, first_name, last_name
HAVING COUNT(*) >= 3
ORDER BY sections DESC, last_name, first_name;

--query 8
SELECT section_id, MIN(numeric_grade) as lowscore
FROM grade g
WHERE grade_type_code = 'QZ'
GROUP BY section_id
HAVING MIN(numeric_grade) > 85
ORDER BY lowscore desc, section_id;

--query 9
SELECT employer, COUNT(*) as employees
FROM student s
GROUP BY employer
HAVING COUNT(*) = 4
ORDER BY employer;

--query 10
SELECT s.section_id, course_no, count(*) as participation_grades, MIN(numeric_grade) as lowest_grade
FROM section s
INNER JOIN enrollment e ON s.section_id = e.section_id
INNER JOIN grade g ON e.section_id = g.section_id AND e.student_id = g.student_id
WHERE g.grade_type_code = 'PA'
GROUP BY s.section_id, course_no
HAVING count(*) > 12
ORDER BY section_id;
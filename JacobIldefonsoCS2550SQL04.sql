--query 1
SELECT first_name, last_name, phone, city, state, employer
FROM student s
INNER JOIN zipcode z ON s.zip = z.zip
WHERE employer = 'New York Pop'
ORDER BY city, state, last_name, first_name;
--query 2
SELECT employer, city, state
FROM student s
INNER JOIN zipcode z ON s.zip = z.zip
WHERE employer LIKE '%&%'
ORDER BY employer, city, state;
--query 3
SELECT UPPER(last_name) ||', '||SUBSTR(first_name, 1,1)||'.' AS "Student Name", LPAD(phone,15,'*') AS PHONE, city
FROM student s
INNER JOIN zipcode z ON s.zip = z.zip
WHERE s.phone LIKE '617%'
ORDER BY "Student Name";
--query 4
SELECT DISTINCT first_name, last_name, street_address, description
FROM instructor i
INNER JOIN zipcode z ON i.zip = z.zip
INNER JOIN section s ON i.instructor_id = s.instructor_id
INNER JOIN course c ON c.course_no = s.course_no
WHERE i.zip = 10035
ORDER BY description;
--query 5
SELECT student_id, s.first_name, s.last_name, s.zip, z.city, z.state
FROM student s
INNER JOIN zipcode z ON s.zip = z.zip
WHERE city = 'Jamaica' AND state = 'NY'
ORDER BY s.zip, s.student_id;
--query 6
SELECT c.course_no, description, location
FROM course c
INNER JOIN section s ON c.course_no = s.course_no
WHERE SUBSTR(location, 2,1) = '3'
ORDER BY location, c.course_no;
--query 7
SELECT
CASE state
    WHEN 'FL' THEN 'Florida'
    WHEN 'GA' THEN 'Georgia'
    WHEN 'MI' THEN 'Michigan'
    WHEN 'PR' THEN 'Puerto Rico'
    WHEN 'WV' THEN 'West Virginia'
END AS FULLSTATENAME, state, city
FROM ZIPCODE
WHERE state IN ('FL', 'GA', 'MI', 'PR', 'WV');
--query 8
SELECT (i.first_name||' '||i.last_name||' '||i.street_address||' '||z.city||' '||z.state||' '||z.zip) AS "Instructor Address"
FROM instructor i
INNER JOIN zipcode z ON i.zip = z.zip
ORDER BY z.zip, i.last_name, i.first_name;
--query 9
SELECT DISTINCT s.first_name, s.last_name, s.student_id, g.numeric_grade
FROM student s
INNER JOIN enrollment e ON s.student_id = e.student_id
INNER JOIN grade g ON e.student_id = g.student_id
WHERE g.section_id = 119 AND g.grade_type_code = 'QZ'
ORDER BY g.numeric_grade, student_id;
--query 10
SELECT s.first_name, s.last_name, s.student_id, g.numeric_grade, 
CASE
    WHEN g.numeric_grade >= 85 THEN LPAD('Pass', 6, ' ')
    ELSE LPAD('Fail', 6, ' ')
END AS "Result"
FROM student s
INNER JOIN enrollment e ON s.student_id = e.student_id
INNER JOIN grade g ON g.student_id = e.student_id
WHERE e.section_id = 147 AND g.grade_type_code = 'FI'
ORDER BY g.numeric_grade DESC, s.last_name, s.first_name; 
--since the bounds for pass and fail are numeric, sorting by numeric grade also sorts by pass and fail
--query 1
SELECT first_name, last_name, to_char(registration_date, 'Mon DD YYYY') AS regdate
FROM student
WHERE student_id IN
(
    SELECT student_id
    FROM student
    WHERE registration_date =
    (
    SELECT MIN(registration_date) as minDate
    FROM student
    )
)
ORDER BY last_name, first_name;
--query 2
SELECT description, section_no, cost, capacity
FROM section s
INNER JOIN course c ON c.course_no = s.course_no
WHERE cost = (
--lowest course cost
    SELECT min(cost)
    FROM course
) 
AND capacity < 
(
    SELECT avg(capacity)
    from section
)
ORDER BY description, section_no;
--query 3
SELECT c.course_no, description, capacity
FROM course c
INNER JOIN section s ON c.course_no = s.course_no;
--query 4
SELECT s.student_id, first_name, last_name, t1.numClasses AS most_classes
FROM student s
INNER JOIN
(
    SELECT student_id, count(*) as numClasses
    FROM enrollment e
    INNER JOIN section s ON e.section_id = s.section_id
    GROUP BY student_id
    HAVING count(*) =
    (
        SELECT MAX(numClasses)
        FROM
        (
            SELECT student_id, COUNT(*) as numClasses
            FROM enrollment e
            INNER JOIN section s ON s.section_id = e.section_id
            GROUP BY student_id
            ORDER BY numClasses
        )
    )
) t1 ON t1.student_id = s.student_id
WHERE s.student_id IN t1.student_id;
--query 5
SELECT first_name, last_name
FROM student s
WHERE zip IN
(
    SELECT zip
    FROM
    (
        SELECT zip, count(*)
        FROM student
        GROUP BY zip
        HAVING count(*) = 
        (
            SELECT MAX(numStudents)
            FROM
            (
                SELECT zip, count(*) as numStudents
                FROM student
                GROUP BY zip
            )
        )
    )
)
ORDER BY last_name, first_name;
--query 6
SELECT c.course_no, description
FROM course c
INNER JOIN section s ON s.course_no = c.course_no
WHERE instructor_id IN
(
    SELECT instructor_id
    from instructor
    WHERE first_name = 'Anita' AND last_name = 'Morris'
)
ORDER BY description;
--query 7
SELECT first_name, last_name
FROM student
WHERE student_id IN
(
    SELECT student_id from student
    MINUS
    SELECT student_id from enrollment
)
ORDER BY last_name, first_name;
--query 8
SELECT DISTINCT first_name, last_name, description, section_id
FROM
(
    SELECT g.student_id, g.section_id, c.description
    FROM grade g
    INNER JOIN grade_type_weight w ON g.section_id = w.section_id
    INNER JOIN section s ON w.section_id = s.section_id
    INNER JOIN course c ON s.course_no = c.course_no
    WHERE g.grade_type_code = 'PJ'
    AND numeric_grade =
    (
        SELECT MIN(numeric_grade)
        FROM 
        (
            SELECT numeric_grade
            FROM grade g
            WHERE grade_type_code = 'PJ'
        )
    )
) t1
INNER JOIN student s ON t1.student_id = s.student_id
ORDER BY last_name, first_name, description;
--query 9
SELECT enrolled, section_id, capacity
FROM
(
    SELECT s.section_id, s.capacity, COUNT(*) as enrolled
    FROM enrollment e
    INNER JOIN section s ON s.section_id = e.section_id
    GROUP BY s.section_id, capacity
)
WHERE capacity <= enrolled
ORDER BY capacity DESC, section_id;
--query 10
SELECT course_no, description, cost
FROM course
WHERE cost =
(
    SELECT MIN(cost)
    FROM
    (
        SELECT course_no, description, cost
        FROM course
    )
)
ORDER BY course_no, description;
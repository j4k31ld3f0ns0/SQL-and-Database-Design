--query 1
SELECT t1.student_id, s.last_name, s.first_name, t1.times_enrolled, s.employer
FROM
(
    SELECT e.student_id, t1.times_enrolled
    FROM enrollment e
    INNER JOIN 
    (
        SELECT student_id, COUNT(*) as times_enrolled
        FROM enrollment
        GROUP BY student_id
        ORDER BY times_enrolled
    ) t1 ON t1.student_id = e.student_id
    GROUP BY e.student_id, t1.times_enrolled
    HAVING COUNT(*) =
    (
       SELECT MAX(times_enrolled)
       FROM
       (
           SELECT student_id, COUNT(*) as times_enrolled
           FROM enrollment
           GROUP BY student_id
           ORDER BY times_enrolled
       )
    )
) t1
INNER JOIN student s ON s.student_id = t1.student_id
ORDER BY last_name, first_name;
--query 2
SELECT s.first_name AS student_first, s.last_name AS student_last, i.first_name AS instructor_first, i.last_name AS instructor_last
FROM
(
    SELECT student_id, instructor_id
    FROM
    (
        SELECT s.student_id, e.section_id
        FROM student s
        INNER JOIN enrollment e ON e.student_id = s.student_id
        WHERE
        zip =
        (
            SELECT zip
            FROM student
            INTERSECT
            SELECT zip
            FROM instructor
        )
    ) t1
    LEFT OUTER JOIN
    (
        SELECT i.instructor_id, section_id
        FROM instructor i
        INNER JOIN section s ON i.instructor_id = s.instructor_id
        WHERE
        zip =
        (
            SELECT zip
            FROM student
            INTERSECT
            SELECT zip
            FROM instructor
        )
    ) t2 ON t1.section_id = t2.section_id
    WHERE instructor_id IS NOT NULL AND student_id IS NOT NULL
) t1
INNER JOIN student s ON t1.student_id = s.student_id
INNER JOIN instructor i ON t1.instructor_id = i.instructor_id
ORDER BY s.first_name, s.last_name;
--query 3
SELECT first_name, last_name, z.city, 'student' AS role
FROM student s
INNER JOIN zipcode z ON s.zip = z.zip
WHERE z.zip = 10025
UNION ALL
SELECT first_name, last_name, z.city, 'instructor'
from instructor i
INNER JOIN zipcode z ON i.zip = z.zip
WHERE z.zip = 10025
ORDER BY role, last_name, first_name;
--query 4
SELECT DISTINCT s.location, sections, students
from section s
INNER JOIN
(
    SELECT DISTINCT location, COUNT(*) as students
    from section s
    INNER JOIN enrollment e ON s.section_id = e.section_id
    GROUP BY location
) t1 ON s.location = t1.location
INNER JOIN
(
    SELECT DISTINCT location, COUNT(*) as sections
    from section s
    GROUP BY location
) t2 ON s.location = t2.location
ORDER BY location;
--query 5
SELECT grade_type_code, to_char(numeric_grade) AS grade
FROM grade
WHERE student_id = '139'
UNION ALL
SELECT 'Average for student 139 is ', to_char(ROUND(AVG(numeric_Grade),2))
FROM grade
WHERE student_id = '139'
ORDER BY grade_type_code DESC;
--query 6
SELECT i.first_name, i.last_name, COUNT(*) as numSections
FROM instructor i 
LEFT OUTER JOIN section s ON i.instructor_id = s.instructor_id
GROUP BY i.first_name, i.last_name
--query 7

--query 8

--query 9

--query 10
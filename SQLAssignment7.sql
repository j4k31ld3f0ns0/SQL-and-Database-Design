--query 1
SELECT last_name, first_name
from instructor i
WHERE i.instructor_id NOT IN (
    SELECT instructor_id --ALL SECTIONS that HAVE PJ
    FROM grade_type_weight gtw
    INNER JOIN section s ON s.section_id = gtw.section_id
    WHERE grade_type_code = 'PJ'
)
ORDER BY last_name, first_name;

--query 2
--determine student ID's under avg for final in section 156
SELECT DISTINCT g.student_id AS below_average
from grade g
WHERE g.numeric_grade < (
    SELECT avg(numeric_grade) as average
    from grade
    WHERE section_id = '156' AND grade_type_code = 'FI'
    )
AND grade_type_code = 'FI' 
AND section_id = '156'
ORDER BY student_id;

--query 3
SELECT city, state --4th, converts the zip to relevant city and state data
FROM zipcode
WHERE zip = (
    SELECT zip --3rd, converts count max to zip
    from student
    GROUP BY zip
    HAVING COUNT(*) = (
        SELECT MAX(numStudent) --2nd, filters list by max num
        FROM (
            SELECT zip, count(*) as numStudent --1st query, gets list
            FROM student
            GROUP BY zip
            ORDER BY numStudent, zip
        )
    )
);

--query 4
SELECT s.student_id, first_name, last_name, t1.numeric_grade
FROM student s
INNER JOIN (
    SELECT student_id, numeric_grade
    FROM grade
    WHERE section_id = '154' AND grade_type_code = 'FI' AND numeric_grade = (
        SELECT MIN(numeric_grade)
        FROM grade g
        WHERE section_id = '154' AND grade_type_code = 'FI'
    )
) t1 ON t1.student_id = s.student_id
WHERE s.student_id = t1.student_id;

--query 5
SELECT s.student_id, s.last_name, s.first_name
from student s
INNER JOIN (
    SELECT student_id, course_no, COUNT(*) as numSections
    FROM enrollment e
    INNER JOIN (
        SELECT course_no, section_id
        FROM section
    ) t1 ON t1.section_id = e.section_id
    GROUP BY student_id, course_no
    HAVING COUNT(*) > 1
    ORDER BY numSections
) t2 ON s.student_id = t2.student_id
WHERE s.student_id = t2.student_id
ORDER BY s.last_name, s.first_name;

--query 6
SELECT first_name, last_name
FROM student s
INNER JOIN
(
    SELECT student_id --returns the minimum of the sophomore level courses
    FROM 
    (
        SELECT student_id, count(*) as howMany --q2 returns list of students and how many times theyve taken a sophmore level course
        FROM
        (
            SELECT e.student_id, e.section_id, s.course_no --q1 returns list of students and their sections and course numbers
            from enrollment e
            INNER JOIN section s ON e.section_id = s.section_id
        ) t1
        WHERE course_no BETWEEN 200 AND 299
        GROUP BY student_id
        ORDER BY howMany
    ) t2
    GROUP BY student_id
    HAVING COUNT(*) = MIN(howMany)
) t3 ON s.student_id = t3.student_id
ORDER BY last_name, first_name;

--query 7
SELECT c.course_no, description
FROM course c
INNER JOIN 
(
    SELECT course_no, MIN(numStudents) as leastStudents
    FROM
    (
        SELECT course_no, COUNT(*) as numStudents
        FROM (
            SELECT e.section_id, e.student_id, s.course_no
            FROM enrollment e
            INNER JOIN section s ON e.section_id = s.section_id
        )
        GROUP BY course_no
        ORDER BY numStudents DESC
    )
    GROUP BY course_no
    HAVING COUNT(*) = MIN(numStudents)
    ORDER BY leastStudents DESC
) t1 ON c.course_no = t1.course_no
WHERE t1.course_no = c.course_no
ORDER BY description;

--query 8
SELECT DISTINCT first_name, last_name
FROM student s
INNER JOIN
(
    SELECT student_id
    FROM enrollment e
    INNER JOIN section s ON s.section_id = e.section_id
    INNER JOIN 
    (
        SELECT course_no
        FROM SECTION S
        WHERE to_char(start_date_time, 'HH24:MI') = '10:30'
    ) t2 ON t2.course_no = s.course_no
    WHERE s.course_no = t2.course_no
) t1 ON t1.student_id = s.student_id
WHERE t1.student_id = s.student_id
ORDER BY last_name, first_name;

--query 9
SELECT first_name, last_name, t1.numeric_grade
from student s
INNER JOIN
(
    SELECT DISTINCT student_id, numeric_grade
    FROM grade g
    WHERE section_id = '156' AND grade_type_code = 'FI'
    AND numeric_grade <
    (
        SELECT avg(numeric_grade) as avgScore
        FROM grade
        WHERE section_id = '156' AND grade_type_code = 'FI'
    )
) t1 ON s.student_id = t1.student_id
ORDER BY numeric_grade DESC, last_name, first_name;

--query 10
SELECT first_name, last_name, phone
from student s
WHERE student_id IN
(
    SELECT student_id
    from enrollment e
    WHERE section_id IN
    (
        SELECT section_id
        FROM section s
        WHERE course_no IN 
        (
            SELECT course_no
            FROM course c
            WHERE description IN ('Intro to SQL','Oracle Tools','PL/SQL Programming','Database Design','Database System Principles','DB Programming with Java')
        )
    )
) ORDER BY last_name, first_name
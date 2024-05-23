SELECT i.instructor_id, i.first_name, i.last_name, COUNT(*) as numStudents
FROM enrollment e
INNER JOIN section s ON s.section_id = e.section_id
INNER JOIN instructor i ON i.instructor_id = s.instructor_id
GROUP BY i.instructor_id, i.first_name, i.last_name
HAVING COUNT(*) > 25
ORDER BY numStudents DESC;
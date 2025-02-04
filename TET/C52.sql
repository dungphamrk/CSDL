SELECT s.student_id, s.student_name
FROM students s
WHERE s.student_id NOT IN (
    SELECT sc.student_id
    FROM scores sc
    JOIN subjects sub ON sc.subject_id = sub.subject_id
    WHERE sub.subject_name = 'csdl'
);

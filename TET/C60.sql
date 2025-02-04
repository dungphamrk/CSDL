SELECT subject_id, subject_name FROM Subjects
WHERE NOT EXISTS (
    SELECT 1 FROM Students s
    WHERE NOT EXISTS (
        SELECT 1 FROM Enrollments e
        WHERE e.student_id = s.student_id AND e.subject_id = Subjects.subject_id
    )
);

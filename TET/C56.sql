SELECT DISTINCT s.student_id, s.student_name FROM Students s
WHERE NOT EXISTS (
    SELECT 1 FROM Scores sc
    WHERE sc.student_id = s.student_id AND sc.score < 5.0
);

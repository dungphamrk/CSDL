SELECT student_id,  s.student_name
FROM Students
WHERE student_id IN (
    SELECT student_id FROM Scores
    WHERE exam_attempt > 2
    GROUP BY student_id
);
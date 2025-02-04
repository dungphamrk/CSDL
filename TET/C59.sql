SELECT student_id, COUNT(subject_id) AS subject_count
FROM Scores
GROUP BY student_id
ORDER BY subject_count DESC
LIMIT 3;
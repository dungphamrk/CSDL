SELECT subject_id, subject_name, COUNT(student_id) AS student_count
FROM Scores
JOIN Subjects ON Scores.subject_id = Subjects.subject_id
GROUP BY subject_id, subject_name
HAVING COUNT(student_id) > 3;
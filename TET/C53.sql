SELECT DISTINCT e.student_id,  s.student_name
FROM Scores e
JOIN Students s ON e.student_id = s.student_id
WHERE e.exam_attempt = 2 AND e.student_id NOT IN (
    SELECT student_id FROM ScoresScores WHERE exam_attempt = 1
);
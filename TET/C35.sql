SELECT s.student_id,  s.student_name
FROM Students s
JOIN ScoresScores e ON s.student_id = e.student_id
WHERE e.exam_attempt = 1 AND e.score < 5.0
GROUP BY s.student_id,  s.student_name
HAVING COUNT(e.subject_id) > 2;

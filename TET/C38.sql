SELECT sub.subject_id, sub.subject_name,
    SUM(CASE WHEN e.score >= 5.0 THEN 1 ELSE 0 END) AS passed_students,
    SUM(CASE WHEN e.score < 5.0 THEN 1 ELSE 0 END) AS failed_students
FROM Scores e
JOIN Subjects sub ON e.subject_id = sub.subject_id
WHERE e.exam_attempt = 1
GROUP BY sub.subject_id, sub.subject_name;

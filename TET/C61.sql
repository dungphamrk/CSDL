SELECT s.student_id,s.student_name FROM Students s
JOIN Scores sc on s.student_id=sc.student_id
WHERE sc.subject_id in (SELECT subject_id FROM Scores WHERE student_id = 'A02') AND sc.student_id <> 'A02';

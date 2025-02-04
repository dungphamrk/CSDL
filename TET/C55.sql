SELECT s.student_id, s.student_name FROM Students s
WHERE s.sector_id = (SELECT sector_id FROM Sectors WHERE sector_name = 'Anh Văn')
AND s.student_id NOT IN (
    SELECT e.student_id FROM Scores e
    JOIN Subjects sub ON e.subject_id = sub.subject_id
    WHERE sub.subject_name = 'Văn Phạm'
);
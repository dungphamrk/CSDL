SELECT s.student_id, s.student_name FROM Students s
WHERE s.sector_id = (SELECT sector_id FROM Sectors WHERE sector_name = 'English')
AND s.scholarship > 0
AND NOT EXISTS (
    SELECT 1 FROM Scores sc
    WHERE sc.student_id = s.student_id AND sc.score < 5.0
);

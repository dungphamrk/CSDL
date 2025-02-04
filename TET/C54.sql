SELECT subject_id, subject_name FROM Subjects
WHERE subject_id NOT IN (
    SELECT DISTINCT e.subject_id FROM Enrollments e
    JOIN Students s ON e.student_id = s.student_id
    WHERE s.sector_id = (SELECT sector_id FROM Sectors WHERE sector_name = 'Anh Văn')
);

SELECT s.sector_id, s.sector_name
FROM Sectors s
JOIN Students st ON s.sector_id = st.sector_id
WHERE st.student_id IS NULL;
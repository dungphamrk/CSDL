SELECT sector_id, COUNT(student_id) AS scholarship_count
FROM Students
WHERE scholarship > 0
GROUP BY sector_id
ORDER BY scholarship_count DESC;
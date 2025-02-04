SELECT room, COUNT(*) AS total_students
FROM Students
GROUP BY room
HAVING COUNT(*) > 2;

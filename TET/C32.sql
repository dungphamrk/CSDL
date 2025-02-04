SELECT 
	subject, COUNT(studentId) AS studentCount
FROM Exams
GROUP BY subject
HAVING COUNT(DISTINCT studentId) > 3;

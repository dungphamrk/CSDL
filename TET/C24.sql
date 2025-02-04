select 
	subject,
    COUNT(*) AS total_students
from Students
group by subject;

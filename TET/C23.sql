select 
	sector,
    COUNT(*) AS total_students
from Students
group by sector;

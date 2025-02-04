select
	sector
from Students
where scholarship between 200000 and 300000
group by sector
having count(student_id)=2;
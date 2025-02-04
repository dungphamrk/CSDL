select
	sector
from Students
where gender ='Nam'
group by sector
having count(student_id)>2;
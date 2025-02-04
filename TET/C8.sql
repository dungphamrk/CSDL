select student_id, student_name , sector_id , scholarship 
from Students
where scholarship>100000
group by sector_id asc;
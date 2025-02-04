select 
	student_id,
    student_name
from Students
where country = ( select country from Students where student_name='Hải') and student_name !='Hải';
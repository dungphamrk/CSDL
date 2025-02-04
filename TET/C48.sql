select
	student_id,
    student_name
from Students
where scholarship > (select min(scholarship) from Students where sector = 'literature');
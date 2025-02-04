select
	student_id,
    student_name
from Students
where scholarship > (select sum(scholarship) from Students where sector = 'literature');
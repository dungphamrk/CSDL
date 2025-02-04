SET @max_scholarship = (SELECT MAX(scholarship) FROM Students);

select
	student_id,
    student_name,
    scholarship
from Students
where scholarship=@max_scholarship;

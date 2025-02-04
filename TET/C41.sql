set @oldest= (select max(age) from students);
select
	student_id,
    student_name,
	age
from Students
where sector='English' and age=@oldest;
set @highest_score=(select max(score) from Students);
 
select 
	student_id,
    student_name,
    score
from Students
where score = @highest_score;
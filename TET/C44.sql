

select
	sector,
    count(student_id) 
from Exam_1
where score < 50
group by sector
order by student_count desc
limit 1;
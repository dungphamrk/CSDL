

select
	sector,
    count(student_id) as student_count
from Students
group by sector
order by student_count desc
limit 1;


select
	sector,
    count(student_id) as student_female_count
from Students
where gender='female'
group by sector
order by student_count desc
limit 1;
select
	year(current_date())-year(date_of_birth) as age,
    count(*) as total_student
from Students
group by age
order by age;
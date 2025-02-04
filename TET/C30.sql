select 
	year(date_of_birth) as birth_year
from Students
group by year(birth_date)
having count(*) =2;
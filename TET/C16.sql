select student_name,date_of_birth,birthplace
from Students
where birthplace= 'Hà Nội'	and month(date_of_birth)=2; 
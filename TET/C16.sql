select student_name, student_lastName,date_of_birth,birthplace
from Student
where birthplace= 'Hà Nội'	and month(date_of_birth)=2; 
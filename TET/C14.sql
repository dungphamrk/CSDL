select student_name,student_id ,student_sector,gender
from Students st
join Sectors s on st.sector_id = s.sector_id
where st.gender = 'Male' and s.department_name in ('English', 'Computer Science');


select
 COUNT(*) as total_students,
 COUNT(CASE WHEN gender = 'Nữ' THEN 1 END) AS total_female_students
from Students;

select 
	student_id,
    student_name
from Exams_1
group by student_id
having count(case when score<50 then 1 end) > 1;
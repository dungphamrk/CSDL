select 
	sector,
    sum(score<50) as student_fail,
    sum(score>=50) as student_pass
from exam_1
group by sector;
select student_id , gender ,sector_id ,
case when scholarship>500000 then 'Học bổng cao' else 'Học bổng trung bình' end as scholarship_level
from Students;
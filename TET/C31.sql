select room, COUNT(*) AS total_students
from Students
group by room
having COUNT(*) > 2;

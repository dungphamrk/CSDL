select 
	sector, max(amount) as highest_scholarship
from scholarships group by Sector;

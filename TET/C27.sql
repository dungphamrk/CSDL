select 
	sector, max(scholarship) as highest_scholarship
from Students group by Sector;

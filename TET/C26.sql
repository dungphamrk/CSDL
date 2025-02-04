SELECT 
    sector, sum(amount) from scholarships
    group by sector;

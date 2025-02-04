SELECT 
    sector, 
    COUNT(CASE WHEN gender = 'Nam' THEN 1 END) AS total_male_students,   
    COUNT(CASE WHEN gender = 'Nữ' THEN 1 END) AS total_female_students  
FROM Students
GROUP BY sector; 

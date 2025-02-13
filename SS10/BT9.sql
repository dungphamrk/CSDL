use world;

create view CountryLanguageView as 
select c.Code as CountryCode,c.name as CountryName,cl.Language,cl.IsOfficial
from country c
join city ct on ct.CountryCode like c.code 
join countrylanguage cl on cl.CountryCode like c.Code
where IsOfficial like 't'
group by c.Code,c.name,cl.Language,cl.IsOfficial;

select * from CountryLanguageView;


 
delimiter //
 
create procedure GetLargeCitiesWithEnglish  ()
begin
	select ct.Name as CityName ,c.Name as CountryName,ct.Population
    from country c
	join city ct on ct.CountryCode like c.code 
	join countrylanguage cl on cl.CountryCode like c.Code
    where cl.IsOfficial like 't' and cl.Language like 'English' and ct.Population>1000000
	order by ct.Population desc 
    limit 20;
end;

// delimiter ;

call GetLargeCitiesWithEnglish ();

drop procedure if exists GetLargeCitiesWithEnglish   ;
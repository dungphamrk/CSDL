use world;

create view OfficialLanguageView  as 
select c.Code as CountryCode,c.name as CountryName,cl.Language	
from country c
join city ct on ct.CountryCode like c.code 
join countrylanguage cl on cl.CountryCode like c.Code
where cl.IsOfficial like 't'
group by c.Code,c.name,cl.Language,cl.IsOfficial;

select * from CountryLanguageView;

 
 -- 4
 
 create index nameIndex on city(name);
 
 -- 5
delimiter //
 
create procedure GetSpecialCountriesAndCities (in language_name varchar(255))
begin
	select c.name as countryname, 
		   ct.name as cityname, 
		   ct.population as citypopulation, 
		   ao.totalpopulation
	from city ct
	join country c on ct.countrycode = c.code
	join countrylanguage cl on cl.countrycode = c.code
	join (select ct.countrycode, sum(ct.population) as totalpopulation
		  from city ct
		  group by ct.countrycode) ao on ao.countrycode = c.code
	where cl.language = 'english' 
		  and ct.name like 'new%' 
		  and ao.totalpopulation > 5000000
	order by ao.totalpopulation desc
limit 10;

end;

// delimiter ;

call GetSpecialCountriesAndCities ('English');

drop procedure if exists GetSpecialCountriesAndCities ;
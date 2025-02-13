use world;
 
 
delimiter //
 
create procedure GetCountriesByCityNames ()
begin
	select c.Name as CountryName,cl.Language as OfficialLanguage,sum(ct.Population)as TotalPopulation    
    from country c
	join city ct on ct.CountryCode like c.code 
	join countrylanguage cl on cl.CountryCode like c.Code
    where cl.IsOfficial like 't' and c.name like 'A%'
    group by c.Name ,cl.Language 
    having sum(ct.Population)>2000000
	order by c.Name asc 
    limit 10;
end;

// delimiter ;

call GetCountriesByCityNames();

drop procedure if exists GetCountriesByCityNames  ;
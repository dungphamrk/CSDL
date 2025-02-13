use world;
 
 
delimiter //
 
create procedure GetEnglishSpeakingCountriesWithCities (in in_language varchar(255))
begin
	select c.Name as CountryName,sum(ct.Population)as TotalPopulation    
    from country c
	join city ct on ct.CountryCode like c.code 
	join countrylanguage cl on cl.CountryCode like c.Code
    where cl.IsOfficial like 't' and cl.Language like in_language
    group by c.Name  
    having sum(ct.Population)>5000000
	order by sum(ct.Population) desc 
    limit 10;
end;

// delimiter ;

call GetEnglishSpeakingCountriesWithCities ('English');

drop procedure if exists GetEnglishSpeakingCountriesWithCities ;
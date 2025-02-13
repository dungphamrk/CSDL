	use world;
 
 
delimiter //
 
create procedure GetCountriesWithLargeCities()
begin
	select c.Name as CountryName,sum(ct.Population)as TotalPopulation    
    from country c
	join city ct on ct.CountryCode like c.code 
    where c.Continent like 'Asia'
    group by c.Name  
    having sum(ct.Population)>10000000
	order by sum(ct.Population) desc ;
end;

// delimiter ;

call GetCountriesWithLargeCities ();

drop procedure if exists GetCountriesWithLargeCities ;
use world;
 
 
delimiter //
 
create procedure UpdateCityPopulation ( inout city_id int , in new_population int )
begin
	update city
    set Population=new_population
    where id=city_id;
	select ID ,Name  ,Population  
    from city
    where id=city_id;
end;

// delimiter ;

set @city_id= '2';
set @new_population=123123;

call UpdateCityPopulation(@city_id,@new_population);


drop procedure if exists UpdateCityPopulation ;
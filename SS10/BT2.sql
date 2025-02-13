use world;

delimiter //

create procedure CalculatePopulation (in p_countryCode varchar(255), out total_population int )
begin 
	set total_population= (select sum(Population) from city where CountryCode like p_countryCode);
end;

// delimiter ;


set @p_countryCode= 'NLD';
set @total_population=0;

call CalculatePopulation(@p_countryCode,@total_population);

select @total_population;

DROP PROCEDURE IF EXISTS CalculatePopulation; 
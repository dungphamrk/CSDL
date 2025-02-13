use world;
 
 
delimiter //
 
create procedure GetLargeCitiesByCountry  ( inout country_code varchar(255) )
begin
	select ID ,Name  ,Population  
    from city
    where CountryCode like country_code and Population>1000000
    order by Population desc;
end;

// delimiter ;

set @country_code= 'USA';


call GetLargeCitiesByCountry (@country_code);


drop procedure if exists GetLargeCitiesByCountry  ;
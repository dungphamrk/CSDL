use world;
 
 
delimiter //
 
create procedure b3( in in_language varchar(255))
begin
	select CountryCode ,Language ,Percentage 
    from countrylanguage
    where Language like in_language and Percentage > 50;
end;

// delimiter ;

call b3('English');

drop procedure if exists b3;
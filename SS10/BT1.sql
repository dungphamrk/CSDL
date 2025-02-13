use world;

DELIMITER //
	CREATE PROCEDURE b1(IN country_code varchar(255))
BEGIN
	select ID,Name,Population
    from city 
    where CountryCode like country_code;

END;

// DELIMITER ;

call b1('NLD');

DROP PROCEDURE IF EXISTS b1; 
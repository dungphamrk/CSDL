USE chinook;

-- 3
create view View_Album_Artist as
select alb.AlbumId, alb.Title as Album_Title, art.Name as Artist_Name
from album alb
join artist art on art.ArtistId = alb.ArtistId;

select * from View_Album_Artist;

-- 4
create view View_Customer_Spending as
select c.CustomerId, c.FirstName, c.LastName, c.Email, sum(i.Total) as Total_Spending
from invoice i
join customer c on i.CustomerId = c.CustomerId
group by c.CustomerId, c.FirstName, c.LastName, c.Email;

select * from View_Customer_Spending;

-- 5
create index idx_Employee_LastName on Employee(LastName);

select * from Employee
where LastName = 'King';

explain analyze select * from Employee
where LastName = 'King';

-- 6
select * from track;

DELIMITER //
create procedure GetTracksByGenre (in GenreId_in int)
begin
select t.TrackId, t.Name as Track_Name, alb.Title as Album_Title, art.Name as Artist_Name
from album alb
join track t on t.AlbumId = alb.AlbumId
join artist art on alb.ArtistId = art.ArtistId
where GenreId = GenreId_in;
end;
// DELIMITER //

call GetTracksByGenre(2);

-- 7

DELIMITER //
create procedure GetTrackCountByAlbum (IN p_AlbumId int)
begin
declare Total_Tracks int;
select count(TrackId) into Total_Tracks
from album alb
join track t on t.AlbumId = alb.AlbumId
where alb.AlbumId = p_AlbumId;
select Total_Tracks;
end;
// DELIMITER //

call GetTrackCountByAlbum(1);

-- 8
drop view View_Album_Artist;

drop view View_Customer_Spending;

drop index idx_Employee_LastName on Employee;

drop procedure if exists GetTracksByGenre;

drop procedure if exists GetTrackCountByAlbum;
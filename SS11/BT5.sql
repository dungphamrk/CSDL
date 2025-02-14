USE chinook;

-- 3
create view View_Album_Artist as
select album.AlbumId, album.Title as Album_Title, artist.Name as Artist_Name
from album join artist on artist.ArtistId = album.ArtistId;

select View_Album_Artist.AlbumId, View_Album_Artist.Album_Title, View_Album_Artist.Artist_Name
from View_Album_Artist;

-- 4
create view View_Customer_Spending as
select customer.CustomerId, customer.FirstName, customer.LastName, customer.Email, sum(invoice.Total) as Total_Spending
from invoice join customer on invoice.CustomerId = customer.CustomerId
group by customer.CustomerId, customer.FirstName, customer.LastName, customer.Email;

select View_Customer_Spending.CustomerId, View_Customer_Spending.FirstName, View_Customer_Spending.LastName, View_Customer_Spending.Email, Total_Spending
from View_Customer_Spending;

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
select track.TrackId, track.Name as Track_Name, album.Title as Album_Title, artist.Name as Artist_Name
from album join track on track.AlbumId = album.AlbumId
join artist on album.ArtistId = artist.ArtistId
where GenreId = GenreId_in;
end;
// DELIMITER //

call GetTracksByGenre(2);

-- 7
select * from album;
DELIMITER //
create procedure GetTrackCountByAlbum (IN p_AlbumId int)
begin
declare Total_Tracks int;
select count(TrackId) into Total_Tracks
from album join track on track.AlbumId = album.AlbumId
where album.AlbumId = p_AlbumId;
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
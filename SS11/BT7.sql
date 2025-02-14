USE chinook;

-- 2
create view View_Track_Details as
select t.TrackId, album.Title as Album_Title, artist.Name as Artist_Name, t.UnitPrice 
from album alb
join track t on alb.AlbumId = t.AlbumId
join artist art on alb.ArtistId = art.ArtistId
where t.UnitPrice > 0.99;

select * from View_Track_Details;

-- 3
create view View_Customer_Invoice as
select c.CustomerId, 
concat(e.LastName, '', e.FirstName) as FullName, 
e.Email, 
sum(i.Total) as Total_Spending, 
c.SupportRepId as Support_Rep
from customer c
join employee e on c.SupportRepId = e.EmployeeId
join invoice i on c.CustomerId = i.CustomerId
group by c.CustomerId, e.LastName, e.FirstName, e.Email, c.SupportRepId
having Total_Spending > 50;


select * from View_Customer_Invoice ;

-- 4
create view View_Top_Selling_Tracks as
select t.TrackId, t.Name as Track_Name, g.Name as Genre_Name, count(i.Quantity) as Total_Sales
from track t
join invoiceline i on i.TrackId = t.TrackId
join genre g on t.GenreId = g.GenreId
group by t.TrackId, t.Name, g.Name
having Total_Sales > 10;

select * from View_Top_Selling_Tracks ;

-- 5
create index idx_Track_Name on Track(Name);

select * from Track
where Name like '%Love%';

explain analyze select * from Track
where Name like '%Love%';
-- 6
create index idx_Invoice_Total on Invoice(Total);

select * from Invoice
where Total between 20 and 100;

explain analyze select * from Invoice
where Total between 20 and 100;
-- 7
DELIMITER //
create procedure GetCustomerSpending(CustomerId_in int)
begin
	select 
		c.CustomerId, 
		concat(e.LastName, '', e.FirstName) as FullName, 
		e.Email, 
		COALESCE(sum(i.Total))  as Total_Spending, 
		c.SupportRepId as Support_Rep
	from customer c
	left join employee e on c.SupportRepId = e.EmployeeId
	left join invoice i on c.CustomerId = i.CustomerId
    where c.CustomerId = CustomerId_in
	group by c.CustomerId, e.LastName, e.FirstName, e.Email, c.SupportRepId
	having Total_Spending > 50;
end;
// DELIMITER ;

call GetCustomerSpending(1); 

drop procedure if exists GetCustomerSpending;

-- 8
DELIMITER //

create procedure SearchTrackByKeyword(in p_Keyword varchar(200))
begin
    select * from Track use index (idx_Track_Name) 
    where Name like concat('%', p_Keyword, '%'); 
end;
// DELIMITER //

call SearchTrackByKeyword('lo');

-- 9
DELIMITER //
create procedure GetTopSellingTracks(IN p_MinSales int, IN p_MaxSales int)
begin
    select vt.TrackId, vt.Track_Name, v.Total_Sales
    from View_Top_Selling_Tracks v
    where v.Total_Sales between p_MinSales and p_MaxSales;  
end;
// DELIMITER //

call GetTopSellingTracks(300, 500);  

-- 10
drop view View_Track_Details;

drop view View_Customer_Invoice;

drop view View_Top_Selling_Tracks;

drop index idx_Track_Name on Track;

drop index idx_Invoice_Total on Invoice;

drop procedure if exists GetCustomerSpending;

drop procedure if exists SearchTrackByKeyword;

drop procedure if exists GetTopSellingTracks;
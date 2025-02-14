USE chinook;

-- 2
create view View_Track_Details as
select track.TrackId, album.Title as Album_Title, artist.Name as Artist_Name, track.UnitPrice 
from album join track on album.AlbumId = track.AlbumId
join artist on album.ArtistId = artist.ArtistId
where track.UnitPrice > 0.99;
select View_Track_Details.TrackId, View_Track_Details.Album_Title, View_Track_Details.Artist_Name, View_Track_Details.UnitPrice 
from View_Track_Details;

-- 3
create view View_Customer_Invoice as
select customer.CustomerId, 
concat(employee.LastName, '', employee.FirstName) as FullName, 
employee.Email, 
sum(invoice.Total) as Total_Spending, 
customer.SupportRepId as Support_Rep
from customer 
join employee on customer.SupportRepId = employee.EmployeeId
join invoice on customer.CustomerId = invoice.CustomerId
group by customer.CustomerId, employee.LastName, employee.FirstName, employee.Email, customer.SupportRepId
having Total_Spending > 50;


select vc.CustomerId, vc.FullName, vc.Email, vc.Total_Spending, vc.Support_Rep
from View_Customer_Invoice vc;

-- 4
create view View_Top_Selling_Tracks as
select track.TrackId, track.Name as Track_Name, genre.Name as Genre_Name, count(invoiceline.Quantity) as Total_Sales
from track join invoiceline on invoiceline.TrackId = track.TrackId
join genre on track.GenreId = genre.GenreId
group by track.TrackId, track.Name, genre.Name
having Total_Sales > 10;

select vt.TrackId, vt.Track_Name, vt.Genre_Name, vt.Total_Sales
from View_Top_Selling_Tracks vt;

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
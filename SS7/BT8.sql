
create database QLBH;

use QLBH;

CREATE TABLE Customer (
    cID INT PRIMARY KEY,
    Name VARCHAR(25) not null,
    cAge INT not null
);

CREATE TABLE Products (
    pID INT PRIMARY KEY,
    pName VARCHAR(25) not null,
    pPrice int not null
);

CREATE TABLE Orders (
    oID INT PRIMARY KEY,
    cID INT not null,
    oDate DATETIME not null,
    oTotalPrice INT,
    FOREIGN KEY (cID) REFERENCES Customer(cID)
);

CREATE TABLE Order_Detail (
    oID INT,
    pID INT,
    odQTY INT,
    PRIMARY KEY (oID, pID),
    FOREIGN KEY (oID) REFERENCES Orders(oID),
    FOREIGN KEY (pID) REFERENCES Products(pID)
);

INSERT INTO Customer (cID, Name, cAge) VALUES
(1, 'Minh Quan', 10), 
(2, 'Ngoc Oanh', 20), 
(3, 'Hong Ha', 50);

INSERT INTO Orders (oID, cID, oDate, oTotalPrice) VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

INSERT INTO Products (pID, pName, pPrice) VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

INSERT INTO Order_Detail (oID, pID, odQTY) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

-- 2  
select oid, cid, odate, ototalprice  
from orders  
order by odate desc;  

-- 3  
select pname, pprice  
from products  
where pprice = (select max(pprice) from products);  

-- 4  
select c.name as customername, p.pname as productname  
from customer c  
join orders o on c.cid = o.cid  
join order_detail od on o.oid = od.oid  
join products p on od.pid = p.pid  
order by c.cid, p.pname;  

-- 5  
select c.name as customername  
from customer c  
left join orders o on c.cid = o.cid  
where o.oid is null;  

-- 6  
select o.oid, o.odate, od.odqty, p.pname, p.pprice  
from orders o  
join order_detail od on o.oid = od.oid  
join products p on od.pid = p.pid  
order by o.oid, o.odate;  

-- 7  
select o.oid, o.odate, sum(od.odqty * p.pprice) as total  
from orders o  
join order_detail od on o.oid = od.oid  
join products p on od.pid = p.pid  
group by o.oid, o.odate  
order by total desc;  

-- 8  
-- xóa khóa ngoại  
alter table orders drop foreign key orders_ibfk_1;  
alter table order_detail drop foreign key order_detail_ibfk_1;  
alter table order_detail drop foreign key order_detail_ibfk_2;  

-- xóa khóa chính  
alter table customer drop primary key;  
alter table products drop primary key;  
alter table orders drop primary key;  
alter table order_detail drop primary key;  

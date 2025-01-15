insert into Employees (id , name ,date_in,salary)
values 
	(1,'Dung','2024-11-12',5000),
	(2,'A','2024-1-12',9000),
	(3,'B','2024-9-10',20000);
 
 update Employees 
 set salary =7000
 where id=1;
 
 delete from Employees
 where id=3;
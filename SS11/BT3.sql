USE session_11;
-- 2
delimiter // 
create procedure GetCustomerByPhone(in Phone_Number int )
begin 
	select CustomerID,FullName,DateOfBirth,Address,Email
    from Customers
    where Phone_Number= PhoneNumber;
end;

// delimiter ;
-- 3

delimiter // 
create procedure GetTotalBalance(in Customer_ID int, out TotalBalance int)
begin 
	set TotalBalance =(select sum(Balance) from Accounts where Customer_ID=CustomerID group by CustomerID );
end;

// delimiter ;

-- 4
delimiter // 
create procedure IncreaseEmployeeSalary(inout employeeId int , out newSalary int  )
begin 
	update Employees set salary =salary*1.1 where employeeId= EmployeeID;
    select salary  into newSalary 
        from Employees
        where EmployeeID=employeeId;
end;

// delimiter ;

-- 5
set @totalBalance =0;
set @newSalary =0;

call GetCustomerByPhone(0901234567);

call GetTotalBalance(1,@totalBalance);
select @totalBalance ;

call IncreaseEmployeeSalary(4,@newSalary);

drop procedure if exists IncreaseEmployeeSalary;
drop procedure if exists GetTotalBalance;
drop procedure if exists GetCustomerByPhone;
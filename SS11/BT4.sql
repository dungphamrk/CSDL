USE session_11;
-- 2
delimiter // 
create procedure UpdateSalaryByID(in emp_id int,out nowSalary decimal(20,2) )
begin 
	select Salary into nowSalary from Employees where EmployeeID = emp_id;
    if nowSalary < 20000000 then 
		set nowSalary=nowSalary*1.1;
    else 
		set nowSalary= nowSalary*1.05;
    end if;
    update Employees set Salary = nowSalary where EmployeeID = emp_id;
end;
 
// delimiter ;

-- 3
delimiter // 
create procedure GetLoanAmountByCustomerID(in cus_id int,out nowLoan decimal(20,2) )
begin 
	select 
    COALESCE(sum(LoanAmount),0) into nowLoan 
    from Loans
    where CustomerID = cus_id
    group by CustomerID;
end;

// delimiter ;

-- 4
delimiter // 
create procedure DeleteAccountIfLowBalance(in acc_id int )
begin 
	declare lowBalance int default 0;
	set @lowBalance= (select Balance from Accounts where AccountID= acc_id);
    if lowBalance <1000000 
    then 
		delete from Accounts where AccountID = acc_id ;
           SELECT 'Xóa thành công!' AS Message;
    else 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '❌ Lỗi: Không thể xóa!';
    end if;
end;
// delimiter ;

-- 5 
delimiter //
create procedure TransferMoney(
    in senderaccountid int,
    in receiveraccountid int,
    inout amount decimal(10, 2)
)
begin
    declare senderbalance decimal(10, 2);
    select balance into senderbalance
    from accounts
    where accountid = senderaccountid;
    if senderbalance >= amount then
        update accounts
        set balance = balance - amount
        where accountid = senderaccountid;

        update accounts
        set balance = balance + amount
        where accountid = receiveraccountid;
    else
        set amount = 0;
    end if;
end;
// delimiter ;



-- 6

set @testSalary=0;
call UpdateSalaryByID(4, @testSalary);
select @testSalary;

set @testLoan=0;
call GetLoanAmountByCustomerID(1, @testLoan);
select @testLoan;

call DeleteAccountIfLowBalance(3);

set @amount = 2000000; 
call TransferMoney(1, 2, @amount);  
select @amount as TransferMoney;  

drop procedure if exists UpdateSalaryByID;
drop procedure if exists GetLoanAmountByCustomerID;
drop procedure if exists DeleteAccountIfLowBalance;
drop procedure if exists TransferMoney;
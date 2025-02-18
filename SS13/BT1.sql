create database ss13;
use ss13;
create table accounts(
	account_id int primary key auto_increment,
    account_name varchar(50) ,
    balance decimal(10,2)
);

INSERT INTO accounts (account_name, balance) VALUES 
('Nguyễn Văn An', 1000.00),
('Trần Thị Bảy', 500.00);

set autocomit=0;
delimiter //  
create procedure transfer_money(in from_account int,in to_account int , in amount decimal(10,2))
	begin 	
    declare balance_check decimal(10,2);
    select balance into balance_check from accounts where account_id = from_account;
	  if (select count(account_id) from accounts where account_id = from_account) = 0
		or (select count(account_id) from accounts where account_id = to_account) = 0 then
        rollback;
	else
		if balance_check >= amount then
			update accounts set balance = balance - amount where account_id = from_account;
			update accounts set balance = balance + amount where account_id = to_account;
			commit ;
		else 
			rollback;
		end if;
	end if;
    end ;
// delimiter ;
drop procedure if exists transfer_money;
call transfer_money(1, 2, 200.00);
select * from accounts;


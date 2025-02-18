use ss13;

CREATE TABLE company_funds (
    fund_id INT PRIMARY KEY AUTO_INCREMENT,
    balance DECIMAL(15,2) NOT NULL -- Số dư quỹ công ty
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50) NOT NULL,   -- Tên nhân viên
    salary DECIMAL(10,2) NOT NULL    -- Lương nhân viên
);

CREATE TABLE payroll (
    payroll_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,                      -- ID nhân viên (FK)
    salary DECIMAL(10,2) NOT NULL,   -- Lương được nhận
    pay_date DATE NOT NULL,          -- Ngày nhận lương
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE transaction_log  (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_message TEXT NOT NULL,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE employees ADD COLUMN last_pay_date DATE NULL;
INSERT INTO company_funds (balance) VALUES (50000.00);

INSERT INTO employees (emp_name, salary) VALUES
('Nguyễn Văn An', 5000.00),
('Trần Thị Bốn', 4000.00),
('Lê Văn Cường', 3500.00),
('Hoàng Thị Dung', 4500.00),
('Phạm Văn Em', 3800.00);

set autocomit=0;
delimiter //
create procedure payment_salary(in employeeID int ,in fundID int )
begin
	declare com_balance decimal;
    declare emp_salary decimal;
	start transaction;
	if (select counte(emp_id) from employees where emp_id =employeeID) = 0 
		or (select counte(fund_id) from company_funds where fund_id =fundID) = 0
	then	
			insert into transaction_log(log_mesage)
			values('Mã nhân viên hoặc mã công ty ko tồn tại');
			rollback;
	else
		select balance into com_balance from company_funds where fund_id =fundID ;
        select salary into emp_salary from employees where employees =employeeID ;
		if com_balance < emp_salary
        then 
			insert into transaction_log(log_mesage)
			values('Tiền ko đủ trả lương cho nhân viên');
		else
			update company_funds set balance =com_balance-emp_salary;
            
            insert into payroll(emp_id ,salary ,pay_date )
            values (employeeID , emp_salary, curdate());
            
			insert into transaction_log(log_mesage)
			values('Đã gửi lương thành công');
            commit ;
        end if;
	end if;
end;

// delimiter ;


CALL payment_salary(1,1);

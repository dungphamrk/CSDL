USE session_11;
-- 2
create index Single_column on Customers(PhoneNumber);

EXPLAIN SELECT * FROM Customers WHERE PhoneNumber = '0901234567';
-- 3
create index Composite on Employees(BranchID, Salary);
-- index vẫn đc sử dụng
EXPLAIN SELECT * FROM Employees WHERE BranchID = 1 AND Salary > 20000000;

-- 4
create unique index Unique_Index on Accounts(AccountID, CustomerID);

-- 5
show index from Accounts;
show index from Customers;
show index from Employees;

-- 6

drop index Unique_Index on Accounts;
drop index Single_column on Customers;
drop index Composite on Employees;
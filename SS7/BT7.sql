-- Tạo database và sử dụng
CREATE DATABASE BT7;
use BT7;

-- Tạo bảng Student (Sinh viên)
CREATE TABLE Student (
    RN INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(20) NOT NULL UNIQUE,
    Age TINYINT NOT NULL
);

-- Tạo bảng Test (Bài kiểm tra)
CREATE TABLE Test (
    TestID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(20) NOT NULL UNIQUE
);

-- Tạo bảng StudentTest (Bảng điểm sinh viên)
CREATE TABLE StudentTest (
    RN INT NOT NULL,
    TestID INT NOT NULL,
    Date DATE,
    Mark FLOAT,
    PRIMARY KEY(RN, TestID),
    FOREIGN KEY(RN) REFERENCES Student(RN),
    FOREIGN KEY(TestID) REFERENCES Test(TestID)
);

-- Thêm ràng buộc UNIQUE vào bảng Student và Test
ALTER TABLE Student ADD CONSTRAINT UniqueNames UNIQUE (Name);
ALTER TABLE Test ADD CONSTRAINT UniqueTestNames UNIQUE (Name);

-- Thêm ràng buộc UNIQUE cho cặp (RN, TestID) trong bảng StudentTest
ALTER TABLE StudentTest ADD CONSTRAINT RNTestIDUnique UNIQUE KEY (RN, TestID);

-- Thêm cột Status vào bảng Student
ALTER TABLE Student ADD COLUMN Status VARCHAR(10); 

-- Thêm ràng buộc xóa dữ liệu liên quan khi sinh viên hoặc bài kiểm tra bị xóa
ALTER TABLE StudentTest DROP FOREIGN KEY StudentTest_ibfk_1;
ALTER TABLE StudentTest ADD CONSTRAINT StudentTest_ibfk_1 FOREIGN KEY (RN) REFERENCES Student(RN) ON DELETE CASCADE;
ALTER TABLE StudentTest DROP FOREIGN KEY StudentTest_ibfk_2;
ALTER TABLE StudentTest ADD CONSTRAINT StudentTest_ibfk_2 FOREIGN KEY (TestID) REFERENCES Test(TestID) ON DELETE CASCADE;

-- Chèn dữ liệu vào bảng Student
INSERT INTO Student (RN, Name, Age) VALUES 
(1, 'Nguyen Hong Ha', 20),
(2, 'Trung Ngoc Anh', 30),
(3, 'Tuan Minh', 25),
(4, 'Dan Truong', 22);

-- Chèn dữ liệu vào bảng Test
INSERT INTO Test (TestID, Name) VALUES 
(1, 'EPC'),
(2, 'DWMX'),
(3, 'SQL1'),
(4, 'SQL2');

-- Chèn dữ liệu vào bảng StudentTest
INSERT INTO StudentTest (RN, TestID, Date, Mark) 
VALUES 
(1, 1, '2006-07-17', 8),
(1, 2, '2006-07-18', 5),
(1, 3, '2006-07-19', 7),
(2, 1, '2006-07-17', 7),
(2, 2, '2006-07-18', 4),
(2, 3, '2006-07-19', 2),
(3, 1, '2006-07-17', 10),
(3, 2, '2006-07-18', 1);

-- lấy danh sách sinh viên kèm theo mã bài kiểm tra, tuổi, ngày kiểm tra, điểm, sắp xếp theo điểm giảm dần
select s.name, st.testid as mathi, s.age, st.date, st.mark 
from student s 
join studenttest st on s.rn = st.rn 
order by st.mark desc;

-- lấy danh sách sinh viên chưa tham gia bài kiểm tra nào
select s.name, s.rn, s.age 
from student s 
where not exists (
    select 1 from studenttest st where st.rn = s.rn
);

-- lấy danh sách sinh viên có điểm dưới 5
select s.name, s.rn, s.age, st.testid as mathi, st.mark 
from student s 
join studenttest st on s.rn = st.rn 
where st.mark < 5;

-- tính điểm trung bình của mỗi sinh viên
select s.name, round(avg(st.mark), 2) as averagemark
from student s 
join studenttest st on s.rn = st.rn 
group by s.name
order by averagemark desc;

-- lấy sinh viên có điểm trung bình cao nhất
select s.name, round(avg(st.mark), 2) as averagemark
from student s 
join studenttest st on s.rn = st.rn 
group by s.name 
order by averagemark desc 
limit 1;

-- lấy bài kiểm tra có điểm cao nhất
select st.testid, max(st.mark) as maxmark
from studenttest st 
group by st.testid 
order by maxmark desc;

-- tăng tuổi của tất cả sinh viên thêm 1
update student 
set age = age + 1;

-- cập nhật trạng thái sinh viên: 'young' nếu dưới 30 tuổi, 'old' nếu từ 30 tuổi trở lên
update student 
set status = case 
    when age < 30 then 'young' 
    else 'old' 
end;

-- sắp xếp bảng điểm theo ngày kiểm tra
select * from studenttest order by date asc;

-- lấy danh sách sinh viên có tên bắt đầu bằng 't' và điểm trên 4.5
select s.name, s.rn, s.age, st.mark 
from student s 
join studenttest st on s.rn = st.rn 
where s.name like 't%' and st.mark > 4.5;

-- lấy danh sách sinh viên và điểm số, sắp xếp theo tên, tuổi, điểm tăng dần
select s.name, s.age, st.mark 
from student s 
join studenttest st on s.rn = st.rn 
order by s.name, s.age, st.mark asc;

-- xóa bài kiểm tra không có sinh viên nào tham gia
delete from test 
where testid not in (select distinct testid from studenttest);

-- xóa tất cả bài kiểm tra có điểm dưới 5
delete from studenttest where mark < 5;


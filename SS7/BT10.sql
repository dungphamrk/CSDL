CREATE DATABASE QuanLySinhVien;
USE QuanLySinhVien;

CREATE TABLE students (
    studentid INT PRIMARY KEY,
    studentName VARCHAR(50),
    age INT,
    email VARCHAR(100)
);

CREATE TABLE subjects (
    subjectid INT PRIMARY KEY,
    subjectName VARCHAR(50)
);

CREATE TABLE class (
    classid INT PRIMARY KEY,
    className VARCHAR(50)
);

CREATE TABLE marks (
    subject_id INT,
    student_id INT,
    mark INT,
    PRIMARY KEY (subject_id, student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subjectid),
    FOREIGN KEY (student_id) REFERENCES students(studentid)
);

CREATE TABLE classStudent (
    studentid INT,
    classid INT,
    PRIMARY KEY (studentid, classid),
    FOREIGN KEY (studentid) REFERENCES students(studentid),
    FOREIGN KEY (classid) REFERENCES class(classid)
);

INSERT INTO subjects (subjectid, subjectName) VALUES
(1, 'SQL'),
(2, 'Java'),
(3, 'C'),
(4, 'Visual Basic');


INSERT INTO marks (mark, subject_id, student_id) VALUES
(8, 1, 1),
(4, 2, 1),
(9, 1, 3),
(7, 1, 3),
(3, 3, 1),
(5, 3, 3),
(8, 3, 5),
(3, 2, 4);

INSERT INTO students (studentid, studentName, age, email) VALUES
(1, 'Nguyen Quang An', 18, 'an@yahoo.com'),
(2, 'Nguyen Cong Vinh', 20, 'vinh@gmail.com'),
(3, 'Nguyen Van Quyen', 19, 'quyen'),
(4, 'Pham Thanh Binh', 25, 'binh@com'),
(5, 'Nguyen Van Tai Em', 30, 'taien@sport.vn');


INSERT INTO class (classid, className) VALUES
(1, 'C0706L'),
(2, 'C0708G');


INSERT INTO classStudent (studentid, classid) VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 1),
(4, 2),
(5, 1);


-- hiển thị danh sách tất cả các học viên  
select * from students;  

-- hiển thị danh sách tất cả các môn học  
select * from subjects;  

-- tính điểm trung bình của từng học sinh  
select student_id, avg(mark) as avg_mark  
from marks  
group by student_id;  

-- hiển thị môn học có học sinh thi được trên 9 điểm  
select m.student_id, s.subjectname, m.mark  
from marks m  
join subjects s on m.subject_id = s.subjectid  
where m.mark > 9;  

-- hiển thị điểm trung bình của từng học sinh theo chiều giảm dần  
select student_id, avg(mark) as avg_mark  
from marks  
group by student_id  
order by avg_mark desc;  

-- cập nhật thêm dòng chữ "day la mon hoc" vào trước các bản ghi trên cột subjectname  
update subjects  
set subjectname = concat('day la mon hoc ', subjectname);  

-- viết trigger để kiểm tra độ tuổi nhập vào trong bảng students yêu cầu age > 15 và age < 50  
delimiter //  
create trigger check_student_age  
before insert on students  
for each row  
begin  
    if new.age <= 15 or new.age >= 50 then  
        signal sqlstate '45000'  
        set message_text = 'tuổi của học viên phải lớn hơn 15 và nhỏ hơn 50!';  
    end if;  
end;  
//  
delimiter ;  

-- loại bỏ quan hệ giữa tất cả các bảng (xóa ràng buộc khóa ngoại)  
alter table marks drop foreign key marks_ibfk_1;  
alter table marks drop foreign key marks_ibfk_2;  
alter table classstudent drop foreign key classstudent_ibfk_1;  
alter table classstudent drop foreign key classstudent_ibfk_2;  

-- xóa học viên có studentid = 1  
delete from students where studentid = 1;  

-- thêm cột status vào bảng students (kiểu dữ liệu bit, mặc định là 1)  
alter table students add column status bit default 1;  

-- cập nhật giá trị status trong bảng students thành 0  
update students set status = 0;  

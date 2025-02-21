CREATE DATABASE demo;
USE demo;
CREATE TABLE students(
	student_id int primary key auto_increment,
    student_name varchar(100),
    student_Math_Score int,
    student_Physical_Score int,
    student_Chemistry_Score int,
    student_rate varchar(50)
);

delimiter //
CREATE PROCEDURE rate_student ()
BEGIN
	DECLARE isFinished INT DEFAULT 0;
	DECLARE st_id int ;
    DECLARE st_name varchar (100);
	DECLARE st_Math_Score int;
	DECLARE st_Physical_Score int;
	DECLARE st_Chemistry_Score int;
	DECLARE st_rate varchar (100);
    DECLARE st_avg int;
	DECLARE cursor_students CURSOR FOR
		SELECT student_id, student_name,student_Math_Score ,student_Physical_Score ,
				student_Chemistry_Score ,student_rate FROM students;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET isFinished = 1;
	OPEN cursor_students;	
    rate_loop: LOOP
		FETCH cursor_students INTO st_id,st_name,st_Math_Score,st_Physical_Score,st_Chemistry_Score,st_rate;
        IF isFinished THEN
			LEAVE rate_loop;
        END IF;
        SET st_avg =(st_Math_Score+st_Physical_Score+st_Chemistry_Score)/3;
		IF st_avg< 5 THEN 
			UPDATE students  SET student_rate = 'yếu' WHERE student_id=st_id;
		ELSEIF st_avg< 7 THEN 
			UPDATE students  SET student_rate ='trung bình' WHERE student_id=st_id;
		ELSEIF st_avg< 8 THEN 
			UPDATE students  SET student_rate ='Khá' WHERE student_id=st_id;
		ELSEIF st_avg< 9 THEN 
			UPDATE students  SET student_rate ='Giỏi' WHERE student_id=st_id;
		ELSE 
			UPDATE students  SET student_rate ='Xuất sắc' WHERE student_id=st_id;
		END IF;
    end loop rate_loop;
    close cursor_students;
END ;
// delimiter ;


INSERT INTO students (student_name, student_Math_Score, student_Physical_Score, student_Chemistry_Score, student_rate) VALUES
('Nguyễn Văn A', 9, 8, 10, 'a'),
('Trần Thị B', 6, 7, 5, 'a'),
('Lê Văn C', 4, 5, 6, 'a'),
('Phạm Thị D', 7, 8, 7, 'a'),
('Hoàng Văn E', 10, 10, 9, 'a'),
('Vũ Thị F', 3, 4, 5, 'a'),
('Bùi Văn G', 6, 5, 7, 'a'),
('Đặng Thị H', 8, 9, 8, 'a'),
('Ngô Văn I', 5, 6, 5, 'a'),
('Đỗ Thị J', 7, 7, 8, 'a');
SELECT * from students;
drop procedure IF EXISTS rate_student;
call rate_student();


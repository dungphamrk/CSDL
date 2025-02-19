use ss13;
-- 2
CREATE TABLE student_status (
    student_id INT PRIMARY KEY,
    status ENUM('ACTIVE', 'GRADUATED', 'SUSPENDED') NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- 3
INSERT INTO student_status (student_id, status) VALUES
(1, 'ACTIVE'),    -- Nguyễn Văn An có thể đăng ký
(2, 'GRADUATED'); -- Trần Thị Ba đã tốt nghiệp, không thể đăng ký

-- 4
DELIMITER //

CREATE PROCEDURE RegisterCourse(IN p_student_name VARCHAR(50), IN p_course_name VARCHAR(100))
BEGIN
    DECLARE v_student_id INT;
    DECLARE v_course_id INT;
    DECLARE v_status VARCHAR(20);
    DECLARE v_already_enrolled INT;
    DECLARE v_available_seats INT;
    DECLARE v_error_message VARCHAR(255);

    -- Bắt đầu transaction
    START TRANSACTION;

    -- Kiểm tra sinh viên có tồn tại không
    SELECT student_id INTO v_student_id FROM students WHERE student_name = p_student_name;
    IF v_student_id IS NULL THEN
        SET v_error_message = 'FAILED: Student does not exist';
        INSERT INTO enrollment_history (student_name, course_name, status, log_time) 
        VALUES (p_student_name, p_course_name, v_error_message, NOW());
        ROLLBACK;
        LEAVE;
    END IF;

    -- Kiểm tra môn học có tồn tại không
    SELECT course_id, available_seats INTO v_course_id, v_available_seats FROM courses WHERE course_name = p_course_name;
    IF v_course_id IS NULL THEN
        SET v_error_message = 'FAILED: Course does not exist';
        INSERT INTO enrollment_history (student_name, course_name, status, log_time) 
        VALUES (p_student_name, p_course_name, v_error_message, NOW());
        ROLLBACK;
        LEAVE;
    END IF;

    -- Kiểm tra sinh viên đã đăng ký môn học chưa
    SELECT COUNT(*) INTO v_already_enrolled FROM enrollments WHERE student_id = v_student_id AND course_id = v_course_id;
    IF v_already_enrolled > 0 THEN
        SET v_error_message = 'FAILED: Already enrolled';
        INSERT INTO enrollment_history (student_name, course_name, status, log_time) 
        VALUES (p_student_name, p_course_name, v_error_message, NOW());
        ROLLBACK;
        LEAVE;
    END IF;

    -- Kiểm tra trạng thái của sinh viên
    SELECT status INTO v_status FROM student_status WHERE student_id = v_student_id;
    IF v_status = 'GRADUATED' OR v_status = 'SUSPENDED' THEN
        SET v_error_message = 'FAILED: Student not eligible';
        INSERT INTO enrollment_history (student_name, course_name, status, log_time) 
        VALUES (p_student_name, p_course_name, v_error_message, NOW());
        ROLLBACK;
        LEAVE;
    END IF;

    -- Kiểm tra môn học còn chỗ trống không
    IF v_available_seats <= 0 THEN
        SET v_error_message = 'FAILED: No available seats';
        INSERT INTO enrollment_history (student_name, course_name, status, log_time) 
        VALUES (p_student_name, p_course_name, v_error_message, NOW());
        ROLLBACK;
        LEAVE;
    END IF;

    -- Thêm sinh viên vào bảng enrollments
    INSERT INTO enrollments (student_id, course_id, enroll_date) 
    VALUES (v_student_id, v_course_id, NOW());

    -- Giảm số chỗ trống của môn học đi 1
    UPDATE courses SET available_seats = available_seats - 1 WHERE course_id = v_course_id;

    -- Ghi lại lịch sử đăng ký
    INSERT INTO enrollment_history (student_name, course_name, status, log_time) 
    VALUES (p_student_name, p_course_name, 'REGISTERED', NOW());

    -- Commit transaction
    COMMIT;
END //

DELIMITER ;
-- 5
CALL RegisterCourse('Nguyễn Văn An', 'Lập trình C++');
CALL RegisterCourse('Nguyễn Văn An', 'Môn không tồn tại');
CALL RegisterCourse('Không có sinh viên', 'Lập trình C++');
-- 6
SELECT * FROM enrollments;
SELECT * FROM courses;
SELECT * FROM enrollment_history;
use ss13;
-- 2
CREATE TABLE banks (
    bank_id INT PRIMARY KEY AUTO_INCREMENT,
    bank_name VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL
);
-- 3
INSERT INTO banks (bank_id, bank_name, status) VALUES 
(1, 'VietinBank', 'ACTIVE'),   
(2, 'Sacombank', 'ERROR'),    
(3, 'Agribank', 'ACTIVE');
-- 4
ALTER TABLE company_funds 
ADD COLUMN bank_id INT,
ADD CONSTRAINT fk_bank FOREIGN KEY (bank_id) REFERENCES banks(bank_id);
-- 5
UPDATE company_funds SET bank_id = 1 WHERE balance = 50000.00;

INSERT INTO company_funds (balance, bank_id) VALUES (45000.00, 2);
-- 6
DELIMITER //

CREATE TRIGGER CheckBankStatus
BEFORE INSERT ON payroll
FOR EACH ROW
BEGIN
    DECLARE v_bank_status VARCHAR(20);

    -- Lấy trạng thái ngân hàng từ company_funds
    SELECT b.status INTO v_bank_status 
    FROM company_funds cf
    JOIN banks b ON cf.bank_id = b.bank_id
    WHERE cf.bank_id = NEW.bank_id
    LIMIT 1;

    -- Nếu trạng thái là ERROR, ngăn chặn giao dịch
    IF v_bank_status = 'ERROR' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ngân hàng đang gặp sự cố. Giao dịch bị hủy.';
    END IF;
END //

DELIMITER ;
-- 7
DELIMITER //

CREATE PROCEDURE TransferSalary(IN p_emp_id INT)
BEGIN
    DECLARE v_salary DECIMAL(10,2);
    DECLARE v_balance DECIMAL(10,2);
    DECLARE v_bank_status VARCHAR(20);
    DECLARE v_company_bank_id INT;
    DECLARE v_employee_exists INT DEFAULT 0;
    DECLARE v_error_message VARCHAR(255);

    -- Bắt đầu transaction
    START TRANSACTION;

    -- Kiểm tra nhân viên tồn tại
    SELECT COUNT(*) INTO v_employee_exists FROM employees WHERE emp_id = p_emp_id;
    IF v_employee_exists = 0 THEN
        SET v_error_message = 'Nhân viên không tồn tại';
        ROLLBACK;
        INSERT INTO transaction_log (emp_id, log_message) VALUES (p_emp_id, v_error_message);
        LEAVE;
    END IF;

    -- Lấy thông tin quỹ công ty và trạng thái ngân hàng
    SELECT cf.balance, cf.bank_id, b.status INTO v_balance, v_company_bank_id, v_bank_status
    FROM company_funds cf
    JOIN banks b ON cf.bank_id = b.bank_id
    WHERE cf.bank_id = (SELECT bank_id FROM employees WHERE emp_id = p_emp_id)
    LIMIT 1;

    -- Kiểm tra trạng thái ngân hàng
    IF v_bank_status = 'ERROR' THEN
        SET v_error_message = 'Ngân hàng có lỗi. Giao dịch bị hủy.';
        ROLLBACK;
        INSERT INTO transaction_log (emp_id, log_message) VALUES (p_emp_id, v_error_message);
        LEAVE;
    END IF;

    -- Lấy mức lương nhân viên
    SELECT salary INTO v_salary FROM employees WHERE emp_id = p_emp_id;

    -- Kiểm tra quỹ công ty có đủ tiền không
    IF v_balance < v_salary THEN
        SET v_error_message = 'Quỹ công ty không đủ tiền.';
        ROLLBACK;
        INSERT INTO transaction_log (emp_id, log_message) VALUES (p_emp_id, v_error_message);
        LEAVE;
    END IF;

    -- Trừ lương từ quỹ công ty
    UPDATE company_funds SET balance = balance - v_salary WHERE bank_id = v_company_bank_id;

    -- Thêm bản ghi vào bảng payroll
    INSERT INTO payroll (emp_id, amount, pay_date, bank_id) 
    VALUES (p_emp_id, v_salary, NOW(), v_company_bank_id);

    -- Cập nhật ngày trả lương trong bảng employees
    UPDATE employees SET last_pay_date = NOW() WHERE emp_id = p_emp_id;

    -- Ghi log thành công
    INSERT INTO transaction_log (emp_id, log_message) 
    VALUES (p_emp_id, 'Lương đã được chuyển thành công');

    -- Commit transaction
    COMMIT;
END //

DELIMITER ;
-- 8
CALL TransferSalary(1);
-- 9
SELECT * FROM company_funds;
SELECT * FROM payroll;
SELECT * FROM employees;
SELECT * FROM transaction_log;
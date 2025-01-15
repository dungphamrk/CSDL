/*
		1. Thiếu khóa chính (PRIMARY KEY):
        - Cần chọn masv (mã sinh viên) làm khóa chính vì đây là giá trị duy nhất để xác định mỗi sinh viên.
        2. Cột masv không có ràng buộc NOT NULL:
        - Cột masv không được để trống vì nó là khóa chính và cần thiết để nhận diện từng bản ghi.
        3. Cột diem không có ràng buộc kiểm tra giá trị (CHECK):
        - Giá trị diem cần giới hạn trong khoảng hợp lệ (0 đến 10) để đảm bảo dữ liệu đúng.
*/
create table point (
    studentId varchar(20) not null,     
    point int not null,             
    primary key (studentId),            
    check (point >= 0 and point <= 10) 
);
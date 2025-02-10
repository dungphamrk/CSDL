CREATE DATABASE TicketFilm;
USE TicketFilm;
CREATE TABLE tblPhim (
    PhimID INT PRIMARY KEY AUTO_INCREMENT,
    Ten_phim NVARCHAR(30),
    Loai_phim NVARCHAR(25),
    Thoi_gian INT
);

CREATE TABLE tblPhong (
    PhongID INT PRIMARY KEY AUTO_INCREMENT,
    Ten_phong NVARCHAR(20),
    Trang_thai TINYINT
);

CREATE TABLE tblGhe (
    GheID INT PRIMARY KEY AUTO_INCREMENT,
    PhongID INT,
    So_ghe VARCHAR(10),
    FOREIGN KEY (PhongID) REFERENCES tblPhong(PhongID) ON DELETE CASCADE
);

CREATE TABLE tblVe (
    PhimID INT,
    GheID INT,
    Ngay_chieu DATETIME,
    Trang_thai NVARCHAR(20),
    FOREIGN KEY (PhimID) REFERENCES tblPhim(PhimID) ON DELETE CASCADE,
    FOREIGN KEY (GheID) REFERENCES tblGhe(GheID) ON DELETE CASCADE
);
INSERT INTO tblPhim (Ten_phim, Loai_phim, Thoi_gian) VALUES
('Em bé Hà Nội', 'Tâm lý', 90),
('Nhiệm vụ bất khả thi', 'Hành động', 100),
('Dị nhân', 'Viễn tưởng', 90),
('Cuốn theo chiều gió', 'Tình cảm', 120);

INSERT INTO tblPhong (Ten_phong, Trang_thai) VALUES
('Phòng chiếu 1', 1),
('Phòng chiếu 2', 1),
('Phòng chiếu 3', 0);

INSERT INTO tblGhe (PhongID, So_ghe) VALUES
(1, 'A3'),
(1, 'B5'),
(2, 'A7'),
(2, 'D1'),
(3, 'T2');

INSERT INTO tblVe (PhimID, GheID, Ngay_chieu, Trang_thai) VALUES
(1, 1, '2008-10-20', 'Đã bán'),
(1, 3, '2008-11-20', 'Đã bán'),
(1, 4, '2008-12-23', 'Đã bán'),
(2, 1, '2009-02-14', 'Đã bán'),
(3, 1, '2009-02-14', 'Đã bán'),
(2, 5, '2009-03-08', 'Chưa bán'),
(2, 3, '2009-03-08', 'Chưa bán');
-- 1  
select * from tblphim order by thoi_gian;  

-- 2  
select ten_phim from tblphim order by thoi_gian desc limit 1;  

-- 3  
select ten_phim from tblphim order by thoi_gian asc limit 1;  

-- 4  
select so_ghe from tblghe where so_ghe like 'a%';  

-- 5  
alter table tblphong modify column trang_thai varchar(25);  

-- 6  
delimiter //  
create procedure updateandshowphong()  
begin  
    update tblphong   
    set trang_thai = case   
        when trang_thai = '0' then 'đang sửa'  
        when trang_thai = '1' then 'đang sử dụng'  
        else 'unknown'  
    end;  
      
    select * from tblphong;  
end //  
delimiter ;  
call updateandshowphong();  

-- 7  
select ten_phim from tblphim where length(ten_phim) > 15 and length(ten_phim) < 25;  

-- 8  
select concat(ten_phong, ' - ', trang_thai) as 'trạng thái phòng chiếu' from tblphong;  

-- 9  
create view tblrank as  
select row_number() over (order by ten_phim) as stt, ten_phim, thoi_gian from tblphim;  

-- 10  
alter table tblphim add column mo_ta nvarchar(255);  

-- 11  
update tblphim set mo_ta = concat('đây là film thể loại ', loai_phim);  
select * from tblphim;  

-- 12  
update tblphim set mo_ta = replace(mo_ta, 'film', 'phim');  
select * from tblphim;  

-- 13  
alter table tblghe drop foreign key tblghe_ibfk_1;  
alter table tblve drop foreign key tblve_ibfk_1;  
alter table tblve drop foreign key tblve_ibfk_2;  

-- 14  
delete from tblghe;  

-- 15  
select ngay_chieu, date_add(ngay_chieu, interval 5000 minute) as 'ngày chiếu +5000 phút' from tblve;  

create database Bonus;
use Bonus;

create table Categories(
	catalog_id INT PRIMARY KEY auto_increment,
    catalog_name varchar(100) not null unique,
    catalog_priority INT,
    catalog_description text,
    catalog_status bit default(1)
);
create table User_status(
	status_id int auto_increment primary key,
    status_name varchar(100),
    status_description text
);
create table Web_user (
	user_id int auto_increment primary key,
    user_name varchar(100) not null unique,
    user_password varchar(100) not null,
    user_avatar text,	
    user_email varchar(100) not null unique,
    user_phone varchar(15) not null unique,
    user_address text,
    user_status int not null unique,
    foreign key (user_status) references User_status(status_id)
);


create table Product(
	product_id char(5) primary key not null,
    product_name varchar(100) not null unique,
    product_price float not null check(product_price>0),
    product_title varchar(200) not null,
    product_description text not null,
    product_image text,
    product_status bit default(1),
    catalog_id int not null,
    foreign key (catalog_id) references Categories(catalog_id)
);
create table Orders(
	order_id int primary key auto_increment,
    user_email varchar(100) not null unique,
    user_phone varchar(15) not null unique,
    user_address text,
    user_created date,
    order_status int not null unique,
    user_id int not null,
    foreign key (user_id) references Web_user(user_id),
    foreign key (order_status) references User_status(status_id)
);

create table Order_Detail(
	order_price float not null,
    product_id char(5) not null  ,
    order_id int not null ,
    PRIMARY KEY (product_id,order_id),
    foreign  key (product_id) references Product(product_id),
    foreign  key (order_id) references Orders(order_id)
);


INSERT INTO Categories (catalog_name, catalog_priority, catalog_description, catalog_status) VALUES
('Điện thoại', 1, 'Danh mục điện thoại', 1),
('Laptop', 2, 'Danh mục laptop', 1),
('Máy tính bảng', 3, 'Danh mục máy tính bảng', 1),
('Phụ kiện', 4, 'Danh mục phụ kiện', 1),
('Âm thanh', 5, 'Danh mục loa tai nghe', 1),
('Màn hình', 6, 'Danh mục màn hình', 1),
('Thiết bị mạng', 7, 'Danh mục thiết bị mạng', 1),
('Camera', 8, 'Danh mục camera an ninh', 1),
('Thiết bị văn phòng', 9, 'Danh mục máy in, máy chiếu', 1),
('Gaming', 10, 'Danh mục gaming gear', 1);


INSERT INTO User_status (status_name, status_description) VALUES
('Hoạt động', 'Người dùng đang hoạt động'),
('Bị khóa', 'Người dùng bị khóa tài khoản'),
('Chờ xác minh', 'Người dùng đang chờ xác minh'),
('Tạm ngưng', 'Người dùng tạm ngưng hoạt động'),
('Xóa', 'Người dùng đã xóa tài khoản'),
('Chờ duyệt', 'Người dùng chờ duyệt'),
('Bảo lưu', 'Người dùng bảo lưu tài khoản'),
('Hạn chế', 'Người dùng bị hạn chế tính năng'),
('Khách hàng VIP', 'Người dùng VIP'),
('Quản trị viên', 'Người dùng có quyền quản trị');


INSERT INTO Web_user (user_name, user_password, user_avatar, user_email, user_phone, user_address, user_status) VALUES
('nguyenvana', '123456', 'avatar1.jpg', 'nguyenvana@gmail.com', '0987654321', 'Hà Nội', 1),
('tranthib', 'abcdef', 'avatar2.jpg', 'tranthib@gmail.com', '0976543210', 'TP HCM', 2),
('leminhc', 'pass123', 'avatar3.jpg', 'leminhc@gmail.com', '0965432109', 'Đà Nẵng', 3),
('phamvand', 'hello123', 'avatar4.jpg', 'phamvand@gmail.com', '0954321098', 'Hải Phòng', 4),
('hoangthie', 'test456', 'avatar5.jpg', 'hoangthie@gmail.com', '0943210987', 'Cần Thơ', 5),
('buidinhf', 'pass789', 'avatar6.jpg', 'buidinhf@gmail.com', '0932109876', 'Huế', 6),
('dangthig', 'abc123', 'avatar7.jpg', 'dangthig@gmail.com', '0921098765', 'Nha Trang', 7),
('trinhvank', 'qwerty', 'avatar8.jpg', 'trinhvank@gmail.com', '0910987654', 'Vũng Tàu', 8),
('lythiho', 'secure456', 'avatar9.jpg', 'lythiho@gmail.com', '0909876543', 'Biên Hòa', 9),
('phandinhj', 'password', 'avatar10.jpg', 'phandinhj@gmail.com', '0898765432', 'Quảng Ninh', 10);

INSERT INTO Product (product_id, product_name, product_price, product_title, product_description, product_image, product_status, catalog_id) VALUES
('P0001', 'iPhone 15', 25000000, 'iPhone 15 Pro Max', 'Điện thoại cao cấp của Apple', 'iphone15.jpg', 1, 1),
('P0002', 'MacBook Pro', 35000000, 'MacBook Pro 16 inch', 'Laptop mạnh mẽ của Apple', 'macbookpro.jpg', 1, 2),
('P0003', 'iPad Air', 15000000, 'iPad Air 2023', 'Máy tính bảng Apple', 'ipadair.jpg', 1, 3),
('P0004', 'AirPods Pro', 5000000, 'Tai nghe không dây', 'Tai nghe Apple chất lượng cao', 'airpodspro.jpg', 1, 5),
('P0005', 'Apple Watch', 12000000, 'Apple Watch Ultra', 'Đồng hồ thông minh của Apple', 'applewatch.jpg', 1, 4),
('P0006', 'Samsung S23', 20000000, 'Điện thoại Samsung S23', 'Điện thoại cao cấp của Samsung', 'samsungs23.jpg', 1, 1),
('P0007', 'Dell XPS 15', 30000000, 'Laptop Dell cao cấp', 'Laptop hiệu suất cao của Dell', 'dellxps.jpg', 1, 2),
('P0008', 'Sony WH-1000XM5', 7000000, 'Tai nghe chống ồn Sony', 'Tai nghe chống ồn tốt nhất', 'sonywh1000xm5.jpg', 1, 5),
('P0009', 'Logitech MX Master 3', 2500000, 'Chuột không dây', 'Chuột Logitech MX Master 3', 'mxmaster3.jpg', 1, 4),
('P0010', 'Razer BlackWidow', 3000000, 'Bàn phím cơ gaming', 'Bàn phím cơ dành cho game thủ', 'blackwidow.jpg', 1, 10);


INSERT INTO Orders (user_email, user_phone, user_address, user_created, order_status, user_id) VALUES
('nguyenvana@gmail.com', '0987654321', 'Hà Nội', '2024-02-01', 1, 1),
('tranthib@gmail.com', '0976543210', 'TP HCM', '2024-02-02', 2, 2),
('leminhc@gmail.com', '0965432109', 'Đà Nẵng', '2024-02-03', 3, 3),
('phamvand@gmail.com', '0954321098', 'Hải Phòng', '2024-02-04', 4, 4),
('hoangthie@gmail.com', '0943210987', 'Cần Thơ', '2024-02-05', 5, 5),
('buidinhf@gmail.com', '0932109876', 'Huế', '2024-02-06', 6, 6),
('dangthig@gmail.com', '0921098765', 'Nha Trang', '2024-02-07', 7, 7),
('trinhvank@gmail.com', '0910987654', 'Vũng Tàu', '2024-02-08', 8, 8),
('lythiho@gmail.com', '0909876543', 'Biên Hòa', '2024-02-09', 9, 9),
('phandinhj@gmail.com', '0898765432', 'Quảng Ninh', '2024-02-10', 10, 10);

INSERT INTO Order_Detail (order_price, product_id, order_id) VALUES
(25000000, 'P0001', 1),
(35000000, 'P0002', 2),
(15000000, 'P0003', 3),
(5000000, 'P0004', 4),
(12000000, 'P0005', 5),
(20000000, 'P0006', 6),
(30000000, 'P0007', 7),
(7000000, 'P0008', 8),
(2500000, 'P0009', 9),
(3000000, 'P0010', 10);



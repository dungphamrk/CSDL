create database b1;
use b1;
create table Room(
	room_id int primary key auto_increment not null ,
    room_name varchar(255) not null ,
    room_manager varchar(255) not null 
);
create table Subjecṭ̣̣(
	subject_id int primary key auto_increment not null,
    subject_name varchar(255) not null,
    subject_duration date not null
);

create table Computer (
	computer_id int primary key auto_increment not null,
    computer_configuration varchar(255) not null,
    room_id int not null ,
    foreign key (room_id) references Room(room_id)
);


create  table Paticipation (
	register_date date not null,
    room_id int not null,
    subject_id int not null,
    primary key (room_id ,subject_id),
    foreign key (room_id) references Room(room_id),
	foreign key (subject_id) references Subject(subject_id)
);
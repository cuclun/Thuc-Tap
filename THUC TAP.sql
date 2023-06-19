CREATE DATABASE THUCTAP
GO

USE THUCTAP
GO

CREATE TABLE KHOA (
	MaKhoa char(10) PRIMARY KEY, 
	TenKhoa nvarchar(30),
	DienThoai char(10)
)
GO

CREATE TABLE GIANGVIEN (
	MaGV INT PRIMARY KEY, 
	HoTenGV nvarchar(30),
	Luong decimal(5,2),
	MaKhoa char(10),
	FOREIGN KEY(MaKhoa) REFERENCES KHOA(MaKhoa)
)
GO

CREATE TABLE SINHVIEN (
	MaSV int PRIMARY KEY, 
	HoTenSV nvarchar(30),
	MaKhoa char(10),
	FOREIGN KEY(MaKhoa) REFERENCES KHOA(MaKhoa),
	NamSinh int,
	QueQuan nvarchar(30)
)
GO

CREATE TABLE DETAI (
	MaDT char(10) PRIMARY KEY, 
	TenDT nvarchar(30),
	KinhPhi int,
	NoiThucTap char(30)
)
GO

CREATE TABLE HUONGDAN (
	MaSV int, 
	FOREIGN KEY(MaSV) REFERENCES SINHVIEN(MaSV),
	MaDT char(10),
	FOREIGN KEY(MaDT) REFERENCES DETAI(MaDT),
	MaGV int,
	KetQua decimal(5,2)
)
GO

ALTER TABLE HUONGDAN
ADD FOREIGN KEY (MaGV) REFERENCES GIANGVIEN(MaGV);

insert into KHOA(MaKhoa, TenKhoa, DienThoai) 
values ('MK01', N'Khoa Tin', '0123451'),
	('MK02', N'Khoa Toán', '0123452'),
	('MK03', N'Khoa Lý', '0123453'),
	('MK04', N'Khoa Hóa', '0123454'),
	('MK05', N'Khoa Sử', '0123455'),
	('MK06', N'Khoa Địa', '0123456')
go

insert into GIANGVIEN(MaGV, HoTenGV, Luong, MaKhoa) 
values ('0001', N'Trần Thị Thanh Cúc', 120.00, 'MK01'),
	('0002', N'Trần Thị Thanh Mai', 123.00, 'MK01'),
	('0003', N'Trần Thị Thu Giang', 123.43, 'MK03'),
	('0004', N'Lê Thị Thùy Dung', 234.52, 'MK01'),
	('0005', N'Phan Thị Mỹ Dung', 423.54, 'MK02'),
	('0006', N'Đinh Thị Hiền', 887.65, 'MK03')
go

insert into SINHVIEN(MaSV, HoTenSV, NamSinh, MaKhoa, QueQuan) 
values ('0001', N'Trần Thị Thanh Cúc', '2001', 'MK01', N'Quảng Nam'),
	('0002', N'Trần Thị Thanh Mai', '2003', 'MK01', N'Quảng Nam'),
	('0003', N'Trần Thị Thu Giang', '1997', 'MK03', N'Quảng Nam'),
	('0004', N'Lê Thị Thùy Dung', '2001', 'MK01', N'Quảng Nam'),
	('0005', N'Phan Thị Mỹ Dung', '2001', 'MK02', N'Quảng Nam'),
	('0006', N'Đinh Thị Hiền', '2001', 'MK03', N'Quảng Nam')
go

insert into DETAI(MaDT, TenDT, KinhPhi, NoiThucTap) 
values ('DT01', N'WEBSITE', '4352435', N'Quảng Nam'),
	('DT02', N'APP', '324354657', N'Quảng Nam'),
	('DT03', N'APP', '245364', N'Quảng Nam'),
	('DT04', N'WEBSITE', '24435435', N'Quảng Nam'),
	('DT05', N'APP', '234543', N'Quảng Nam'),
	('DT06', N'APP', '23435465', N'Quảng Nam')
go

insert into HUONGDAN(MaDT, MaSV, MaGV) 
values ('DT01', '0001', '0001'),
	('DT01', '0002','0002'),
	('DT01', '0003', '0003'),
	('DT04', '0004', '0004'),
	('DT05', '0005', '0005'),
	('DT06', '0006', '0006')
go

select * from KHOA
select * from SINHVIEN
select * from HUONGDAN
select * from GIANGVIEN
select * from DETAI


--1. Sử dụng lệnh truy vấn SQL lấy ra mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập .

select d.MaDT, TenDT
from HUONGDAN h join DETAI d on h.MaDT = d.MaDT
group by d.MaDT, TenDT
having count(h.MaSV) > 2

--2. Sử dụng câu lệnh truy vấn SQL lấy ra mã số, tên đề tài của đề tài có kinh phí cao nhất .

select MaDT, TenDT from DETAI
where KinhPhi = (select max(KinhPhi) from DETAI)

--3. Sử dụng câu lệnh SQL xuất ra Tên khoa, Số lượng sinh viên của mỗi khoa .

select TenKhoa, COUNT(MaSV) SoLuongSV
from KHOA k join SINHVIEN s on k.MaKhoa = s.MaKhoa
group by TenKhoa
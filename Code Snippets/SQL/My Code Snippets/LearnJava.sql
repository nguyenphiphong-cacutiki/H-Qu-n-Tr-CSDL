create database DLKH
use DLKH

create table thKhachHang(soTK char(50), hoTen nvarchar(50), diaChi char(50), soDu int) 

insert into thKhachHang values('303440404', N'Nguyễn Phi Phong', 'bt1c2 TV', 1000000000),
							  ('303430404', N'Trần Thanh Phong', 'bt1c2 TV', 1000000000),
							  ('303440224', N'Nguyễn Văn Cường', 'bt1c2 TV', 1000000000),
							  ('304330404', N'Đỗ Quỳnh Trang', 'bt1c2 TV', 1000000000)
select * from thKhachHang
drop table thKhachHang


--------------------------- VIEW -------------------------------
--- còn gọi là khung nhìn hoặc bảng ảo
-- là đối tượng, tạo bằng create
-- gồm các cột và các dòng
-- + đảm bảo tính bảo mật của dữ liệu, chỉ cho người dùng nhìn trong một khung nhìn của
-- dữ liệu
-- + đơn giản hóa cho việc truy vấn dữ liệu
-- + đơn giản hóa dữ liệu
-- * Nhược điểm
-- create
use QLSV
create view viewOne
as select * from SINHVIEN
-- tao view ten la kqthi, lấy tên, môn điểm
create view KetQuaThi
as select * from SINHVIEN s inner join DIEMSV d on s.Masv = d.Masv
-- sử dụng khung nhìn như một bảng. 
------------- vd1. cho biết những lớp nào có nhiều sinh viên giỏi nhất: dtb>= 8.5
alter view DtbSv
as select s.Masv, s.Hosv, s.malop, avg(d.diem) as Dtb from SINHVIEN s inner join DIEMSV d on s.Masv = d.Masv 
			group by s.Masv, s.Hosv, s.Malop

create view SvGioiCuaLop
as select d.malop, count(d.masv) as SoLuong from DtbSv d where d.Dtb >= 8.5 group by d.malop

alter view LopCoNhieuSVGN
as select * from SvGioiCuaLop where SoLuong = (select max(SoLuong) from SvGioiCuaLop)

select * from DtbSv
select * from SvGioiCuaLop
select * from LopCoNhieuSVGN
							
-- cho bieets lowp ko có sinh viên giỏi
select * from LOP where Malop not in (select malop from SvGioiCuaLop)
------------------- vd2 cho biết những lớp nào có đông sinh viên nữ giỏi nhất
-- tạo view đưa ra sinh viên nữ, giỏi
alter view svNuGioi
as select s.Masv, s.Malop, s.Hosv, avg(d.diem) as dtb from DIEMSV d inner join SINHVIEN s on d.Masv = s.Masv
	where s.Gt = N'Nữ' group by s.Masv, s.Hosv, s.Malop
	having avg(d.diem) >= 8.5

	select * from svNuGioi
-- tạo view đếm số lượng sinh viên nữ giỏi của mỗi lớp
create view svNuGioiCuaLop 
as select s.malop, count(s.masv) as SoLuong from svNuGioi s group by s.malop
-- lấy ra lớp có sinh viên nữ giỏi nhiều nhất
select * from svNuGioiCuaLop where SoLuong = (select max(soluong) from svNuGioiCuaLop)

--------------------------- phân loại VIEW -------------------------------
-- view nào cũng có thể select, nhưng không phải view nào cũng có thể modify, modify view sẽ
-- modify trên bảng.
-- => updatable view
-- điều kiện:
-- + thành phần phải là cột cơ sở, không chứa hàm toán học
-- + ... 

-- bài tập trong csdl qlmb, tạo view(idsp, tensp, solanban) thống kê những sản phẩm có số lần
-- bán được ít nhất
-- từ đó giảm giá 10% giá của những sản phẩm trên
use qlmb
create view vd3
as select sp.IDSanPham, count(d.IDDonHang) as SoLuong from SP_DonHang sp inner join DonHang d
on sp.IDDonHang = d.IDDonHang
group by sp.IDSanPham 

create view vd3_min
as select * from vd3 where SoLuong = (select min(soluong) from vd3)

select * from vd3
select * from vd3_min

update SanPham set DonGia = DonGia * 0.9 where IdSanPham in (select IdSanPham from vd3_min)

select * from SanPham














--- btvn: làm 2 bài ở cuối view



create database BTVN_view
use BTVN_view

create table KHACHHANG(
	MaKhachHang varchar(10) not null primary key,
	TenCongTy nvarchar(30),
	TenGiaoDich nvarchar(40),
	DiaChi nvarchar(50),
	Email nvarchar(50),
	DienThoai nvarchar(12),
	Fax nvarchar(12)
)


create table NHANVIEN(
	MaNhanVien varchar(10) not null primary key,
	Ho nvarchar(20),
	Ten nvarchar(20),
	NgaySinh date,
	NgayLamViec date,
	DiaChi nvarchar(30),
	DienThoai varchar(12),
	LuongCoBan int,
	PhuCap int
)

create table DONDATHANG(
	SoHoaDon varchar(10) not null primary key,
	MaKhachHang varchar(10) foreign key references KHACHHANG(MaKhachHang),
	MaNhanVien varchar(10) foreign key references NHANVIEN(MaNhanVien),
	NgayDatHang date,
	NgayGiaoHang date,
	NgayChuyenHang date,
	NoiGiaoHang nvarchar(30)
)

create table NHACUNGCAP(
	MaCongTy varchar(10) not null primary key,
	TenCongTy nvarchar(30),
	TenGiaoDich nvarchar(30),
	DiaChi nvarchar(30),
	DienThoai varchar(12),
	Fax varchar(12),
	Email varchar(30)
)

create table LOAIHANG(
	MaLoaiHang varchar(10) not null primary key,
	TenLoaiHang nvarchar(30)
)

create table MATHANG(
	MaHang varchar(10) not null primary key,
	TenHang nvarchar(30),
	MaCongTy varchar(10) foreign key references NHACUNGCAP(MaCongTy),
	MaLoaiHang varchar(10) foreign key references LOAIHANG(MaLoaiHang),
	SoLuong int,
	DonViTinh nvarchar(30),
	GiaHang int
)

create table CHITIETDATHANG(
	SoHoaDon varchar(10) foreign key references DONDATHANG(SoHoaDon),
	MaHang varchar(10) foreign key references MATHANG(MaHang),
	GiaBan int,
	SoLuong int,
	MucGiamGia int
)

-- Chèn dữ liệu vào bảng KHACHHANG
INSERT INTO KHACHHANG VALUES 
('KH001', 'Công ty A', 'Giao dịch 1', 'Địa chỉ A', 'emailA@gmail.com', '1234567890', 'FAXA123456'),
('KH002', 'Công ty B', 'Giao dịch 2', 'Địa chỉ B', 'emailB@gmail.com', '0987654321', 'FAXB987654');

-- Chèn dữ liệu vào bảng NHANVIEN
INSERT INTO NHANVIEN VALUES 
('NV001', 'Nguyễn', 'Văn A', '1990-01-01', '2022-01-01', 'Địa chỉ NV A', '0123456789', 5000000, 1000000),
('NV002', 'Trần', 'Thị B', '1995-05-05', '2022-01-01', 'Địa chỉ NV B', '0987654321', 6000000, 1200000);

-- Chèn dữ liệu vào bảng DONDATHANG
INSERT INTO DONDATHANG VALUES 
('DH001', 'KH001', 'NV001', '2023-01-01', '2023-01-10', '2023-01-05', 'Nơi giao hàng A'),
('DH002', 'KH002', 'NV002', '2023-02-01', '2023-02-10', '2023-02-05', 'Nơi giao hàng B');

-- Chèn dữ liệu vào bảng NHACUNGCAP
INSERT INTO NHACUNGCAP VALUES 
('NCC001', 'Nhà cung cấp X', 'Giao dịch X', 'Địa chỉ X', '0123456789', 'FAXX123456', 'emailX@gmail.com'),
('NCC002', 'Nhà cung cấp Y', 'Giao dịch Y', 'Địa chỉ Y', '0987654321', 'FAXY987654', 'emailY@gmail.com');

-- Chèn dữ liệu vào bảng LOAIHANG
INSERT INTO LOAIHANG VALUES 
('LH001', 'Loại hàng 1'),
('LH002', 'Loại hàng 2');

-- Chèn dữ liệu vào bảng MATHANG
INSERT INTO MATHANG VALUES 
('MH001', 'Hàng 1', 'NCC001', 'LH001', 100, 'Đơn vị 1', 500000),
('MH002', 'Hàng 2', 'NCC002', 'LH002', 200, 'Đơn vị 2', 700000);

-- Chèn dữ liệu vào bảng CHITIETDATHANG
INSERT INTO CHITIETDATHANG VALUES 
('DH001', 'MH001', 550000, 5, 50000),
('DH002', 'MH002', 720000, 3, 60000);


create view _MatHang(MaHang, TenHang, MaCongTy, TenCongTyCungCap, MaLoaiHang, TenLoaiHang,SoLuong,
DonViTinh, GiaHang)
as select MaHang, TenHang,a.MaCongTy,TenCongTy,a.MaLoaiHang,TenLoaiHang,SoLuong,DonViTinh,GiaHang
	from MATHANG a inner join LOAIHANG b on a.MaLoaiHang = b.MaLoaiHang
					inner join NHACUNGCAP c on a.MaCongTy = c.MaCongTy
	

select * from _MatHang

--Lỗi vì cập nhật trên 2 bảng khác nhau
update _MatHang
set TenCongTyCungCap = N'Nhà cung cấp VinMart', SoLuong=10
where MaHang='MH001'

--OK
update _MatHang
set SoLuong = 10, DonViTinh='new'
where MaHang='MH001'

--OK
insert into _MatHang (MaHang,TenHang,MaCongTy,MaLoaiHang,SoLuong,DonViTinh,GiaHang)
values('MH003','H1','NCC001','LH001',3,N'Cái',5)

--Lỗi do TenLoaiHang ở bảng khác
insert into _MatHang (MaHang,TenHang,MaCongTy,MaLoaiHang,SoLuong,DonViTinh,GiaHang,TenLoaiHang)
values('MH003','H1','NCC001','LH001',3,N'Cái',5, 'h2')


--------------- view khác
create view _DonDatHang (SoHoaDon, MaKhachHang, TenCongTyKhachHang, HoVaTenNhanVien, NgayDatHang,NgayGiaoHang, NgayChuyenHang, NoiGiaoHang, MaHang, TenHang,SoLuong,GiaBan,MucGiamGia)
as
select
    DDH.SoHoaDon,
    DDH.MaKhachHang,
    KH.TenCongTy,
    NV.Ho + ' ' + NV.Ten,
    DDH.NgayDatHang,
    DDH.NgayGiaoHang,
    DDH.NgayChuyenHang,
    DDH.NoiGiaoHang,
    CTDH.MaHang,
    MH.TenHang,
    CTDH.SoLuong,
    CTDH.GiaBan,
    CTDH.MucGiamGia
from DONDATHANG DDH
	inner join KHACHHANG KH on DDH.MaKhachHang = KH.MaKhachHang
	inner join NHANVIEN NV on DDH.MaNhanVien = NV.MaNhanVien
	inner join CHITIETDATHANG CTDH on DDH.SoHoaDon = CTDH.SoHoaDon
	inner join MATHANG MH on CTDH.MaHang = MH.MaHang;
 












--------- check
select * from SINHVIEN
insert into SINHVIEN(masv) values(20)
select * from SINHVIEN where gt is null

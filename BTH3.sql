create database QuanLyBanHang
use QuanLyBanHang

------------ Nhà cung cấp
create table NhaCungCap
(IDNhaCungCap char(50) not null primary key,
TenCongTy nvarchar(50), 
DiaChi nvarchar(50),
SoDienThoai char(20),
Website char(100),
ConGiaoDich bit)

INSERT INTO NhaCungCap (IDNhaCungCap, TenCongTy, DiaChi, SoDienThoai, Website, ConGiaoDich)
VALUES
    ('NCC01', N'Công ty A', N'Địa chỉ A', '0123456789', 'www.congtyA.com', 1),
    ('NCC02', N'Công ty B', N'Địa chỉ B', '0987654321', 'www.congtyB.com', 0),
    ('NCC03', N'Công ty C', N'Địa chỉ C', '0123456789', 'www.congtyC.com', 1),
    ('NCC04', N'Công ty D', N'Địa chỉ D', '0987654321', 'www.congtyD.com', 1),
    ('NCC05', N'Công ty E', N'Địa chỉ E', '0123456789', 'www.congtyE.com', 0),
    ('NCC06', N'Công ty F', N'Địa chỉ F', '0987654321', 'www.congtyF.com', 1),
    ('NCC07', N'Công ty G', N'Địa chỉ G', '0123456789', 'www.congtyG.com', 0),
    ('NCC08', N'Công ty H', N'Địa chỉ H', '0987654321', 'www.congtyH.com', 1),
    ('NCC09', N'Công ty I', N'Địa chỉ I', '0123456789', 'www.congtyI.com', 1),
    ('NCC10', N'Công ty J', N'Địa chỉ J', '0987654321', 'www.congtyJ.com', 0);

------------------ Loại hàng
create table LoaiHang
(IDLoaiHang char(50) not null primary key,
TenLoaiHang nvarchar(50),
MoTa nvarchar(50))

INSERT INTO LoaiHang (IDLoaiHang, TenLoaiHang, MoTa)
VALUES
    ('LH01', N'Loại hàng A', N'Mô tả loại hàng A'),
    ('LH02', N'Loại hàng B', N'Mô tả loại hàng B'),
    ('LH03', N'Loại hàng C', N'Mô tả loại hàng C'),
    ('LH04', N'Loại hàng D', N'Mô tả loại hàng D'),
    ('LH05', N'Loại hàng E', N'Mô tả loại hàng E'),
    ('LH06', N'Loại hàng F', N'Mô tả loại hàng F'),
    ('LH07', N'Loại hàng G', N'Mô tả loại hàng G'),
    ('LH08', N'Loại hàng H', N'Mô tả loại hàng H'),
    ('LH09', N'Loại hàng I', N'Mô tả loại hàng I'),
    ('LH10', N'Loại hàng J', N'Mô tả loại hàng J');


---------------------- Sản phẩm
create table SanPham
(IDSanPham char(50) not null primary key,
TenSP nvarchar(50) not null,
IDNhaCungCap char(50) not null foreign key references NhaCungCap(IDNhaCungCap),
IDLoaiHang char(50) not null foreign key references LoaiHang(IDLoaiHang),
DonGiaNhap money not null,
SoLuongCon int not null, 
SoLuongChoCungCap int not null,
MoTa nvarchar(200),
NgungBan bit default 0)

INSERT INTO SanPham (IDSanPham, TenSP, IDNhaCungCap, IDLoaiHang, DonGiaNhap, SoLuongCon, SoLuongChoCungCap, MoTa, NgungBan)
VALUES
    ('SP01', N'Sản phẩm A', 'NCC01', 'LH01', 100000, 50, 10, N'Mô tả sản phẩm A', 0),
    ('SP02', N'Sản phẩm B', 'NCC02', 'LH02', 200000, 30, 15, N'Mô tả sản phẩm B', 0),
    ('SP03', N'Sản phẩm C', 'NCC01', 'LH01', 150000, 20, 5, N'Mô tả sản phẩm C', 0),
    ('SP04', N'Sản phẩm D', 'NCC02', 'LH02', 180000, 40, 20, N'Mô tả sản phẩm D', 0),
    ('SP05', N'Sản phẩm E', 'NCC01', 'LH01', 120000, 60, 25, N'Mô tả sản phẩm E', 1),
    ('SP06', N'Sản phẩm F', 'NCC02', 'LH02', 250000, 10, 30, N'Mô tả sản phẩm F', 1),
    ('SP07', N'Sản phẩm G', 'NCC01', 'LH01', 220000, 25, 35, N'Mô tả sản phẩm G', 0),
    ('SP08', N'Sản phẩm H', 'NCC02', 'LH02', 190000, 35, 40, N'Mô tả sản phẩm H', 1),
    ('SP09', N'Sản phẩm I', 'NCC01', 'LH01', 140000, 15, 45, N'Mô tả sản phẩm I', 1),
    ('SP10', N'Sản phẩm J', 'NCC02', 'LH02', 230000, 45, 50, N'Mô tả sản phẩm J', 0);

------------------- Công ty giao hàng
create table CtyGiaoHang
(IDCty char(50) not null primary key,
TenCongTy nvarchar(50) not null,
SoDienThoai char(20) not null,
DiaChi nvarchar(100) not null)

INSERT INTO CtyGiaoHang (IDCty, TenCongTy, SoDienThoai, DiaChi)
VALUES
    ('CT01', N'Công ty A', '0123456789', N'Địa chỉ A'),
    ('CT02', N'Công ty B', '0987654321', N'Địa chỉ B'),
    ('CT03', N'Công ty C', '0123456789', N'Địa chỉ C'),
    ('CT04', N'Công ty D', '0987654321', N'Địa chỉ D'),
    ('CT05', N'Công ty E', '0123456789', N'Địa chỉ E'),
    ('CT06', N'Công ty F', '0987654321', N'Địa chỉ F'),
    ('CT07', N'Công ty G', '0123456789', N'Địa chỉ G'),
    ('CT08', N'Công ty H', '0987654321', N'Địa chỉ H'),
    ('CT09', N'Công ty I', '0123456789', N'Địa chỉ I'),
    ('CT10', N'Công ty J', '0987654321', N'Địa chỉ J');


--------------------- Khách hàng
create table KhachHang
(IDKhachHang char(50) not null primary key,
HoTen nvarchar(50) not null,
GioiTinh nvarchar(10) not null check(GioiTinh = N'Nam' or GioiTinh = N'Nữ') default N'Nam',
DiaChi nvarchar(100), 
Email char(50),
SoDienThoai char(20))


INSERT INTO KhachHang (IDKhachHang, HoTen, GioiTinh, DiaChi, Email, SoDienThoai)
VALUES
    ('KH01', N'Tên 1', N'Nam', N'Địa chỉ 1', 'email1@example.com', '0123456789'),
    ('KH02', N'Tên 2', N'Nữ', N'Địa chỉ 2', 'email2@example.com', '0987654321'),
    ('KH03', N'Tên 3', N'Nam', N'Địa chỉ 3', 'email3@example.com', '0123456789'),
    ('KH04', N'Tên 4', N'Nữ', N'Địa chỉ 4', 'email4@example.com', '0987654321'),
    ('KH05', N'Tên 5', N'Nam', N'Địa chỉ 5', 'email5@example.com', '0123456789'),
    ('KH06', N'Tên 6', N'Nữ', N'Địa chỉ 6', 'email6@example.com', '0987654321'),
    ('KH07', N'Tên 7', N'Nam', N'Địa chỉ 7', 'email7@example.com', '0123456789'),
    ('KH08', N'Tên 8', N'Nữ', N'Địa chỉ 8', 'email8@example.com', '0987654321'),
    ('KH09', N'Tên 9', N'Nam', N'Địa chỉ 9', 'email9@example.com', '0123456789'),
    ('KH10', N'Tên 10', N'Nữ', N'Địa chỉ 10', 'email10@example.com', '0987654321');

-------------------- Nhân viên
create table NhanVien
(IDNhanVien char(50) not null primary key,
HoTen nvarchar(50) not null,
NgaySinh date not null,
GioiTinh nvarchar(10) not null check(GioiTinh = N'Nam' or GioiTinh = N'Nữ') default N'Nam',
NgayBatDauLam date not null,
DiaChi nvarchar(100) not null,
Email char(50),
SoDienThoai char(20) not null)

INSERT INTO NhanVien (IDNhanVien, HoTen, NgaySinh, GioiTinh, NgayBatDauLam, DiaChi, Email, SoDienThoai)
VALUES
    ('NV01', N'Tên 1', '2000-01-01', N'Nam', '2022-01-01', N'Địa chỉ 1', 'email1@example.com', '0123456789'),
    ('NV02', N'Tên 2', '2000-02-02', N'Nữ', '2022-02-02', N'Địa chỉ 2', 'email2@example.com', '0987654321'),
    ('NV03', N'Tên 3', '2000-03-03', N'Nam', '2022-03-03', N'Địa chỉ 3', 'email3@example.com', '0123456789'),
    ('NV04', N'Tên 4', '2000-04-04', N'Nữ', '2022-04-04', N'Địa chỉ 4', 'email4@example.com', '0987654321'),
    ('NV05', N'Tên 5', '2000-05-05', N'Nam', '2022-05-05', N'Địa chỉ 5', 'email5@example.com', '0123456789'),
    ('NV06', N'Tên 6', '2000-06-06', N'Nữ', '2022-06-06', N'Địa chỉ 6', 'email6@example.com', '0987654321'),
    ('NV07', N'Tên 7', '2000-07-07', N'Nam', '2022-07-07', N'Địa chỉ 7', 'email7@example.com', '0123456789'),
    ('NV08', N'Tên 8', '2000-08-08', N'Nữ', '2022-08-08', N'Địa chỉ 8', 'email8@example.com', '0987654321'),
    ('NV09', N'Tên 9', '2000-09-09', N'Nam', '2022-09-09', N'Địa chỉ 9', 'email9@example.com', '0123456789'),
    ('NV10', N'Tên 10', '2000-10-10', N'Nữ', '2022-10-10', N'Địa chỉ 10', 'email10@example.com', '0987654321');

-------------------- Đơn hàng
create table DonHang
(IDDonHang char(50) not null primary key,
IDKhachHang char(50) not null foreign key references KhachHang(IDKhachHang),
IDNhanVien char(50) not null foreign key references NhanVien(IDNhanVien),
NgayDatHang date not null,
NgayGiaoHang date not null,
NgayYeuCauChuyen date not null,
IDCTyGiaoHang char(50) not null foreign key references CTyGiaoHang(IDCty),
DiaChiGiaoHang nvarchar(100) not null)

INSERT INTO DonHang (IDDonHang, IDKhachHang, IDNhanVien, NgayDatHang, NgayGiaoHang, NgayYeuCauChuyen, IDCTyGiaoHang, DiaChiGiaoHang)
VALUES
    ('DH01', 'KH01', 'NV01', '2022-01-01', '2022-01-05', '2022-01-02', 'CT01', N'Địa chỉ giao hàng 1'),
    ('DH02', 'KH02', 'NV02', '2022-02-01', '2022-02-07', '2022-02-03', 'CT02', N'Địa chỉ giao hàng 2'),
    ('DH03', 'KH03', 'NV03', '2022-03-01', '2022-03-09', '2022-03-04', 'CT03', N'Địa chỉ giao hàng 3'),
    ('DH04', 'KH04', 'NV04', '2022-04-01', '2022-04-11', '2022-04-05', 'CT04', N'Địa chỉ giao hàng 4'),
    ('DH05', 'KH05', 'NV05', '2022-05-01', '2022-05-13', '2022-05-06', 'CT05', N'Địa chỉ giao hàng 5'),
    ('DH06', 'KH06', 'NV06', '2022-06-01', '2022-06-15', '2022-06-07', 'CT06', N'Địa chỉ giao hàng 6'),
    ('DH07', 'KH07', 'NV07', '2022-07-01', '2022-07-17', '2022-07-08', 'CT07', N'Địa chỉ giao hàng 7'),
    ('DH08', 'KH08', 'NV08', '2022-08-01', '2022-08-19', '2022-08-10', 'CT08', N'Địa chỉ giao hàng 8'),
    ('DH09', 'KH09', 'NV09', '2022-09-01', '2022-09-21', '2022-09-12', 'CT09', N'Địa chỉ giao hàng 9'),
    ('DH10', 'KH10', 'NV10', '2022-10-01', '2022-10-23', '2022-10-14', 'CT10', N'Địa chỉ giao hàng 10');

-------------------- Sản phẩm đơn hàng
create table SP_DonHang
(IDDonHang char(50) not null foreign key references DonHang(IDDonHang),
IDSanPham char(50) not null foreign key references SanPham(IDSanPham),
SoLuong int not null default 0,
DonGiaBan money not null default 0,
TyLeGiamGia float not null default 0.0,
primary key(IDDonHang, IDSanPham))


INSERT INTO SP_DonHang (IDDonHang, IDSanPham, SoLuong, DonGiaBan, TyLeGiamGia)
VALUES
    ('DH01', 'SP01', 5, 100000, 0.1),
    ('DH01', 'SP02', 3, 50000, 0.05),
    ('DH02', 'SP03', 2, 75000, 0.0),
    ('DH02', 'SP04', 1, 200000, 0.2),
    ('DH03', 'SP05', 4, 150000, 0.15),
    ('DH03', 'SP06', 2, 100000, 0.1),
    ('DH04', 'SP07', 3, 80000, 0.05),
    ('DH04', 'SP08', 6, 120000, 0.0),
    ('DH05', 'SP09', 2, 180000, 0.2),
    ('DH05', 'SP10', 4, 90000, 0.15);


---------------------------------------- practice sql
/*
Câu 1. Viết một hàm f_ThanhTien trả về thành tiền của một sản phầm trong đơn hàng
(bảng SP_DonHang) với ThanhTien = SoLuong * DonGiaBan * (1-TyLeGiamGia) với
IDDonHang và IDSanPham là hai tham số đầu vào.
*/
create function f_ThanhTien(@idDonHang char(50), @idSanPham char(50)) 
returns money as
	begin
		return (select  (SoLuong * DonGiaBan * (1-TyLeGiamGia))
			from SP_DonHang where IDDonHang = @idDonHang and IDSanPham = @idSanPham)
	end
	-- check
	select * from SP_DonHang
	select dbo.f_ThanhTien('DH01', 'SP01')

/*
Câu 2. Viết một hàm f_TongTien trả về tổng tiền của một hóa đơn với tổng tiền hóa
đơn bằng tổng thành tiền của tất cả các sản phẩm trong đơn hàng với IDDonHang là
tham số đầu vào.
*/
alter function f_TongTien(@idDonHang char(50))
returns money as
	begin
		return (select sum(dbo.f_ThanhTien(@idDonHang, idSanPham)) from SP_DonHang where IDDonHang = @idDonHang)
	end
	-- check
	select dbo.f_TongTien('DH01') from SP_DonHang

/*
Câu 3. Viết một hàm f_SP_DonHang trả về một bảng chi tiết các sản phẩm trong một
đơn hàng với IDDonHang là tham số đầu vào. Bảng trả về bao gồm các cột IDSanPham,
TenSanPham, TenLoaiHang, TenCongTyCungCap, SoLuong, DonGiaBan,
TyLeGiamGia, ThanhTien.
Viết câu lệnh truy vấn trong bảng trả về của hàm f_SP_DonHang để hiển thị tất cả các
sản phẩm trong một đơn hàng nào đó (ví dụ: đơn hàng số 1)
*/
create function f_SP_DonHang(@idDonHang char(50))
returns table 
return (select  sp.IDSanPham, s.TenSP, lh.TenLoaiHang, nh.TenCongTy, sp.SoLuong, sp.DonGiaBan, sp.TyLeGiamGia
		, dbo.f_ThanhTien(@idDonHang, sp.idSanPham) as ThanhTien
		from SP_DonHang sp inner join SanPham s on sp.IDSanPham = s.IDSanPham
		inner join NhaCungCap nh on s.IDNhaCungCap = nh.IDNhaCungCap
		inner join LoaiHang lh on lh.IDLoaiHang = s.IDLoaiHang
		where sp.IDDonHang = @idDonHang
		 )
		 -- check
select * from f_SP_DonHang('DH01')

/*
Câu 4. Tạo view v_ChiTietDonHang để hiển thị chi tiết thông tin các mặt hàng trong
đơn hàng bao gồm IDDonHang, IDSanPham, TenSanPham, TenLoaiHang,
TenCongTyCungCap, SoLuongBan, DonGiaNhap, DonGiaBan, TyLeGiamGia,
ThanhTienBan, TienLai với:
- ThanhTienBan là tổng tiền bán được sản phẩm đó trong đơn hàng (đã trừ giảm
giá)
- TienLai là tiền lãi thu được từ sản phẩm đó trong hóa đơn (bằng ThanhTienBan
trừ đi tổng tiền nhập)
*/
-- mỗi dòng là một sản phẩm trong một đơn hàng
-- 
alter view v_ChiTietDonHang as
select sp.IDDonHang, sp.IDSanPham, s.TenSP, lh.TenLoaiHang, nh.TenCongTy, sp.SoLuong, s.DonGiaNhap
	,sp.DonGiaBan, sp.TyLeGiamGia, (sp.SoLuong * sp.DonGiaBan * (1-sp.TyLeGiamGia)) as ThanhTienBan,
	((sp.SoLuong * sp.DonGiaBan * (1-sp.TyLeGiamGia)) - (s.DonGiaNhap * sp.SoLuong)) as TienLai
	from SP_DonHang sp inner join SanPham s on sp.IDSanPham = s.IDSanPham
	inner join LoaiHang lh on lh.IDLoaiHang = s.IDLoaiHang
	inner join NhaCungCap nh on nh.IDNhaCungCap = s.IDNhaCungCap
	-- order by: check 
	select * from v_ChiTietDonHang

/*
Câu 5. Tạo view v_TongKetDonHang để hiển thị thông tin tổng kết các đơn hàng bao
gồm IDDonHang, IDKhachHang, HoTenKhachHang, GioiTinhKhachHang,
IDNhanVien, HoTenNhanVien, NgayDatHang, NgayGiaoHang, NgayYeuCauChuyen,
IDCongTyGiaoHang, TenCongTyGiaoHang, SoMatHang, TongTienHoaDon,
TongTienLai với:
- SoMatHang là số mặt hàng trong đơn hàng (chú ý: một sản phẩm với số lượng là
n>1 cũng chỉ được tính là 1 mặt hàng)
- TongTienHoaDon là tổng tiền thu được từ các mặt hàng trong hóa đơn
- TongLai là tổng tiền lãi thu được từ các mặt hàng trong hóa đơn
*/
-- create view main
alter view v_TongKetDonHang as
select d.IDDonHang, kh.IDKhachHang, kh.HoTen, kh.GioiTinh, nv.IDNhanVien, nv.HoTen as TenNhanVien
, d.NgayDatHang
, d.NgayGiaoHang, d.NgayYeuCauChuyen, ct.IDCty, ct.TenCongTy as TenCongTy
, dbo.getSoSPByDonHang(d.idDonHang) as SoMatHang
, dbo.f_TongTien(d.idDonHang) as TongTienHoaDon
, (dbo.f_TongTien(d.idDonHang) - dbo.getTongTienNhapByDonHang(d.idDonHang)) as TongLai
from DonHang d inner join KhachHang kh on d.IDKhachHang = kh.IDKhachHang
inner join CtyGiaoHang ct on ct.IDCty = d.IDCTyGiaoHang
inner join NhanVien nv on d.IDNhanVien = nv.IDNhanVien
inner join SP_DonHang sp on sp.IDDonHang = d.IDDonHang
-- check
select * from v_TongKetDonHang
-- Cần check thêm trường hợp đơn hàng chưa có sản phẩm nào thì để tổng tiền là 0 thay vì null
-- function support: 
-- tạo function lấy số sp theo đơn hàng
-- tạo function lấy tổng tiền theo giá nhập theo đơn hàng
-- function tổng tiến bán theo đơn hàng đã có ở câu 2
--select * from SP_DonHang
create function getSoSPByDonHang(@idDonHang char(50))
returns int as
begin
	return (select count(idDonHang) from SP_DonHang sp where IDDonHang = @idDonHang)
end

alter function getTongTienNhapByDonHang(@idDonHang char(50))
returns money as
begin 
	return (select sum(sp.SoLuong*s.DonGiaNhap)
	from SP_DonHang sp inner join SanPham s on sp.IDSanPham = s.IDSanPham where sp.IDDonHang = @idDonHang)
end

/*
Câu 6. Thực hiện truy vấn trong các view v_ChiTietDonHang, v_TongKetDonHang
đã tạo và các bảng cần thiết để thực hiện các yêu cầu sau:
a. Tìm nhân viên bán được nhiều đơn hàng nhất
b. Đưa ra danh sách các nhân viên theo thứ tự giảm dần của số đơn hàng bán được
c. Đưa ra danh sách các công ty đã từng giao hàng trễd. Đưa ra danh sách các mặt hàng theo thứ tự giảm dần tổng số tiền lãi thu được
e. Đưa ra loại mặt hàng có số lượng bán được nhiều nhất
*/
--a Tìm nhân viên bán được nhiều đơn hàng nhất
select * from v_TongKetDonHang
select * from SP_DonHang
select * from DonHang
select v.iDNhanVien, v.TenNhanVien, count(distinct idDonHang) SoDonHangBanDuoc 
from v_TongKetDonHang v where tongtienhoadon is not null group by v.idNhanVien, v.TenNhanVien
having count(distinct idDonHang) >= all
(select count(distinct idDonHang) SoDonHangBanDuoc 
from v_TongKetDonHang v where tongtienhoadon is not null group by v.idNhanVien, v.TenNhanVien)

--b Đưa ra danh sách các nhân viên theo thứ tự giảm dần của số đơn hàng bán được
select v.iDNhanVien, v.TenNhanVien, count(distinct idDonHang) SoDonHangBanDuoc 
from v_TongKetDonHang v where tongtienhoadon is not null group by v.idNhanVien, v.TenNhanVien
order by SoDonHangBanDuoc desc
--c. Đưa ra danh sách các công ty đã từng giao hàng trễ.
--   Đưa ra danh sách các mặt hàng theo thứ tự giảm dần tổng số tiền lãi thu được
select * from DonHang d inner join SP_DonHang sp on d.IDDonHang = sp.IDDonHang
	inner join CtyGiaoHang ct on ct.IDCty = d.IDCTyGiaoHang 
	where d.NgayGiaoHang > d.NgayYeuCauChuyen

	-- update data to check
	update DonHang set NgayYeuCauChuyen = '2022-01-07' where IDDonHang = 'DH01'
	select MONTH(ngaygiaohang) from DonHang
	select * from DonHang
--e. Đưa ra loại mặt hàng có số lượng bán được nhiều nhất
select s.IDSanPham, s.TenSP, sum(sp.soLuong) as SoLuong
	from SanPham s inner join SP_DonHang sp on s.IDSanPham = sp.IDSanPham
	group by s.IDSanPham, s.TenSP having sum(sp.soLuong) >= all
	(select (sum(sp.soLuong)) as SoLuong
	from SanPham s inner join SP_DonHang sp on s.IDSanPham = sp.IDSanPham
	group by s.IDSanPham)
		
		-- cách 2: dùng function support
		create function findSL(@idSanPham char(50))
		returns int as
		begin
			return (select sum(soluong) from SP_DonHang where IDSanPham = @idSanPham)
		end

		select * from SanPham where dbo.findSL(idSanPham) = (select max(dbo.findSL(idSanPham)) from SanPham)

/*
Câu 7. Tạo Trigger để đảm bảo rằng khi thêm một loại mặt hàng vào bảng LoaiHangthì tên loại mặt hàng thêm vào phải chưa có trong bảng. Nếu người dùng nhập một tênloại mặt hàng đã có trong danh sách thì báo lỗi.
- Thử thêm một loại mặt hàng vào trong bảng
*/
create trigger trigCau7 on LoaiHang
for insert as
	begin 
		declare @x nvarchar(50)
		select @x = tenloaihang from inserted 
		if((select count(tenloaihang) from LoaiHang where TenLoaiHang = @x)>=2)
			begin
				print 'insert fail'
				rollback transaction
			end
		else
			print 'insert success'
	end

	select * from LoaiHang
	insert into LoaiHang values('LH11', N'Loại hàng A', N'Mô tả hihihi')
	select * from sys.triggers



/* edit data
INSERT INTO DonHang (IDDonHang, IDKhachHang, IDNhanVien, NgayDatHang, NgayGiaoHang, NgayYeuCauChuyen, IDCTyGiaoHang, DiaChiGiaoHang)
VALUES
    ('DH12', 'KH01', 'NV06', '2022-01-01', '2022-01-05', '2022-01-02', 'CT02', N'Địa chỉ giao hàng 1')

INSERT INTO SP_DonHang (IDDonHang, IDSanPham, SoLuong, DonGiaBan, TyLeGiamGia)
VALUES
    ('DH11', 'SP01', 5, 100000, 0.1)
*/


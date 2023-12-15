create database qlmb
use qlmb  
create table KhachHang(
IDKhachHang int not null identity(1,1) primary key,
HoTen nvarchar(50),
GioiTinh nvarchar(10) check(GioiTinh = N'Nam' or GioiTinh = N'Nữ'),
DiaChi nvarchar(50),
Email char(50) check(Email like '%[@]%') unique,
SoDienThoai char(50)
)

select * from KhachHang
delete from KhachHang
drop table KhachHang
-- insert
insert into KhachHang values
(N'KH01', N'Nam', N'225 Xã Đàn', 'email01@gmail.com', '0123334567'),
(N'KH02', N'Nữ', N'215 Xã Đàn', 'email02@gmail.com', '0122355567'),
(N'KH03', N'Nam', N'125 Xã Đàn', 'email03@gmail.com', '0122334567'),
(N'KH04', N'Nữ', N'205 Xã Đàn', 'email04@gmail.com', '0122334777'),
(N'KH05', N'Nam', N'925 Xã Đàn', 'email05@gmail.com', '0122334567'),
(N'KH06', N'Nữ', N'125 Xã Đàn', 'email06@gmail.com', '0772334567'),
(N'KH07', N'Nam', N'425 Xã Đàn', 'email07@gmail.com', '0762334567'),
(N'KH08', N'Nữ', N'445 Xã Đàn', 'email08@gmail.com', '0122334587'),
(N'KH09', N'Nam', N'205 Xã Đàn', 'email09@gmail.com', '0122334907'),
(N'KH10', N'Nam', N'215 Xã Đàn', 'email10@gmail.com', '0122334667')

create table SanPham(
IdSanPham int not null primary key identity(0,1),
TenSP nvarchar(50),
MoTa nvarchar(50),
DonGia float
)
delete from SanPham
select * from SanPham
-- insert
insert into SanPham values
(N'SanPham01', N'Mô tả sp01', 20000),
(N'SanPham02', N'Mô tả sp02', 21000),
(N'SanPham03', N'Mô tả sp03', 22000),
(N'SanPham04', N'Mô tả sp04', 23000),
(N'SanPham05', N'Mô tả sp05', 24000),
(N'SanPham06', N'Mô tả sp06', 25000),
(N'SanPham07', N'Mô tả sp07', 26000),
(N'SanPham08', N'Mô tả sp08', 27000),
(N'SanPham09', N'Mô tả sp09', 28000),
(N'SanPham10', N'Mô tả sp10', 29000)

create table DonHang(
IDDonHang int not null identity(0,1) primary key,
IDKhachHang int foreign key references KhachHang(IDKhachHang),
NgayDatHang date,
TongTien float default 0
)
delete from DonHang
select * from DonHang
-- insert
insert into DonHang(IDKhachHang, NgayDatHang) values (26, '2012-12-10')
insert into DonHang(IDKhachHang, NgayDatHang) values (27, '2015/12/10')
insert into DonHang values
(21, '2022-12-10', null),
(21, '2022-11-10', null),
(27, '2023-12-10', null),
(22, '2022-01-10', null),
(23, '2022-02-10', null),
(23, '2022-03-10', null),
(25, '2021-12-10', null),
(24, '2022-05-10', null),
(25, '2020-12-10', null),
(25, '2019-12-10', null)
create table SP_DonHang(
IDDonHang int not null foreign key references DonHang(IDDonHang),
IDSanPham int not null foreign key references SanPham(IDSanPham) ,
SoLuong int,
ThanhTien float default 0,
primary key(IDDonHang, IDSanPham)
)
select * from SP_DonHang
delete from SP_DonHang
-- insert
select * from DonHang
select * from SanPham
insert into SP_DonHang values
(0, 1, 3, 0),
(0, 2, 4, 0),
(0, 3, 5, 0),
(0, 4, 6, 0),
(1, 1, 23, 0),
(1, 3, 31, 0),
(1, 9, 31, 0),
(2, 1, 33, 0),
(2, 4, 1, 0),
(3, 4, 23, 0),
(3, 8, 13, 0),
(4, 6, 23, 0),
(4, 9, 33, 0),
(5, 6, 13, 0),
(5, 2, 3, 0),
(6, 7, 3, 0),
(7, 6, 3, 0)


--------------------------------- thao tác dữ liệu ---------------------------------
-- a. Cập nhật trường ThanhTien cho bảng SP_DonHang bằng SoLuong*DonGia

declare  cur_spd cursor dynamic scroll
for select spd.IDDonHang, spd.IDSanPham, spd.SoLuong from SP_DonHang spd
deallocate cur_spd

open cur_spd
declare @idDonHang int, @idSanPham int, @soLuong int
declare @donGia float
fetch first from cur_spd into @idDonHang, @idSanPham, @soLuong
while @@FETCH_STATUS = 0
	begin
		select @donGia = s.DonGia from SanPham s where s.IdSanPham = @idSanPham
		update SP_DonHang set ThanhTien = SoLuong * @donGia
			where IDDonHang = @idDonHang and IDSanPham = @idSanPham
		fetch next from cur_spd into @idDonHang, @idSanPham, @soLuong
	end
close cur_spd

-- cách 2
update SP_DonHang set ThanhTien = spd.SoLuong * sp.DonGia
from SP_DonHang spd inner join SanPham sp on spd.IDSanPham = sp.IdSanPham


select * from SP_DonHang

-- b. Cập nhật trường TongTien trong bảng DonGia bằng tổng Thành tiền của tất cả các
-- sản phẩn trong đơn hàng
	update DonHang set TongTien = (
	select sum(SP_DonHang.ThanhTien) from SP_DonHang
	where SP_DonHang.IDDonHang = DonHang.IDDonHang)

	

	select * from DonHang
	select * from SP_DonHang
-- c. Viết câu lệnh trích ra phần tên khách hàng từ trường HoTen
	declare @name nvarchar(50), @name2 nvarchar(50)
	select @name = k.HoTen from KhachHang k where k.IDKhachHang = 21
	set @name2 = right(@name, len(@name) - charindex(N' ', @name))
	--print @name2
	--print len(@name2) - charindex(N' ', @name2)
	print right(@name2, len(@name2) - charindex(N' ', @name2))

	-- dùng reverse
	select right(trim(hoten), charindex(N' ', reverse(trim(hoten))) - 1) from khachhang
	
-- d. Sử dụng con trỏ để in ra thông tin các đơn hàng (IDDonHang, NgayDatHang,
-- Tong Tien) của khách hàng có tên là ‘Nguyễn Văn A’.
	declare cur_caud cursor dynamic scroll 
	for select dh.IDKhachHang, kh.HoTen, dh.NgayDatHang, dh.IDDonHang, dh.TongTien from DonHang dh 
	inner join KhachHang kh on dh.IDKhachHang = kh.IDKhachHang where kh.HoTen = N'KH01 Văn Trần'

	deallocate cur_caud

	open cur_caud
	declare @idKH nvarchar(50), @name nvarchar(50), @ngay char(50), @idDH char(50), @tongT float
	fetch first from cur_caud into @idDH, @name, @ngay, @iddh, @tongt
	while @@FETCH_STATUS = 0
		begin
			print N'makh ' + @idkh + N' voi ten ' + @name + N' ngay dat hang ' + @ngay + N' id hoa don: ' + @iddh
				+ N' tong tien: ' + cast(@tongT as char(20))
			fetch next from cur_caud into @idkh, @name, @ngay, @iddh, @tongt
		end
	close cur_caud

-- e. Sử dụng con trỏ để in ra tổng số tiền mà khách hàng ‘Nguyễn Văn A’ đã trả cho
-- tất cả các đơn hang
	
	declare cur_caue cursor dynamic scroll
	for select kh.idKhachHang, sum(dh.TongTien)  from khachhang kh inner join DonHang dh
		on dh.IDKhachHang = kh.IDKhachHang
		where kh.HoTen = N'KH03 Văn Trần' group by kh.idKhachHang, kh.hoTen
	deallocate cur_caue

	open cur_caue
	declare @id char(30), @tongT money
	fetch first from cur_caue into @id, @tongT
	while @@FETCH_STATUS = 0
		begin
			print N'Mã: ' + trim(@id) + N', Tổng tiền: ' + cast(@tongT as char(15))
			fetch next from cur_caue into @id, @tongT
		end
	close cur_caue
	
-- f. Viết 1 thủ tục để in ra doanh thu trong mỗi ngày của cửa hàng
	create proc print_cauf as
	begin
		select d.NgayDatHang, sum(d.TongTien) as [Tổng tiền] from DonHang d group by d.NgayDatHang
	end
	exec print_cauf

-- g. Viết 1 thủ tục để in ra doanh thu của của hàng trong 1 ngày bất kỳ (tham số vào là
-- ngày)
	create proc pro_InDoanhThu(@ngay date) as
	begin
		declare @tong money
		select @tong = sum(TongTien) from DonHang where NgayDatHang = @ngay 
		print N'Doanh thu ngày ' + trim(cast(@ngay as char(20))) + ' là '+ trim(cast(@tong as char(20)))
	end
	drop proc pro_InDoanhThu
	exec pro_InDoanhThu '2022-05-10'
-- h. Viết 1 thủ tục để in ra tổng số tiền mà 1 khách hàng đã chi tiêu mua hàng (SV tự
-- xác định tham số vào)
	alter proc print_cauh(@idkh nvarchar(30)) as
	begin 
		declare @sum money
		select @sum = sum(TongTien) from DonHang where IDKhachHang = @idkh
		print N'Khách hàng có mã: ' + trim(@idkh) + N' đã chi tiêu tổng là: ' + trim(cast(@sum as char(20)))
	end

	exec print_cauh '21'
	select * from DonHang
-- i. Viết thủ tục A để trả về tổng tiền của 1 đơn hàng bất kỳ
	alter proc A(@id char(50), @sum money out) as
	begin
		select @sum = TongTien from DonHang where IDDonHang = @id
	end

	declare @tongT money
	exec A N'4' , @tongT out
	print @tongT
	select * from DonHang

-- viêt thủ tục in ra thông tin những đơn hàng có tổng tiền lớn nhất
create proc print_k as
	begin
		select * from DonHang where TongTien = (
		select max(tongtien) from DonHang)
	end

exec print_k

-- dùng con trỏ để cập nhật trường tổng tiền của bảng donhang = tổng thành tiền

declare cur_capnhat01 cursor dynamic scroll
	for select IDDonHang from DonHang

	open cur_capnhat01
	declare @id int, @sum money
	fetch first from cur_capnhat01 into @id
	while @@FETCH_STATUS = 0
	begin
		select @sum = sum(thanhtien) from SP_DonHang where IDDonHang = @id 
		update DonHang set TongTien = @sum where IDDonHang = @id
		fetch next from cur_capnhat01 into @id
	end
	close cur_capnhat01


	select * from DonHang







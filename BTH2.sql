use qlmb 
/*Câu 1. Viết một stored procedure đặt tên là sp_ThanhTien để cập nhật trường ThanhTien
cho bảng SP_DonHang sao cho ThanhTien = SoLuong * DonGia*/
create proc sp_ThanhTien as
begin 
	update SP_DonHang set ThanhTien = SoLuong * DonGia from 
	SP_DonHang sp inner join SanPham s on sp.IDSanPham = s.IdSanPham
end

exec sp_ThanhTien
select * from SP_DonHang
/*Câu 2. Viết một stored procedure đặt tên là sp_TongTien để cập nhật trường TongTien cho
bảng DonHang bằng tổng ThanhTien của tất cả các sản phẩm trong đơn hàng.*/
create proc sp_TongTien as
begin
	update DonHang set TongTien = 
	(select sum(sp.ThanhTien) from SP_DonHang sp where DonHang.IDDonHang = sp.IDDonHang)
end
exec sp_TongTien
select * from DonHang
/*Câu 3. Viết một stored procedure đặt tên là sp_ThuNhap để tính thu nhập của của hàng
trong một khoảng thời gian nào đó với ngày đầu và ngày cuối là tham số đầu vào của thủ
tục. Viết một đoạn mã T-SQL thực hiện gọi thủ tục sp_ThuNhap hai lần với hai khoảng
thời gian khác nhau và thực hiện in ra màn hình khoảng thời gian đạt được thu nhập lớn
hơn*/
alter proc sp_ThuNhap(@start date, @end date, @money money out) as
begin
	select @money = sum(TongTien) from DonHang where NgayDatHang >= @start and NgayDatHang <= @end
end
declare @money1 money, @money2 money
exec sp_ThuNhap '2022-11-10','2022-12-10',@money1 out
exec sp_ThuNhap '2022-1-10','2022-2-10',@money2 out
print @money1
print @money2

/*Câu 4. Viết một hàm func_SLSP trả về số lượng đã bán của một sản phẩm với tên sản
phẩm là tham số đưa vào.
a. Gọi hàm trên để đưa ra số lượng đã bán của ‘sữa TH’
b. Gọi hàm trên để đưa ra tên những sản phẩm có số lượng bán ít nhất
c. Gọi hàm trên để cập nhật lại giá bán giảm đi 10% của những sản phẩm có số lượng
bán <100 */
select * from SP_DonHang
select * from SanPham
alter function func_SLSP(@id nvarchar(50))
returns int as
begin
	if(exists(select * from SP_DonHang where IDSanPham = @id))
		return (select sum(s.SoLuong) from SP_DonHang s where s.IDSanPham = @id)
	return 0
end
--a
declare @name nvarchar(50)
set @name = N'SanPham02'
if(exists(select * from SanPham where TenSP = @name))
	select s.IdSanPham, dbo.func_SLSP(s.idsanpham) as SoLuong from SanPham s where s.TenSP = @name
else print 'Product not found'
--b
select * from SanPham s where dbo.func_SLSP(s.idsanpham ) = 
	(select min(dbo.func_SLSP(s.idsanpham)) from SanPham s)
--c
update SanPham set DonGia = DonGia * 0.9 where dbo.func_SLSP(idsanpham) < 100

/*Câu 5: Viết 1 hàm trả về tổng tiền của 1 hóa đơn bất kỳ
a. Gọi hàm trên để đưa ra tổng tiền của mỗi hóa đơn mà khách hàng KH1 đã mua
b. Gọi hàm trên để đưa ra tổng tiền của tất cả các hóa đơn mà KH1 đã mua*/

create function getTongTien(@id nvarchar(50))
returns money as
begin
	 return (select tongtien from DonHang where IDDonHang = @id)
end
--
select * from DonHang
select * from KhachHang
select dbo.getTongTien(1) from DonHang
--a
if(exists(select * from KhachHang where HoTen = N'KH05 Văn Trần'))
	select k.IDKhachHang, k.HoTen, d.IDDonHang, dbo.getTongTien(d.IDDonHang) 
		from KhachHang k inner join DonHang d on k.IDKhachHang = d.IDKhachHang
		where k.HoTen = N'KH05 Văn Trần'
else print N'Guest name not found'

--b 
if(exists(select * from KhachHang where HoTen = N'KH01 Văn Trần'))
	select d.IDKhachHang, k.HoTen, sum(dbo.getTongTien(d.IDDonHang))
	from DonHang d inner join KhachHang k on d.IDKhachHang = k.IDKhachHang
	where k.HoTen = N'KH01 Văn Trần'
		group by d.IDKhachHang, k.HoTen
else print 'Guest name not found'

/*Câu 6. Viết một thủ tục sp_ThongKe để thống kê và in ra màn hình số lượng hóa đơn theo
ngày trong tuần. Ví dụ: Thứ hai: 0 hóa đơn Thứ ba: 1 hóa đơn …. Ví dụ: đối với Thứ Hai,
đây là số lượng hóa đơn của tất cả các ngày thứ 2, chứ không phải số lượng hóa đơn của
một ngày thứ 2 của một tuần nào đó. Cuối cùng, in ra màn hình xem ngày nào trong tuần
thường có nhiều người mua hàng nhất.*/
print datepart(w, getdate())

alter function getThu(@date date)
returns nvarchar(30) as
begin
	declare @x int
	set @x = datepart(dw, @date)
	return case (@x)
				when 2 then N'Thứ hai'
				when 3 then N'Thứ ba'
				when 4 then N'Thứ tư'
				when 5 then N'Thứ năm'
				when 6 then N'Thứ sáu'
				when 7 then N'Thứ bảy'
				when 1 then N'Chủ nhật'
			end
		return N'Thứ hai'
end


alter proc sp_ThongKe2 as
begin
	declare cur_a cursor dynamic scroll for
	select thu, count(id) as sl from (select dbo.getThu(NgayDatHang) as thu, IDDonHang as id from DonHang) as ntb 
	group by thu 
	open cur_a
	declare @thu nvarchar(50), @sl int, @maxsl int, @thuMax nvarchar(50)

	fetch first from cur_a into @thu, @sl
	set @maxsl = @sl 
	set @thuMax = @thu 
	while @@FETCH_STATUS = 0
		begin
		print @thu + N' Có ' + cast(@sl as char(4)) + N' hóa đơn'
		if(@sl > @maxsl)
			begin
				set @maxsl = @sl 
				set @thumax = @thu
			end
		fetch next from cur_a into @thu, @sl
		end
	close cur_a
	print N'Khách hàng thường mua hàng vào thứ ' + @thumax
end
exec sp_ThongKe2

/*Câu 7. Viết một thủ tục sp_SPCao đưa ra danh sách các sản phẩm có số lượng bán nhiều
hơn một giá trị x, với x là tham số đưa vào. Danh sách sản phẩm được đưa ra dưới dạng
con trỏ. Đọc nội dung con trỏ và hiển thị ra màn hình danh sách sản phẩm thu được.*/

alter proc sp_SPCao(@x int) as
begin
	declare cur_b7 cursor dynamic scroll for
	select sp.IDSanPham, s.TenSP, sum(SoLuong) as sl from SP_DonHang sp inner join SanPham s
	on sp.IDSanPham = s.IdSanPham
	group by sp.IDSanPham, s.TenSP having sum(SoLuong) > @x
	
	open cur_b7
	declare @id nvarchar(20), @ten nvarchar(50), @sl int
	fetch first from cur_b7 into @id, @ten, @sl
	while @@FETCH_STATUS = 0
	begin
		print N'Mặt hàng '+ @ten + N' có số lượng: ' + cast(@sl as char(4))
		fetch next from cur_b7 into @id, @ten, @sl
	end
	deallocate cur_b7
end
exec sp_SPCao 40
use qlmb
/*Câu 8. Viết một thủ tục sp_KH_DonHang có tham số đầu ra là một danh sách
IDKhachHang, HoTen, SoDonHang, SoTien và SoSanPham của tất cả các khách hàng
trong hệ thống. Với SoDonHang là tổng số đơn hàng của khách hàng đó, SoTien là tổng
số tiền khách hàng đó đã trả cho các hóa đơn, và SoSanPham là tổng số sản phẩm khách
hàng đó đã mua trên tất cả các hóa đơn. Đọc nội dung con trỏ và in ra màn hình thông tin
của từng khách hàng. Với khách hàng chưa từng đặt hàng lần nào, hiển thị là Khách hàng
…. chưa từng giao dịch*/
-- fucntion returns idKhachHang and SosanPham 
create function getIDKHAndSoSanPham()
	returns table as
	return select d.IDKhachHang, sum(sp.SoLuong) as SoSanPham from DonHang d inner join SP_DonHang sp
	on d.IDDonHang = sp.IDDonHang
	group by d.IDKhachHang
-- tạo thủ tục trả về con trỏ
alter proc vd8_main(@cur_bt8 cursor varying out) as
	begin
		set @cur_bt8 = cursor dynamic scroll for
		select k.IDKhachHang, k.HoTen, count(d.IDDonHang) as SoDonHang, sum(d.TongTien) as SoTien,
		g.SoSanPham as SoSanPham from KhachHang k left join DonHang d
		on d.IDKhachHang = k.IDKhachHang left join getIDKHAndSoSanPham() g
		on d.IDKhachHang = g.IDKhachHang
		group by k.IDKhachHang, k.HoTen, g.SoSanPham

		open @cur_bt8
	end
	-- read cursor and print data
	declare @run_cur_vd8 cursor
	exec vd8_main @run_cur_vd8 out
	
	declare @id nvarchar(50), @name nvarchar(50), @sdh int, @tongTien money, @ssp int
	fetch first from @run_cur_vd8 into @id, @name, @sdh, @tongTien, @ssp
	while @@FETCH_STATUS = 0
		begin
			if(@tongTien is null) print @name + N' Chưa từng mua hàng'
			else
				print @id + ' - ' + @name + ' - ' + cast(@sdh as char(10)) + ' - ' + cast(@tongTien as char(10)) + ' - ' + cast(@ssp as char(10))
			fetch next from @run_cur_vd8 into @id, @name, @sdh, @tongTien, @ssp
		end
	close @run_cur_vd8
	deallocate @run_cur_vd8

	-- the end, hihi :))) 

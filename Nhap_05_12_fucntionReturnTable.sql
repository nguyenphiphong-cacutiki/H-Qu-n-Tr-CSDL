------------------------------------ hàm trả về một bảng ------------------------------------
----------- cú pháp 2
create function ftb_demo(@birthDay int)
	returns table as
	return (select * from SINHVIEN where SINHVIEN.Nssv > @birthDay)

	drop function function_demo

	select * from ftb_demo(1999)
	select * from SINHVIEN
	--vd1 a viết hàm trả về tổng thu nhập của mỗi ngày
	--    b sử dụng hàm trên in ra ngày có tổng thu nhập nhỏ nhất
	use qlmb
	--a
	create function ftb_hd1()
		returns table as
		return (select d.NgayDatHang, sum(d.tongTien) as tongTien from DonHang d group by d.NgayDatHang)

		select * from ftb_hd1()
	--b
	select * from ftb_hd1() f where f.tongTien >= all 
		(select tongtien from ftb_hd1())

	-- vd2. viết một hàm trả về số lượng tổng số lượng bán ra của mỗi sản phẩm
	-- gọi hàm trên để đưa ra tên sản phẩm bán được nhiều nhất.
	create function ftb_vd2()
		returns table as
		return (select sp.IDSanPham, s.TenSP, sum(sp.SoLuong) as TongSo
			from SP_DonHang sp inner join SanPham s on sp.IDSanPham = s.IdSanPham
			group by sp.IDSanPham, s.TenSP)
	-- gọi hàm 
	select * from ftb_vd2() f where f.TongSo = 
				(select max(TongSo) from ftb_vd2())
--------------------- cú pháp 1
	
	create function ftb_vd1_() 
	returns @x table(ngay date, dt money) as
	begin
		insert into @x 
		select ngaydathang, sum(tongtien) from
		DonHang group by NgayDatHang
	return
	end

	-- bt1. 
	--a viết hàm trả về doanh thu của một ngày bất kỳ
	create function fun_bt01(@ngay date)
		returns int as
		begin
			return (select sum(d.tongtien) from DonHang d where d.NgayDatHang = @ngay)
		end
	--b viết 1 hàm gọi hàm trên để trả về doanh thu của mỗi ngày
	alter function DoanhThuMn()
	returns table 
	return (select  d.NgayDatHang, dbo.fun_bt01(d.ngaydathang) as TongTien 
	from DonHang d group by d.NgayDatHang)
	use qlmb

	select * from DoanhThuMn()


	

	-- bt2
	-- a. viết một hàm trả về số tiền mua của mỗi khách hàng
	-- b. thêm cột điểm tích lũy vào bảng khách hàng. gọi hàm trên để cập nhật cột điểm tích lũy như sau
	-- diemtichluy = 10 nếu kh đã tiêu >= 1 triệu

	-- a. viết một hàm trả về số tiền mua của mỗi khách hàng
	create function getMoneyByKhach()
	returns table 
	return (select k.IDKhachHang, k.HoTen, sum(d.TongTien) as TongTienMua
			from DonHang d inner join KhachHang k on d.IDKhachHang = k.IDKhachHang
			group by k.IDKhachHang, k.HoTen)

	-- b. thêm cột điểm tích lũy vào bảng khách hàng. gọi hàm trên để cập nhật cột điểm tích lũy như sau
	-- diemtichluy = 10 nếu kh đã tiêu >= 1 triệu
	alter table khachhang 
	add diemTichLuy int default 0

	update KhachHang set diemTichLuy = 10 from KhachHang k inner join getMoneyByKhach() g
			on k.IDKhachHang = g.IDKhachHang where g.TongTienMua >= 1000000

			select * from KhachHang

			
				















		/* edit data
		update DonHang set TongTien = 0 where TongTien = NULL

		select * from DonHang
		select * from SP_DonHang
		insert into SP_DonHang values (8, 4, 10, 0), 
									(9, 4, 100, 0),
									(10, 4, 9, 0),
									(11, 4, 10, 0)
		update DonHang set TongTien = 
				(select sum(thanhtien) from SP_DonHang sp where sp.IDDonHang = DonHang.IDDonHang)*/
									

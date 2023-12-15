-------------------------- Trigger ----------------------------
/* - thực hiện một cách tự động, không cần gọi. giống thủ tục nhưng không có đầu vào, đầu ra.
	nó là một bẫy dữ liệu.
   - Mục đích: 
	+ kiểm tra dữ liệu nhập vào có đúng không (tính toàn vẹn của dữ liệu, hay các ràng buộc cho dữ 
	  liệu)
	+ dùng để tự động tính toán. 
	- chia làm 2 nhóm: 
		+ DML trigger: tự động thực hiện khi có lệnh insert thành công, update, delete

*/
use QLSV
-- DML
-- viết trigger để khi thâm mới 1 bản ghi vào bảng sinh viên thì tự hiện ra thông báo đã thêm thành công
create trigger triggerOne on sinhvien
after insert as 
print N'Thêm thành công'


select * from SINHVIEN
insert into SINHVIEN values(N'SV23', N'SVHo23', N'Name23', 2003, N'09-KDT', 1, N'K1', N'Nữ')
-- viết trigger in ra thông báo xóa thành công khi xóa 1 bản ghi trong bảng sinhvien
create trigger triggerTwo on sinhvien
after delete as
print N'Xóa thành công'

delete from SINHVIEN where Masv = N'SV23'



-- viết trigger để tự động update thành tiền khi thêm một sp vào đơn hàng
alter trigger triggerFive on sp_donhang
for insert, update, delete as
	--select * from inserted
	--select * from deleted
	update sp_donhang set thanhtien = sp.SoLuong * s.DonGia from sp_donhang sp inner join sanpham s
	on sp.idsanpham = s.idsanpham
	where sp.idsanpham in (select idsanpham from inserted)
	and sp.iddonhang in (select iddonhang from inserted)
		-- check
		insert into SP_DonHang(IDSanPham, IDDonHang, SoLuong)
		values(1, 9, 3)


-- show all triggers
select * from sys.triggers


-- viết 1 trigger để khi ng dùng sửa thông tin 1 bản ghi trong bảng sp_donhang thì trường
-- thanhtien cũng được tự động cập nhật theo
	-- giải câu phía trước đã bao gồm lời giải cho câu hỏi này :3


use qlmb
/* BTVN
1. viết 1 trigger để khi thêm 1 sp mới vào thì: 
	- nếu sp đó đã có trong csdl thì in ra "bạn không thêm đc"
	- nếu sp chưa có thì cho thêm và in "bạn thêm thành công"
2. viết 1 hàm tính tổng tiền của 1 hóa đơn bất kỳ, 
viết trigger gọi hàm trên để tự động cập nhật trường tổng tiền của hóa đơn.
*/
-- câu 1: 
use qlmb
create trigger trigBt01 on sanpham
for insert as
	begin
		if((select count(tensp) from SanPham where TenSP in (select tensp from inserted))>=2)	
			begin
				print 'insert fail'
				rollback transaction
			end
		else
			print 'insert success'
	end

	-- check
	select * from SanPham
	insert into SanPham values(N'SanPham12', N'Mô tả sp11', 200000)
-- câu 2: 
create function getSumMoney(@idDonHang char(50))
returns money as
	begin
		return (select sum(thanhtien) from SP_DonHang where IDDonHang = @idDonHang)
	end

alter trigger trigUpdateHoaDon on sp_DonHang 
for insert, update as
	begin 
		update DonHang set TongTien =  dbo.getSumMoney(IDDonHang) where IDDonHang in
			(select IDDonHang from inserted)
	end


----------------------- instead of
/* thay vì insert trực tiếp vào bảng chính thì thực hiện insert vào bảng inserted, sau đó trigger
được kích hoạt để thực hiện một số câu lệnh, có thể thực hiện insert dữ liệu đó vào bảng chính
với dữ liệu từ bảng inserted*/
-- viết 1 instead of để khi thêm sinh viên mới vào để check masv ko trùng
use QLSV
create trigger trigBt03 on sinhvien
instead of insert as
begin
	if(exists(select tensv from SINHVIEN where tensv in (select tensv from inserted)))	
		print 'fail';
	else
		insert into SINHVIEN select * from inserted

end

select * from SINHVIEN
insert into SINHVIEN values(N'SV24', N'Trần', N'A18', 2004, N'Dia chi', 0, N'K1', N'Nam')




------------ Bài tập về nhà phần trigger:
-- bt01: thêm cột dtb vào bảng sinhvien, viết trigger để khi thêm/ sửa điểm của sinh viên thì trigger
-- đó sẽ tự động cập nhật dtb.

-- bt02: tạo view(masv, tensv, mamh, tenmh) 
-- viết trigger để cho phép thực hiện được hành động thêm dữ liệu vào bảng gốc sinh viên và môn học thông
-- qua view trên.











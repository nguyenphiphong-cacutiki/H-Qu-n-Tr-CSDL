use qlsv
-- select lồng nhau
select distinct masv, xeploai = 
(
case 
	when exists (select * from diemsv where diem < 4 and masv = d.masv)
		then N'Nợ môn'
	else N'Qua môn'
end
)
from diemsv d
------------------------- vòng lặp while -------------------------
-- tính tổng các số nguyên từ 1 - 100
declare @sum int
declare @i int
set @sum = 0
set @i = 1
while @i <= 100
 begin
	set @sum = @sum + @i
	set @i = @i + 1
 end
print rtrim(N'Tổng là: ' + cast (@sum as char(10)))
------------------------- sử dụng biến kiểu con trỏ -------------------------
-- con trỏ có thể chứa nhiều bản ghi (chứa nhiều giá trị)
-- @dtb chỉ chứa được giá trị của 1 sinh viên
-- muốn lấy ra nhiều giá trị thì dùng biến con trỏ
-- Các bước: 
	--1. khai báo biến, không cần @, mặc định là cục bộ
	declare cur_dtb cursor dynamic scroll -- dynamic: động, dữ liệu thay đổi khi dữ liệu trong bảng thay đổi
										-- scroll: di chuyển được cả hai chiều
	-- sau for luôn là câu lệnh select
	for select masv, avg(diem) from diemsv group by masv
	-- lúc này con trỏ sẽ chứa dữ liệu lấy ra từ lệnh select
	-- để đọc con trỏ thì dùng lệnh open
	open cur_dtb
	-- thông thường sẽ dùng lệnh while để duyệt các bản ghi trong con trỏ
	-- sử dụng con trỏ trên để in ra theo mẫu: SV... có điểm trung bình là
	declare @x char(10), @y float
	fetch last from cur_dtb into @x, @y
	while @@FETCH_STATUS = 0
		begin
			print N'Sinh viên ' + trim(@x) + N' Có điểm trung bình là: ' + cast(@y as char(5)) 
			fetch prior from cur_dtb into @x, @y
		end
	close cur_dtb

	deallocate cur_dtb
	-- sử dụng con trỏ để in ra số lượng sinh viên nữ của mỗi lớp theo biểu mẫu
	--
	select * from SINHVIEN
	declare cur_sv cursor dynamic scroll
	for select malop, count(*) as soluong from sinhvien where gt = N'Nữ' group by Malop
	open cur_sv
	declare @malop char(3), @sl int
	fetch next from cur_sv into @malop, @sl
	while @@FETCH_STATUS = 0
		begin
			print cast(N'Lớp ' as nvarchar(10)) + @malop + N' có ' + cast(@sl as char(3)) + N' sinh viên nữ'
			fetch next from cur_sv into @malop, @sl
		end
	close cur_sv
	deallocate cur_sv


	--vd a:  sử dụng con trỏ để in ra số lượng sinh viên thi trượt của mỗi môn học
	declare cur_sv cursor dynamic scroll
	for select mamh, count(*) as soluong from DIEMSV where diem <4 group by mamh
	-- open
	open cur_sv
	declare @max int
	set @max = 0
	declare @mamh char(8), @sl int
	fetch first from cur_sv into @mamh, @sl
	while @@FETCH_STATUS = 0
		begin
			print N'Môn học ' + @mamh + N' có ' + cast(@sl as char(3)) + N' SV thi trượt'
			fetch next from cur_sv into @mamh, @sl
		end

	-- close and deallocate
	close cur_sv
	deallocate cur_sv

	--vd b:  sử dụng con trỏ để in ra số lượng sinh viên thi trượt nhiều môn nhất.
	declare cur_sv cursor dynamic scroll
	for select mamh, count(*) as soluong from DIEMSV where diem <4 group by mamh
	-- open
	open cur_sv
	declare @max int
	set @max = -1
	declare @mamh char(5), @sl int
	fetch first from cur_sv into @mamh, @sl
	while @@FETCH_STATUS = 0
		begin
			if(@sl > @max) set @max = @sl
			print N'Môn học ' + @mamh + N' có ' + cast(@sl as char(3)) + N' SV thi trượt'
			fetch next from cur_sv into @mamh, @sl
		end
	declare @mamh_max char(5), @sl_max int
	fetch first from cur_sv into @mamh_max, @sl_max
	while @@FETCH_STATUS = 0
		begin
			if(@sl_max = @max) 
				print N'Môn học ' + @mamh_max + N' có sinh viên trượt nhiều nhất'
			fetch next from cur_sv into @mamh_max, @sl_max
		end
	-- close and deallocate
	close cur_sv
	deallocate cur_sv

	-- BTVN
	-- BT1: Sử dụng con trỏ để in Tên SV và DTB của SV đó
	-- BT2: sử dụng con trỏ để in ra dtb và xếp loại 
	-- của mỗi SV ( dtb>=8.5: loại Giỏi
            -- 7<=dtb<8.5: loại khá
			 --dtb<7: loại TB)
	-- ? dùng con trỏ điểm thi CSDL của học sinh nam của lớp CNTT1
	-- in ra điểm thi
	declare cur_diem cursor dynamic scroll
	for select s.Tensv, d.Diem from diemsv d inner join sinhvien s on d.Masv = s.Masv
	where gt = N'Nữ' and s.Malop = N'TH1' and d.Mamh = N'CSE460'
	
	open cur_diem
	declare @name nvarchar(50), @diem int

	fetch first from cur_diem into @name, @diem
	while @@FETCH_STATUS = 0
		begin 
			print N'sinh vien ' + @name + N' co diem: ' + cast(@diem as char(5))
			fetch next from cur_diem into @name, @diem
		end

	close cur_diem
	deallocate cur_diem

	select * from SINHVIEN where Malop = N'TH1'

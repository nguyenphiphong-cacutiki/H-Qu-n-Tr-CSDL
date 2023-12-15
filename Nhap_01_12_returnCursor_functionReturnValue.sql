-- viết thủ tục trả về danh sách các sinh viên nữ của lớp
-- -------------------------------=> thủ tục trả về biến kiểu con trỏ ------------------------------------------
create proc proc_cur1 (@x char(10), @y cursor varying out) as
begin
	set @y = cursor for 
	select s.Hosv from SINHVIEN s where s.Gt = N'Nữ' and s.Malop = @x 
	open @y
end

declare @cur_a cursor, @name nvarchar(40)
exec proc_cur1 N'K1',@y = @cur_a  out
fetch next from @cur_a
while @@FETCH_STATUS = 0
	begin 
		fetch next from @cur_a into @name
	end
	
	deallocate @cur_a
	-- viết thủ tục trả về danh sách các môn học và số sinh viên thi trượt của mỗi môn
	-- gọi thủ tục trên để in ra các môn học có số sinh viên thi trượt nhiều nhất
	alter proc proc_vd02(@cur_mh cursor varying out) as
	begin
		set @cur_mh = cursor dynamic scroll for
		select  d.Mamh, count(distinct d.Masv) as soluong from DIEMSV d
		where d.Diem < 4 group by d.Mamh
		open @cur_mh
	end

	declare @cur_b cursor, @mamh varchar(50), @sl int, @max int; set @max = 0
	exec proc_vd02 @cur_b out
	fetch next from @cur_b into @mamh, @sl
	while @@FETCH_STATUS = 0
		begin
			if(@max <= @sl) set @max = @sl
			fetch next from @cur_b into @mamh, @sl
		end

	fetch first from @cur_b into @mamh, @sl
	while @@FETCH_STATUS = 0
		begin
			if(@sl = @max) print @mamh
			fetch next from @cur_b into @mamh, @sl
		end
		close @cur_b
		deallocate @cur_b


------------------------------------------ hàm trả về giá trị duy nhất ------------------------------------------
-- VD1: viết một hàm trả về số lượng sinh viên của lớp bất kỳ
create function CountSv (@malop nvarchar(50)) returns int as
	begin
		declare @sl int
		select @sl = count(masv) from sinhvien where malop = @malop
		return @sl
	end

	-- gọi hàm
	print dbo.CountSv(N'TH1')
	select dbo.countsv(N'TH1')
-- VD2: cho biết lớp nào có số lượng sv lớn hơn TH1
select malop from sinhvien s group by s.Malop having count(s.masv) > dbo.CountSv(N'TH1')
-- VD3: viết một hàm trả về số môn học thi trượt lần 1 của một sinh viên bất kỳ
	alter function getSubjectFail(@masv nvarchar(50))
	returns int as
	begin
		declare @sl int
		select @sl =  count(*) from DIEMSV d where d.Diem <5 and d.Masv = @masv and d.lan = 1
		return @sl
	end
-- sử dụng hàm trên để
select * from SINHVIEN
use qlsv
-- a. in ra số môn thi trượt của nva
declare @x int;
select dbo.getSubjectFail(masv) from SINHVIEN s where s.Tensv = N'A01'
-- b. hiển thi tên những sv thi trượt nhiều môn nhất

-- cách 1
select masv, tensv from SINHVIEN s where dbo.getSubjectFail(masv) >= all 
				(select dbo.getSubjectFail(masv) from SINHVIEN)
-- cách 2
select masv, tensv from SINHVIEN s where dbo.getSubjectFail(masv) = 
						(select max(dbo.getSubjectFail(masv)) from SINHVIEN)





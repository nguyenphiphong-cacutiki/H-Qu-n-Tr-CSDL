-- thủ tục
-- là một đoạn chương trình hoàn chỉnh, thực hiện xong 
-- một công việc. 
-- thủ tục là một đối tượng được lưu trữ lại trong server
-- -> có create trong câu lệnh
create procedure proc_vd1 (@name int) as
	begin
		print cast(@name as char(10))
	end

	-- vd: viết câu lệnh in ra sl sv nam của lớp TH1
	declare @sl int
	select @sl =  count(*) from sinhvien s where s.gt = N'Nam' 
			and s.Malop = N'TH1'
	execute proc_vd1 @sl
	-- vd2 viết thủ tục in ra sl sv thi trượt một môn học
	create proc print_sv_fail(@mamh nvarchar(20)) as
		begin
			declare @num int
			select @num = count(distinct masv) from diemsv 
			where diem < 4 and Mamh	 = @mamh
			print N'so luong ' + cast(@num as char(10))
		end
	drop proc print_sv_fail
		exec print_sv_fail N'CSE460'

	-- vd3: 
	create proc print_x(@mamh char(20))as
		begin
			declare cur cursor dynamic scroll
			for select s.Tensv, d.diem from DIEMSV d inner join sinhvien s on d.masv = s.masv where Mamh = @mamh
			and diem = (select max(diem) from DIEMSV d where Mamh = @mamh)
		
			if (exists(select d.Masv, Diem from DIEMSV d where Mamh = @mamh
				and diem = (select max(diem) from DIEMSV d where Mamh = @mamh)))
				begin -- begin if
					open cur
					declare @masv nvarchar(40), @diem int
					fetch first from cur into @masv, @diem
					while @@FETCH_STATUS = 0
						begin
							print N'sinh vien ' + @masv + N' co diem: ' + cast(@diem as char(10))
							fetch next from cur into @masv, @diem
						end
					
				end -- end if
			else print N'khong ton tai ma sinh vien do'
			DEALLOCATE CUR
		end
		-- 
	EXEC print_x N'CSE460'
	use qlsv
	drop proc print_x


	--  thủ tục có tham số là output: thủ tục tính toán và lưu giá trị vào output
	-- vd:  viết thủ tục tính số sinh viên nam của lớp 'TH1' lưu vào 1 tham số output

	
	alter proc pro_vd5 @x int out as
	begin
		select @x = count(masv) from sinhvien s where s.Malop = N'TH1' and gt = N'Nam'
	end
	declare @sl int
	exec pro_vd5 @sl out
	print N'Số lượng sinh viên nam của lớp TH1 là: ' + cast(@sl as char(10))

	-- btvn01 viết thủ tục A trả về sl sinh viên của lớp TH1
	-- viết thủ tục B in ra các lớp có số lượng sinh viên lớn hơn số lượng sinh viên của lớp TH1
	create proc pro_A @sl int out as
	begin
		select @sl = count(masv) from SINHVIEN s where s.Malop = N'TH1'
	end

	create proc pro_B as
	begin
		declare @sl int
		exec pro_A @sl out
		
		select s.Malop, count(s.malop) as [số lượng] from SINHVIEN s group by s.Malop
		having count(s.malop) > @sl
	end
	exec pro_B
	/* -- insert more data
	select * from SINHVIEN
	insert into SINHVIEN values
	(N'SV18', N'Trần', N'A17', 2001, N'Trần Nguyên Đán', 0, N'K1', N'Nữ'),
	(N'SV16', N'Trần', N'A16', 2001, N'Khúc Thừa Dụ', 0, N'TH2', N'Nam'),
	(N'SV17', N'Trần', N'A17', 2001, N'Trần Nguyên Đán', 0, N'K1', N'Nữ')*/

	-- btvn02 viết thủ tục trả về mã lớp có sl sinh viên giỏi nhiều nhất (dtb >= 8.5 lần 1)
	create proc pro_btvn02(@lan int) as
	begin
		select sv_l.malop from (select s.Malop as malop, dsv.Masv as masv from (select d.Masv, avg(d.Diem) as dtb from DIEMSV d where d.Lan = 1
		group by d.Masv having avg(d.Diem) >= 8.5) as dsv inner join SINHVIEN s on dsv.Masv = s.Masv) as sv_l
		group by sv_l.malop having count(*) >= all (select count(*) from (select s.Malop as malop, dsv.Masv as masv from (select d.Masv, avg(d.Diem) as dtb from DIEMSV d where d.Lan = 1
												group by d.Masv having avg(d.Diem) >= 8.5) as dsv inner join SINHVIEN s on dsv.Masv = s.Masv) as sv_l group by sv_l.malop)
	end
	exec pro_btvn02 1

	--- cách khác
	create proc VD
	as begin
	declare cur_vd cursor dynamic scroll
	for select dsv.malop, count(masv) as soluong  from (select s.Malop, s.Masv, avg(d.diem) as dtb from DIEMSV d 
	inner join SINHVIEN s on d.Masv = s.Masv
	group by s.Malop, s.Masv
	having avg(diem) >= 8.5) as dsv group by dsv.Malop
	
	open cur_vd
	declare @ml char(10), @sl int, @max int;
	set @max = -1
	FETCH FIRST from cur_vd into @ml, @sl
	while (@@FETCH_STATUS = 0)
	begin
		if(@sl >= @max) set @max = @sl
		FETCH NEXT from cur_vd into @ml, @sl;
	end
	FETCH FIRST from cur_vd into @ml, @sl
	while (@@FETCH_STATUS = 0)
	begin
		if(@sl = @max) print @ml
		FETCH NEXT from cur_vd into @ml, @sl;
	end
	close cur_vd
	deallocate cur_vd
end;
use QLSV
exec vd
	/* -- INSERT MORE DATA
	select * from DIEMSV
	insert into DIEMSV values
	(N'SV18', N'CSE461', 1, 10),
	(N'SV16', N'CSE460', 1, 9),
	(N'SV16', N'CSE461', 1, 10),
	(N'SV17', N'CSE460', 1, 9),
	(N'SV17', N'CSE461', 1, 10) */

	 
	





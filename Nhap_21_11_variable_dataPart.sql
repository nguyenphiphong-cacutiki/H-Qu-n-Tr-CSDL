use QLSV
-- ?1 tính số lượng sv thi trượt môn csdl lần và gán vào biến x
declare @x int
select @x = count(*) from diemsv d inner join monhoc m on d.mamh = m.mamh
	where m.tenmh = 'CSDL' and d.lan = 1 and d.diem < 4
print N'Số sinh viên thi trượt môn CSDL lần 1 là '+ cast(@x as char (3))

-- select ký tự đại diện
select * from sinhvien where tensv like N'[LN]_[^u]%' 
insert into SINHVIEN
values('13',N'Ngayễn',N'Laan',2003,N'Phú Thọ',N'Không','K1')
-- lấy tên máy
select @@SERVERNAME
-- các hàm
print RTrim(N'Nguyễn Văn A      ') + '--'
print charindex(N'Văn', N'Nguyễn Văn A')
-- ! cho biết số lượng sv sinh vào năm 2000
select count(masv) as [Số lượng] from sinhvien where year(nssv) = 2000 and month (nssv) = 12
-- hàm datePart(tham số định dạng, ngày)
declare @thu char(100)
select @thu = datePart(dw, getDate())
print @thu+'_'

-- tính điểm trung bình lần 1 của sv1, nếu dtb >= 8.5 thì
-- 
declare @d real
select @d = avg(diem) from diemsv where lan = 1 and masv = '1'
if(@d >= 8.5)
	begin
		print N'giỏi'
		print N'hello'
	end
else
	print N'khá'
-- kiểm tra điểm thi của sv Nguyễn Văn A. Nếu điểm thi lần 1 và lần 2 đều <4 thì in ra 'học lại'
declare @x1 float
declare @x2 float
select @x1 =diem from diemsv where masv = N'1' and lan = 1 and mamh = 'CSE1'
select @x2 =diem from diemsv where masv = N'1' and lan = 2 and mamh = 'CSE1'

if(@x1 < 11 and @x2 < 11)
	print N'Phải học lại CSDL'
SELECT * from diemsv where masv = '1'
insert into DIEMSV
values
('1','CSE1',1,4),
('2','CSE1',1,3)

insert into DIEMSV
values
('1','CSE1',2,4),
('2','CSE1',2,3)
-- simple case
declare @x1 float
declare @x2 char(20)
select @x1 =diem from diemsv where masv = N'1' and lan = 1 and mamh = 'CSE1'

select @x2 = 
(
case @x1
	when 1 then '1'
	when 2 then '2'
	else  'other'
end
)
print @x1
-- cho hai biến x là int và y là char
-- gán giá trị cho y vs đk sau:
-- nếu x = 1 thì y = a
-- nếu x = 2 thì y = b
-- nếu x = 3 thì y = c
declare @x int
declare @y char(10)
set @x = 1
select @y = 
(
case
	when @x = 1 then 'a'
	when @x = 2 then 'b'
	when @x = 3 then 'c'
	else 'other'
end
)
print @y
-- btvn sử dụng 2 cách if và case để in ra tiếng việt hôm nay là thứ mấy trong tuần
	-- dùng if
	declare @x int
	declare @thu nvarchar(20)
	set @x = datepart(dw, GETDATE())
	if(@x = 1)
		set @thu = N'Chủ nhật'
	else if(@x = 2)
		set @thu = N'Thứ hai'
	else if(@x = 3)
		set @thu = N'Thứ ba'
	else if(@x = 4)
		set @thu = N'Thứ tư'
	else if(@x = 5)
		set @thu = N'Thứ năm'
	else if(@x = 6)
		set @thu = N'Thứ sáu'
	else
		set @thu = N'Thứ bảy'
	print N'Hôm nay là ' + @thu

	-- dùng simple switch case
	declare @x int
	declare @thu nvarchar(20)
	set @x = datepart(dw, GETDATE())
	set @thu = 
	(
	case @x
		when 1 then N'Chủ nhật'
		when 2 then N'Thứ hai'
		when 3 then N'Thứ ba'
		when 4 then N'Thứ tư'
		when 5 then N'Thứ năm'
		when 6 then N'Thứ sáu'
		else N'Thứ bảy'
	end
	)
	print N'Hôm nay là ' + @thu

	-- dùng search switch case
	declare @x int
	declare @thu nvarchar(20)
	set @x = datepart(dw, GETDATE())
	set @thu = 
	(
	case
		when @x = 1 then N'Chủ nhật'
		when @x = 2 then N'Thứ hai'
		when @x = 3 then N'Thứ ba'
		when @x = 4 then N'Thứ tư'
		when @x = 5 then N'Thứ năm'
		when @x = 6 then N'Thứ sáu'
		else N'Thứ bảy'
	end
	)
	print N'Hôm nay là ' + @thu
		
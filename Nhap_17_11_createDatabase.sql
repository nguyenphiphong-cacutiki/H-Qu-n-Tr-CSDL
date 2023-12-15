create database demo
use demo
-- thay đổi tên file
alter database demo modify name = demohihi
use demohihi

-- tạo databse đầy đủ tham số
create database demo2
on primary
(
name = 'demo2FilePrimary',
fileName = 'C:\Users\DELL\OneDrive\Documents\SQL Server Management Studio\demoprimary.mdf',
size = 5,
maxSize = 50,
filegrowth = 1
)
log on
(
name = 'demo2FileLog',
fileName = 'C:\Users\DELL\OneDrive\Documents\SQL Server Management Studio\demolog.ldf',
size = 5,
maxSize = 50,
filegrowth = 1
)

-- lệnh nào bắt đầu bằng sp, là thủ tục có sẵn, như hàm trong lập trình.
-- thêm file cho database thì chỉ file ndf thôi, 2 file kia tự động tạo

create table lop(malop char(5) primary key, tenlop nvarchar(50))
create table sinhvien(masv char(50) , tensv nvarchar(50), malop char(5),
	foreign key (malop) references lop(malop))

drop table sinhvien
--alter table sinhvien add constraint check_masv_notnull check (masv not null)
alter table sinhvien add primary key (masv)

create table diem(masv char(10), mamh char(10), diem int)
insert into diem values('1', '12', 1)
alter table diem add constraint diemcheck check(diem >= 0  and diem <= 10)
select * from diem
insert into diem values(null, '12', 20)

--identity(a, b): increment from a, interval b

create table sinhvien(masv char(10), mak char(10))
--create table khoa(mak char(10), 
-- tang diem thi csdl 
-- update diem from diemsv set diem = diem + 1 where mamh in (select mamh from monhoc where tenmh = 'csdl')
-- chuong 2.2
-- lay ma sinh vien co diem = 1 gan cho bien @x
declare @x int
select @x = diem from diem where diem = 1
print 'score is: '+ cast(@x as char(10))
-- tinh diem tb cua sinh vien nguyen van a
declare @dtb float
select @dtb = avg (diem) from diemsv where masv = (select masv from sinhvien where tensv = N'nguyen van a')
print N'sinh vien nguyen van a co diem tb la: ' + cast(@dtb as char(20))

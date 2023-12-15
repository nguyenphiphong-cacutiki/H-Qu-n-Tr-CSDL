create database Test001
use test01
create table sinhvien(id char(20), name char(30), note char(100))
select * from sinhvien
insert into sinhvien values('01', 'name 01', 23)

------------------------ thao tác thêm sửa xóa cột ------------------------
-- thêm một cột
alter table sinhvien
add age int
-- sửa thuộc tính một cột
alter table sinhvien
alter column id char(30)
-- xóa một cột
alter table sinhvien
drop column note
------------------------ thêm ràng buộc cho cột ------------------------
-- add default
alter table sinhvien
add default '00' for id
--insert into sinhvien values(null, 'name 01', 23)
--insert into sinhvien values(3, 'name 01', 23)

-- add check
alter table sinhvien 
add check(age > 16 and age < 40)
--insert into sinhvien values(3, 'name 01', 11)
-- kiểm tra thuộc tính của các cột
SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sinhvien'

-- add identity
alter table sinhvien
add score int identity(0, 1) 
--select * from sinhvien
--delete from sinhvien where score = 1
--insert into sinhvien values('05','name 01', 33)
-- add primary key 
alter table sinhvien 
add primary key(score) 


------------------------ biến trong sql ------------------------
-- khai báo và dùng cơ bản
declare @x int
select @x = age from sinhvien where score = 2
print @x
select score from sinhvien where age = @x

------------------------ Hàm trong sql ------------------------
-- hàm sum
-- sum([distinct] biểu_thức)
use QLSV
select sum(diem) as [Tổng điểm] from diemsv
-- tương tự với hàm agv, count, max, min. lưu ý: các hàm này chỉ làm việc với bản ghi
-- khác null, gặp null thì bỏ qua -> count cột nào cũng là điều quan trọng, có thể cho ra
-- kết quả khác nhau

-- hàm xử lý chuỗi
-- ifelse
-- switch case


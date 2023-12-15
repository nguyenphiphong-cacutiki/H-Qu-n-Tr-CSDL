create database QLSV
use QLSV

----------- Khoa
create table KHOA
(
Makh nvarchar(50)  primary key,
Vpkh nvarchar(50)
);
insert into KHOA values('CNTT','C0'),('K','C1'),('CT','C2')

----------------- Lớp
create table LOP
(
Malop nvarchar(50)  primary key,
Makh nvarchar(50) foreign key (Makh) References KHOA(Makh)
);

insert into LOP
values('CT1','CT'),('TH1','CNTT'),('TH2','CNTT'),('K1', 'K'),('K2', 'K')

select * from LOP

------------------ Sinh viên ------------------
create table SINHVIEN
(
Masv nvarchar(50) primary key,
Hosv nvarchar(50),
Tensv nvarchar(50),
Nssv int,
Dcsv nvarchar(50),
Loptr bit,
Malop nvarchar(50) foreign key (Malop) References LOP(Malop),
Gt nvarchar(10) check(Gt = N'Nam' or Gt = N'Nữ')
);

insert into SINHVIEN values
('SV01', N'Trần', N'A01', 1998, N'Trần Thái Tông', 1, N'CT1', N'Nam'),
('SV02', N'Trần', N'A02', 2000, N'Trần Thái Tông', 0, N'CT1', N'Nữ'),
('SV03', N'Trần', N'A03', 2003, N'Trần Thái Tông', 0, N'CT1', N'Nữ'),

('SV04', N'Trần', N'A04', 2000, N'Trần Thái Tông', 1, N'TH1', N'Nam'),
('SV05', N'Trần', N'A05', 2003, N'Trần Thái Tông', 0, N'TH1', N'Nữ'),
('SV06', N'Trần', N'A06', 2003, N'Trần Thái Tông', 0, N'TH1', N'Nữ'),

('SV07', N'Trần', N'A07', 2003, N'Trần Thái Tông', 1, N'TH2', N'Nam'),
('SV08', N'Trần', N'A08', 2005, N'Trần Thái Tông', 0, N'TH2', N'Nữ'),
('SV09', N'Trần', N'A09', 1992, N'Trần Thái Tông', 0, N'TH2', N'Nam'),

('SV10', N'Trần', N'A10', 2003, N'Trần Thái Tông', 1, N'K1', N'Nam'),
('SV11', N'Trần', N'A11', 2005, N'Trần Thái Tông', 0, N'K1', N'Nữ'),
('SV12', N'Trần', N'A12', 1992, N'Trần Thái Tông', 0, N'K1', N'Nữ'),

('SV13', N'Trần', N'A13', 2002, N'Trần Thái Tông', 1, N'K2', N'Nữ'),
('SV14', N'Trần', N'A14', 2006, N'Trần Thái Tông', 0, N'K2', N'Nữ'),
('SV15', N'Trần', N'A15', 1997, N'Trần Thái Tông', 0, N'K2', N'Nam')




delete from SINHVIEN
select * from SINHVIEN
drop table SINHVIEN


------------ Môn học ------------
create table MONHOC
(
Mamh nvarchar(50) primary key,
Tenmh nvarchar(50),
LT int,
TH int
);
insert into MONHOC values
(N'CSE460', N'TTNM', 15, 15),
(N'CSE461', N'CNPM', 30, 15),
(N'CSE480', N'CNW', 45, 15)

select * from MONHOC
drop table MONHOC

---------- Chương trình học ----------
create table CTHOC
(
Malop nvarchar(50) foreign key (Malop) References LOP(Malop),
HK varchar(10),
Mamh nvarchar(50) foreign key (Mamh) References MONHOC(Mamh)
);
insert into CTHOC values
(N'CT1', 'HK1', N'CSE460'),
(N'CT1', 'HK2', N'CSE461'),
(N'CT1', 'HK3', N'CSE480'),

(N'TH1', 'HK1', N'CSE460'),
(N'TH1', 'HK2', N'CSE461'),
(N'TH1', 'HK3', N'CSE480'),

(N'TH2', 'HK1', N'CSE460'),
(N'TH2', 'HK2', N'CSE461'),
(N'TH2', 'HK3', N'CSE480'),

(N'K1', 'HK1', N'CSE460'),
(N'K1', 'HK2', N'CSE461'),
(N'K1', 'HK3', N'CSE480'),

(N'K2', 'HK1', N'CSE460'),
(N'K2', 'HK2', N'CSE461'),
(N'K2', 'HK3', N'CSE480')

select * from CTHOC
delete from cthoc
drop table CTHOC

----------- Điểm sinh viên -----------
create table DIEMSV
(
Masv nvarchar(50) foreign key (Masv) References SINHVIEN(Masv),
Mamh nvarchar(50) foreign key (Mamh) References MONHOC(Mamh),
Lan int,
Diem int
);
-- mỗi sinh viên thi 3 môn, mỗi môn 2 lần, một lần đầu, một lần trượt
insert into DIEMSV values
(N'SV01', N'CSE460', 1, 3), 
(N'SV01', N'CSE460', 2, 2), 
(N'SV01', N'CSE461', 1, 3), 
(N'SV01', N'CSE461', 2, 2),
(N'SV01', N'CSE480', 1, 2), 
(N'SV01', N'CSE480', 2, 0),

(N'SV02', N'CSE460', 1, 3), 
(N'SV02', N'CSE460', 2, 8), 
(N'SV02', N'CSE461', 1, 9), 
(N'SV02', N'CSE461', 2, 4),
(N'SV02', N'CSE480', 1, 2), 
(N'SV02', N'CSE480', 2, 7),

(N'SV03', N'CSE460', 1, 3), 
(N'SV03', N'CSE460', 2, 1), 
(N'SV03', N'CSE461', 1, 1), 
(N'SV03', N'CSE461', 2, 1),
(N'SV03', N'CSE480', 1, 2), 
(N'SV03', N'CSE480', 2, 1),

(N'SV04', N'CSE460', 1, 3), 
(N'SV04', N'CSE460', 2, 8), 
(N'SV04', N'CSE461', 1, 9), 
(N'SV04', N'CSE461', 2, 4),
(N'SV04', N'CSE480', 1, 2), 
(N'SV04', N'CSE480', 2, 7),

(N'SV05', N'CSE460', 1, 3), 
(N'SV05', N'CSE460', 2, 8), 
(N'SV05', N'CSE461', 1, 9), 
(N'SV05', N'CSE461', 2, 4),
(N'SV05', N'CSE480', 1, 2), 
(N'SV05', N'CSE480', 2, 7),

(N'SV06', N'CSE460', 1, 3), 
(N'SV06', N'CSE460', 2, 8), 
(N'SV06', N'CSE461', 1, 9), 
(N'SV06', N'CSE461', 2, 4),
(N'SV06', N'CSE480', 1, 2), 
(N'SV06', N'CSE480', 2, 0),

(N'SV07', N'CSE460', 1, 3), 
(N'SV07', N'CSE460', 2, 8), 
(N'SV07', N'CSE461', 1, 10), 
(N'SV07', N'CSE461', 2, 4),
(N'SV07', N'CSE480', 1, 2), 
(N'SV07', N'CSE480', 2, 7),

(N'SV08', N'CSE460', 1, 3), 
(N'SV08', N'CSE460', 2, 8), 
(N'SV08', N'CSE461', 1, 9), 
(N'SV08', N'CSE461', 2, 4),
(N'SV08', N'CSE480', 1, 2), 
(N'SV08', N'CSE480', 2, 7),

(N'SV09', N'CSE460', 1, 3), 
(N'SV09', N'CSE460', 2, 8), 
(N'SV09', N'CSE461', 1, 10), 
(N'SV09', N'CSE461', 2, 4),
(N'SV09', N'CSE480', 1, 2), 
(N'SV09', N'CSE480', 2, 7),

(N'SV10', N'CSE460', 1, 3), 
(N'SV10', N'CSE460', 2, 8), 
(N'SV10', N'CSE461', 1, 9), 
(N'SV10', N'CSE461', 2, 3),
(N'SV10', N'CSE480', 1, 2), 
(N'SV10', N'CSE480', 2, 7),

(N'SV11', N'CSE460', 1, 3), 
(N'SV11', N'CSE460', 2, 8), 
(N'SV11', N'CSE461', 1, 9), 
(N'SV11', N'CSE461', 2, 4),
(N'SV11', N'CSE480', 1, 1), 
(N'SV11', N'CSE480', 2, 7),

(N'SV12', N'CSE460', 1, 3), 
(N'SV12', N'CSE460', 2, 8), 
(N'SV12', N'CSE461', 1, 9), 
(N'SV12', N'CSE461', 2, 4),
(N'SV12', N'CSE480', 1, 2), 
(N'SV12', N'CSE480', 2, 8),

(N'SV13', N'CSE460', 1, 3), 
(N'SV13', N'CSE460', 2, 8), 
(N'SV13', N'CSE461', 1, 9), 
(N'SV13', N'CSE461', 2, 4),
(N'SV13', N'CSE480', 1, 2), 
(N'SV13', N'CSE480', 2, 7),

(N'SV14', N'CSE460', 1, 3), 
(N'SV14', N'CSE460', 2, 8), 
(N'SV14', N'CSE461', 1, 9), 
(N'SV14', N'CSE461', 2, 5),
(N'SV14', N'CSE480', 1, 2), 
(N'SV14', N'CSE480', 2, 7),

(N'SV15', N'CSE460', 1, 6), 
(N'SV15', N'CSE460', 2, 8), 
(N'SV15', N'CSE461', 1, 9), 
(N'SV15', N'CSE461', 2, 4),
(N'SV15', N'CSE480', 1, 2), 
(N'SV15', N'CSE480', 2, 10)

select * from DIEMSV
delete from diemsv
drop table DIEMSV
-- query data



--1. Cho biết danh sách lớp 
select * from LOP order by malop desc

--2. Cho biết danh sách sinh viên lớp TH1

select * from SINHVIEN where Malop = 'TH1' order by tensv asc

--3. Cho biết danh sách SV khoa CNTT

SELECT * FROM SINHVIEN WHERE Malop IN (SELECT Malop FROM LOP WHERE Makh = 'CNTT')

select * from sinhvien s inner join lop l on s.malop = l.Malop where l.makh = 'CNTT'



--4. Cho biết chương trình học của lớp TH1 
select * from cthoc where malop = 'TH1'



--5. Điểm lần 1 môn CSDL của SV lớp TH1
select s.tensv, d.diem from diemsv d inner join sinhvien s
	on s.masv = d.masv inner join monhoc m
	on m.mamh = d.mamh
	where d.lan = 1 and m.tenmh = 'CSDL' and s.malop = 'TH1'

--6. Điểm trung bình lần 1 môn CTDL của lớp TH1.

select  avg(d.diem) as diemTB from sinhvien s inner join diemsv d
	on s.masv = d.masv inner join monhoc m
	on d.mamh = m.mamh
	where m.tenmh = 'CTDL' and d.lan = 1 and s.malop = 'TH1'


--7. Số lượng SV của lớp TH2.
select count(masv) as [Sĩ số] from sinhvien where malop = 'TH2'



--8. Lớp TH1 phải học bao nhiêu môn trong HK1 và HK2.
select count(mamh) as [số môn học] from cthoc where malop = 'TH1' and (hk = 'HK1' or hk = 'HK2')


--9. Cho biết 3 SV đầu tiên có điểm thi lần 1 cao nhất môn CSDL.
select s.hosv, s.tensv, d.diem from diemsv d inner join monhoc m
	on d.mamh = m.mamh inner join sinhvien s
	on s.masv = d.masv
	where m.tenmh = 'CSDL' and d.lan = 1
	order by d.diem desc

--10. Cho biết sĩ số từng lớp.
select malop, count(*) as [số lượng] from sinhvien s group by s.malop

--11. Khoa nào đông SV nhất. 
select k.makh, count(k.makh) as [số lượng] from khoa k inner join lop l on k.makh = l.makh inner join sinhvien s on s.malop = l.malop
	group by k.makh having count(k.makh) >= all
	(select count(k.makh) from khoa k inner join lop l on k.makh = l.makh inner join sinhvien s on s.malop = l.malop
	group by k.makh)

	

--12. Lớp nào đông sinh viên nhất khoa CNTT. 
select l.malop, count(s.masv) from lop l inner join sinhvien s on l.malop = s.malop where makh = 'CNTT' group by l.malop 
	having count(s.masv) >= all
	(select count(s.masv) from lop l inner join sinhvien s on l.malop = s.malop where makh = 'CNTT' group by l.malop )


--13. Môn học nào mà ở lần thi 1 có số SV không đạt nhiều nhất. 
select d.mamh, count(d.masv) as sl from diemsv d where d.lan = 1 and d.diem < 5 group by d.mamh 
	having count(d.masv) >= all
	(select count(d.masv) as sl from diemsv d where d.lan = 1 and d.diem < 5 group by d.mamh )

--select * from diemsv

--insert into diemsv values('1232', 'CSE1', 1, 2), ('1230', 'CSE1', 1, 3)

--14. Tìm điểm thi lớn nhất của mỗi SV cho mỗi môn học (vì SV được thi nhiều lần). 
select masv, mamh, max(diem) from diemsv s group by mamh, masv

--15. Điểm trung bình của từng lớp khoa CNTT ở lần thi thứ nhất môn CSDL. 
select l.malop, avg(d.diem) as dtb from diemsv d inner join sinhvien s on d.masv = s.masv inner join lop l on l.malop = s.malop
inner join monhoc m on d.mamh = m.mamh
	where d.lan = 1 and m.tenmh = 'CSDL'
	group by l.malop

--16. Sinh viên nào của lớp TH1 đã thi đạt tất cả các môn học ở lần 1 của HK2. 
select masv from diemsv s inner join monhoc m on s.mamh = m.mamh inner join cthoc c on c.mamh = m.mamh
where malop = 'TH1' and lan = 1 and diem >= 5 and hk = N'Học kì 1'

--17. Danh sách SV nhận học bổng học kỳ 2 của lớp TH2, nghĩa là đạt tất cả các môn học của học kỳ này ở lần thi thứ nhất. 
-- lấy thông tin các bản ghi và điều kiện -> group hợp lý -> having hợp lý
select s.masv
from diemsv d inner join cthoc c on d.mamh = c.mamh inner join sinhvien s on s.masv = d.masv
where s.malop = 'TH1' and d.lan = 1 and c.hk = N'HK1' and d.diem > 5 
group by s.masv having count(d.mamh) =
(select count(*)
from diemsv d inner join cthoc c on d.mamh = c.mamh inner join sinhvien ss on ss.masv = d.masv
where ss.malop = 'TH1' and d.lan = 1 and c.hk = N'HK1' and s.masv = ss.masv)


-- select to check
select * from diemsv where masv = '6'
select * from cthoc

--18. Biết rằng lớp TH1 đã học đủ 6 học kỳ, cho biết SV nào đủ điều kiện thi tốt nghiệp,
--nghĩa là đã đạt đủ tất cả các môn
--nếu qua 1 lần là qua thì select như sau
select s.masv from sinhvien s inner join diemsv d
	on s.masv = d.masv
	where s.malop = 'TH1' and d.diem > 5
	group by s.masv having count(distinct mamh) = 
	(select count(distinct d.mamh) from sinhvien ss inner join diemsv d
	on ss.masv = d.masv
	where ss.malop = 'TH1' and s.masv = ss.masv ) 
-- nếu qua lần cuối mới qua thì select như sau
select s.masv from sinhvien s inner join diemsv d
	on s.masv = d.masv
	where s.malop = 'TH1' and d.diem > 5
		and lan = (select max(lan) from diemsv dd where dd.masv = s.masv and dd.mamh = d.mamh) 
	group by s.masv having count(distinct mamh) = 
	(select count(distinct d.mamh) from sinhvien ss inner join diemsv d
	on ss.masv = d.masv
	where ss.malop = 'TH1' and s.masv = ss.masv ) 
-- select để check
select * from diemsv d inner join sinhvien s
	on d.masv = s.masv
	where d.masv = '6' and s.malop = 'TH1'

select * from diemsv where masv = '4'
insert into diemsv values('4', 'CSE1', 2, 5)
insert into diemsv values('4', 'CSE3', 1, 3)
insert into diemsv values('6', 'CSE3', 2, 9)
insert into diemsv values('6', 'CSE3', 3, 4)








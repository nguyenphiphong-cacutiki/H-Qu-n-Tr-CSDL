create database DLGV
use DLGV
create table tbGiangVien(MaDD char(50), hoTen nvarchar(50), GT bit, donVi char(50), soCT int)
insert into tbGiangVien values('1221', N'Trần Văn Bình', 1, 'N01', 34),
								('1221', N'Trần Văn Bình', 1, 'N01', 34),
								('1321', N'Trần Đoạt Văn', 0, 'N01', 34),
								('1521', N'Định Duy Hiếu', 1, 'N01', 34),
								('1621', N'Trần Văn Kiên', 1, 'N11', 34)
select * from tbGiangVien
drop table tbGiangVien
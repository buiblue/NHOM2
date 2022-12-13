-- tạo bảng
CREATE TABLE LOP
(
	MALOP CHAR(3),
	TENLOP VARCHAR(40),
	SISO TINYINT,
	CONSTRAINT PK_LOP PRIMARY KEY (MALOP)
)
CREATE TABLE SINHVIEN
(
	MASV CHAR(5),
	HOTEN VARCHAR(40),
	NGAYSINH SMALLDATETIME,
	MALOP CHAR(3),
	CONSTRAINT PK_SINHVIEN PRIMARY KEY (MASV)
)
CREATE TABLE MONHOC
(
	MAMH VARCHAR(10),
	TENMH VARCHAR(40),
	CONSTRAINT PK_MONHOC PRIMARY KEY (MAMH)
)
CREATE TABLE KETQUA
(
	MASV CHAR(5),
	MAMH VARCHAR(10),
	DIEMTHI NUMERIC(4,2)
	CONSTRAINT PK_KETQUATHI PRIMARY KEY (MASV, MAMH)
)

--câu 1:
create function F_DiemTB(@MaSV varchar(10))
returns float
as
begin
declare @kq float
select @kq=avg(tb1.Diem)from 
(select distinct KetQua.MaSV, dbo.F_DiemThi(@masv,KetQua.MaMH) as Diem from KetQua 
where KetQua.MaSV=@masv)as tb1
return @kq
end
--CÂU 2:

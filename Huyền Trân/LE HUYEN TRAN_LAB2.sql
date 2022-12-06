--CÂU 1
use QLDA
go

declare @LuongNVcaonhat table(
	TenNVluongcaonhat nvarchar(40),
	Luong float
)
insert into @LuongNVcaonhat
	select CONCAT_WS(' ',HONV,TENLOT,TENNV), LUONG from NHANVIEN
	where LUONG = (select MAX(LUONG) FROM NHANVIEN )
	
	select * from @LuongNVcaonhat
--CÂU 2
use QLDA
go

declare @LuongNVTB table(
	TenNVluongtrenTB nvarchar(40),
	Luong float
)
insert into @LuongNVTB
	select CONCAT_WS(' ',HONV,TENLOT,TENNV), LUONG from NHANVIEN
	where LUONG > (select avg (LUONG) from NHANVIEN where PHG=5)
	select * from @LuongNVTB
--CÂU 3&4
SELECT (NHANVIEN.HONV + ' ' +NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV) AS 'Họ tên nhân viên có lương trung bình trên mức lương trung bình của phòng "Nghiên cứu”'
FROM NHANVIEN
WHERE NHANVIEN.LUONG > (SELECT AVG (NHANVIEN.LUONG)
	FROM NHANVIEN, PHONGBAN 
	WHERE NHANVIEN.PHG = PHONGBAN.MAPHG AND
		PHONGBAN.TENPHG = N'Nghiên cứu')

GO
SELECT TENPHG, COUNT (*) AS 'Số lượng nhân  viên làm việc'
FROM PHONGBAN, NHANVIEN
WHERE MAPHG = PHG
GROUP BY TENPHG 
HAVING AVG(LUONG)>3000
GO

GO
SELECT TENPHG, COUNT (*) 
FROM PHONGBAN, DEAN 
WHERE MAPHG = PHONG 
GROUP BY TENPHG 
--dean
SELECT *
FROM DEAN 
GO
--CHUVI&DIENTICH
DECLARE @chieudai int, @chieurong int, @chuvi int, @dientich int
SET @chieudai=5
SET @chieurong=6
SET @chuvi = (@chieudai+@chieurong)*2
SET @dientich = @chieudai*@chieurong
SELECT 'Chu vi' = @chuvi
SELECT 'Diện tích' = @dientich

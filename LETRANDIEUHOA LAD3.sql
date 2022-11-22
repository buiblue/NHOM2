--Xuất định dạng “tổng số giờ làm việc” kiểu decimal với 2 số thập phân.
select TENDA,cast(sum(ThoiGian) as decimal(5,2)) as 'tong so gionlam viec' from CONGVIEC
inner join DEAN on CONGVIEC.MADA=DEAN.MADA
inner join PHANCONG on CONGVIEC.MADA=PHANCONG.MADA
group by TENDA

select TENDA,convert(decimal(5,2),sum(ThoiGian)) as 'tong so gionlam viec' from CONGVIEC
inner join DEAN on CONGVIEC.MADA=DEAN.MADA
inner join PHANCONG on CONGVIEC.MADA=PHANCONG.MADA
group by TENDA

--Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên 
--làm việc cho phòng ban đó.
select TENPHG,cast(avg(luong) as decimal(10,2)) as ' luong trung binh' from NHANVIEN
inner join PHONGBAN on NHANVIEN.PHG=PHONGBAN.MAPHG
group by TENPHG

select TENPHG,convert(decimal(10,2),avg(luong))  as ' luong trung binh' from NHANVIEN
inner join PHONGBAN on NHANVIEN.PHG=PHONGBAN.MAPHG
group by TENPHG

--Xuất định dạng “luong trung bình” kiểu varchar. Sử dụng dấu phẩy tách cứ mỗi 3 chữ số
--trong chuỗi ra, gợi ý dùng thêm các hàm Left, Replace
select TENPHG,left(cast(avg(luong) as varchar(10)),3)+','
+replace(cast(avg(luong) as varchar(10)),left(cast(avg(luong) as varchar(10)),3),',') as ' luong trung binh' from NHANVIEN
inner join PHONGBAN on NHANVIEN.PHG=PHONGBAN.MAPHG
group by TENPHG

--Xuất định dạng “tổng số giờ làm việc” với hàm CEILING
select TENDA,ceiling(cast(sum(ThoiGian) as decimal(5,2))) as 'tong so gionlam viec' from CONGVIEC
inner join DEAN on CONGVIEC.MADA=DEAN.MADA
inner join PHANCONG on CONGVIEC.MADA=PHANCONG.MADA
group by TENDA
--Xuất định dạng “tổng số giờ làm việc” với hàm FLOOR
select TENDA,floor(cast(sum(ThoiGian) as decimal(5,2))) as 'tong so gionlam viec' from CONGVIEC
inner join DEAN on CONGVIEC.MADA=DEAN.MADA
inner join PHANCONG on CONGVIEC.MADA=PHANCONG.MADA
group by TENDA
--Xuất định dạng “tổng số giờ làm việc” làm tròn tới 2 chữ số thập phân
select HONV +' '+TENLOT+' '+ TENNV,LUONG from NHANVIEN
where luong>(select round( avg(luong),2) from NHANVIEN where phg=(select maphg from PHONGBAN where TENPHG= N'Nghiên Cứu'))
--Dữ liệu cột HONV được viết in hoa toàn bộ
select upper(HONV +' '+TENLOT+' '+ TENNV) from NHANVIEN

--Dữ liệu cột HONV được viết in hoa toàn bộ
--Dữ liệu cột TENLOT được viết chữ thường toàn bộ
select 
	UPPER ( HONV),
	LOWER ( TENLOT), tennv,
	LOWER (left(TENNV,1))+ upper(SUBSTRING(TENNV,2,1))+lower(SUBSTRING(TENNV, 3, LEN(tennv))),
	dchi,
	CHARINDEX (' ',DCHI),
	CHARINDEX (' ', dchi ),
	SUBSTRING(dchi,CHARINDEX(' ',DCHI )+1, CHARINDEX(',',dchi)-CHARINDEX(' ',DCHI) -1)
	from NHANVIEN 

--Cho biết các nhân viên có năm sinh trong khoảng 1960 đến 1965.
 --Cho biết tuổi của các nhân viên tính đến thời điểm hiện tại.
 --Dựa vào dữ liệu NGSINH, cho biết nhân viên sinh vào thứ mấy.
select* from NHANVIEN ;
select*from NHANVIEN 
WHERE DATENAME (year,ngsinh) >= 1960 and DATENAME(year,ngsinh)<= 1965

select a.*, DATEDIFF (year,ngsinh,getdate()) as Age from NHANVIEN a;
select a.*, DATENAME (week,ngsinh) from NHANVIEN a;


--Cho biết số lượng nhân viên, tên trưởng phòng, ngày nhận chức trưởng phòng và ngày
--nhận chức trưởng phòng hiển thi theo định dạng dd-mm-yy (ví dụ 25-04-2019)
select TENPHG, TRPHG,B.TENNV, NG_NHANCHUC, COUNT(A.MaNV) as ' SoLuongNV'
	from NHANVIEN A
inner join PHONGBAN on PHONGBAN.MAPHG  = A.PHG 
inner join NHANVIEN B on B.MANV  = PHONGBAN.TRPHG 
group by TENPHG, TRPHG, NG_NHANCHUC , B.TENNV 

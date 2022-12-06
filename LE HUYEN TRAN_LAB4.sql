--Viết chương trình xem xét có tăng lương cho nhân viên hay không. 
--Hiển thị cột thứ 1 là TenNV, cột thứ 2 nhận giá trị

select iif(luong>=ltb,'khong tang luong','tang luong') as thuong,tennv,luong,ltb
from
(select tennv,luong,ltb from NHANVIEN,
(select phg,avg(luong) as 'ltb' from NHANVIEN group by phg) as temp where NHANVIEN.PHG=temp.PHG) as abc

select * from NHANVIEN
select phg,avg(luong) as 'ltb' from NHANVIEN group by phg

--Viết chương trình phân loại nhân viên dựa vào mức lương.
declare @thongke table (phg int, LTB float);
insert into @thongke
select PHG,avg(luong) as LTB from NHANVIEN group by PHG;
select TENNV, LUONG,'chuc vu' = iif(luong>b.LTB,'truong phong','thanh vien')
from NHANVIEN a inner join @thongke b on a.PHG=b.phg;


--.Viết chương trình hiển thị TenNV như hình bên dưới, tùy vào cột phái của nhân viên

select tenv = case Phai
when 'nam' then 'Mr.'+[TenNV]
else
  'MS.' +[TenNV]
end
from NHANVIEN

--Viết chương trình tính thuế mà nhân viên phải đóng theo công thức:
select tennv,luong,thue=case 
when luong between 0 and 25000 then luong*0.1
when luong between 25000 and 30000 then luong*0.12
when luong between 30000 and 40000 then luong*0.15
when luong between 40000 and 50000 then luong*0.2
 else
 luong*0.25
end
 
from NHANVIEN
 --Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn.
 select * from NHANVIEN
 declare @dem int=2;
 while @dem<(select count(manv) from NHANVIEN)
 begin
 select* from NHANVIEN where cast (manv as int)= @dem
 set @dem= @dem +2;
 end
 --Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn nhưng
--không tính nhân viên có MaNV là 4.
select * from NHANVIEN;

declare @max int, @num int;

select @max = max(cast(manv as int)) from NHANVIEN;

set @num = 1;

while @num<=@max
begin 
if  @num =4
begin
set @num = @num +1;
continue;
end
if @num % 2 =0
select MANV,HONV,TENLOT,TENNV from NHANVIEN where cast(manv as int) = @num;
set @num = @num +1;
end;
--Thực hiện chèn thêm một dòng dữ liệu vào bảng PhongBan theo 2 bước
select * from PHONGBAN;

 begin try
 insert into PHONGBAN(TENPHG,MAPHG,TRPHG,NG_NHANCHUC)
 values (N'sản xuất',9,'009','2020-03-02');
	print N'them du lieu thanh cong';
 end try
begin catch
 print N'failure: chen du lieu that bai';
 end catch;
 --Chèn sai kiểu dữ liệu cột MaPHG để nhận thông báo lỗi “Them dư lieu that bai”
--từ khối Catch
select * from PHONGBAN;

 begin try
 insert into PHONGBAN(TENPHG,MAPHG,TRPHG,NG_NHANCHUC)
 values (N'sản xuất',7,'009','2020-03-02');
	print N'them du lieu thanh cong';
 end try
begin catch
 print N'failure: chen du lieu that bai';
 end catch;

 --Viết chương trình khai báo biến @chia, thực hiện phép chia @chia cho số 0 và dùng
--RAISERROR để thông báo lỗi.
begin try
declare @chia int;

set @chia =55/0;
end try
begin catch
declare @errorMessage nvarchar(2048), @errorSeverity int, @errorState int;
select @errorMessage = error_message(),
		@errorSeverity = error_severity(),
		@errorState = error_state();

	raiserror(@errorMessage, @errorSeverity, @errorState);
end catch;
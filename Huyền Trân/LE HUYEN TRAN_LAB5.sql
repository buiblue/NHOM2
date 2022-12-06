---- BAI1 ----
--a--
create procedure lab5_B1_a @name nvarchar(20)
as 
	begin
		print 'Xin chao: '+ @name
	end
execute lab5_B1_a N'Huyền Trân'
--b--
create procedure lab5_B1_b @s1 int, @s2 int
as 
	begin
		declare @sum int=0
		set @sum = @s1 + @s2
		print 'Tong: ' + cast(@sum as varchar(10))
	end
execute lab5_B1_b 3,4
--c--
create procedure lab5_B1_c @n int
as
	begin
		declare @tg int = 0, @i int = 0;
		while @i < @n
			begin 
				set @tg = @tg + @i 
				set @i = @i + 2 
			end
		print N'Tổng số chẵn là: ' + cast(@tg as varchar(10))
		end
execute lab5_B1_c 8
--d--
create procedure lab5_B1_d @a int, @b int
as
	begin
		while (@a != @b)
			begin 
				if(@a > @b)
					set @a = @a - @b
				else
					set @b = @b - @a
			end
			return @a
	end
declare @c int
execute @c = lab5_B1_d 160,40
print @c

---- BAI2 ----
--a--a-
create procedure lab5_B2_a @Manv nvarchar(20)
as 
	begin
		select * from NHANVIEN where MaNV = @Manv
	end
execute lab5_B2_a '005'
--b--b--
create procedure lab5_B2_B @MaDa numeric(20)
as 
	begin
		select count(MaNV) 
		as 'so luong nhan vien tham gia de an', MADA, TENPHG
		from NHANVIEN inner join PHONGBAN 
		on NHANVIEN.PHG= PHONGBAN.MAPHG
		inner join  DEAN on DEAN.PHONG =PHONGBAN.MAPHG
		where MADA = @MaDa
		group by TENPHG, MADA
	end
execute lab5_B2_B '30'
--c--c--
create procedure lab5_B2_C 
	@MaDa numeric(20), @Ddiem_DA nvarchar(15)
as 
begin
	select count(b.ma_nvien) as 'so luong'
	from DEAN a inner join PHANCONG b on a.MADA=b.MADA
	where a.MADA=@MaDa and a.Ddiem_DA = @DDiem_DA;
end;

execute lab5_B2_C 3,N'TP HCM'
---- BAI3 ----
----3.1----
create procedure lab5_B3_A 
	@MaPB int, @TenPB nvarchar(15),
	@MaTP nvarchar(9), @NgayNhanChuc date
as
	begin
		if(exists(select * from PhongBan where MaPHG = @MaPB ))
			print 'Them That Bai'
		else
			begin
				insert into PHONGBAN(MAPHG, TENPHG, TRPHG, NG_NHANCHUC)
				values(@MaPB,@TenPB,@MaTP,@NgayNhanChuc)
				print 'Them Thanh Cong'
			end
	end

execute lab5_B3_A  '8','CNTT','008','2020-10-06'
select * from PHONGBAN;

----3.2---
create procedure lab5_B3_B 
	@TenPHG_cu nvarchar(15),
	@TENPHG nvarchar(15),
	@MAPHG int,
	@TRPHG nvarchar(9),
	@NG_NHANCHUC date
as
begin
	UPDATE [dbo].[PHONGBAN]
		SET [TENPHG] = @TENPHG
			,[MAPHG] = @MAPHG
			,[TRPHG] = @TRPHG
			,[NG_NHANCHUC] = @NG_NHANCHUC
		WHERE TENPHG= @TenPHG_cu;
end;

execute lab5_B3_B  'CNTT','IT',10, '005', '1-1-2020'
SELECT * FROM PHONGBAN;

----3.3----
select HONV, TENLOT,TENNV, MANV,NGSINH,DCHI,PHAI,LUONG,MA_NQL,PHG from NHANVIEN 
insert into NHANVIEN(HONV, TENLOT, TENNV, MANV,NGSINH,DCHI,PHAI, LUONG,MA_NQL, PHG) 
values ('Nguyen', 'Van', 'Nam', '018', '2020-06-10', 'Da Nang', 'Nam', '25000', '004', '4') 

create procedure spInsertNhanVien
@HONV nvarchar(15), @TENLOT nvarchar(15),@TENNV nvarchar(15),
@MANV nvarchar(6),@NGSINH date,@DCHI nvarchar(50),@PHAI nvarchar(3), 
@LUONG float,@MA_NQL nvarchar(3) = null , @PHG int 
as
begin --proc 
	declare @age int
	set @age = YEAR(GETDATE()) - YEAR(@NGSINH)
	if @PHG =(select MaPHG from PHONGBAN where TENPHG = 'IT')
		begin --thuoc phong IT
			if @LUONG < 25000
				set @MA_NQL = '009'
			else set  @MA_NQL = '005'
			if(@PHAI = 'Nam' and (@age >=18 and @age <=65))
				or (@PHAI = N'Nu' and (@age >=18 and @age <=60))
				begin --do tuoi lao dong

					insert into NHANVIEN(HONV, TENLOT, TENNV, MANV,NGSINH,DCHI,
										PHAI, LUONG,MA_NQL, PHG) 
					values (@HONV, @TENLOT, @TENNV, @MANV, @NGSINH, @DCHI,
										@PHAI, @LUONG, @MA_NQL, @PHG) 

				end --do tuoi lao dong
			else
				print 'khong thuoc do tuoi lao dong'
		end --thuoc phong IT
	else
		print 'Khong phai phong ban IT'
end
execute spInsertNhanVien 'Nguyen', 'Van', 'Nam', '018', '2020-06-10', 'Da Nang',
							'Nam', '25000', '004', '4'
execute spInsertNhanVien 'Nguyen', 'Van', 'Nam', '019', '1955-06-10', 'Da Nang',
							'Nam', '25000', '004', '4'
execute spInsertNhanVien 'Nguyen', 'Hoang', 'Anh', '020', '1960-06-10', 'Da Nang',
							'Nam', '25000', '004', '4'
--In ra dòng ‘Xin chào’ + @ten với @ten là tham số đầu vào là tên Tiếng Việt có dấu của
--bạn.

create procedure  sp_xinchao
	@ten nvarchar(30)
as
begin
	print 'xin chào' + @ten;
end;

alter procedure sp_xinchao
	@ten nvarchar (30)
as
begin	
	print ' xin chào' +@ten;
end;

exec sp_xinchao N'bé';

--Nhập vào 2 số @s1,@s2. In ra câu ‘Tổng là : @tg’ với @tg=@s1+@s2.

create procedure  sp_sum
@s1 int, @s2 int
as
begin
declare @tg int;

set @tg = @s1 + @s2;
print N'tổng' + cast (@tg as varchar);
end;

alter procedure sp_sum
@s1 int,@s2 int
as
begin
declare @tg int;
set @tg = @s1 + @s2;
print N'tổng' + cast (@tg as varchar);
end;


exec sp_sum 5,6;

--Nhập vào số nguyên @n. In ra tổng các số chẵn từ 1 đến @n.
create procedure sp_sum
@n int
as
begin
declare @sum int, @i int;
set @sum=0;
set @i = 1;
while @i <= @n
begin
if @i % 2 =0
begin
 set @i = @i + 1;
 end;

 print N'tổng' + cast (@sum as varchar);
 end;

 exec sp_sum 10


 --Nhập vào 2 số. In ra ước chung lớn nhất
 create procedure sp_gcd
 @a int, @b int
 as
 begin
 declare @temp int;
 if @a > @b
 begin 
 select @temp = @a, @a = @b, @b = @temp;
 end
 while @b % @a != 0
 begin
 select @temp = @a, @a = @b % @a, @b = @temp;
 end;
 print N'ước số chung' + cast (@a as varchar);
 end;


 exec sp_gcd 20,9;
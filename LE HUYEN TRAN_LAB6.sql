--Ràng buộc khi thêm mới nhân viên thì mức lương phải lớn hơn 15000, nếu vi phạm thì
--xuất thông báo “luong phải >15000’
create trigger trg_insertNhanVien on NhanVien
for insert 
as
	if(select luong from inserted)<15000
		begin
			print 'Luong phai lon hon 15000'
			rollback transaction
		end
select * from NHANVIEN
insert into NHANVIEN 
values ('Tran','Phuong','Quang','011','01-01-1975','232A','Nam',17000,'005',1)


--Ràng buộc khi thêm mới nhân viên thì độ tuổi phải nằm trong khoảng 18 <= tuổi <=65.
create trigger trg_insertNhanVien2 on NhanVien
for insert
as
	declare @tuoi int
	set @tuoi = year(getdate())-(select year(NGSINH) FROM INSERTED)
	IF(@tuoi < 18 or @tuoi > 65)
		begin
			print 'Tuoi khong hop le'
			rollback transaction
		end

insert into NHANVIEN 
values ('Tran','Phuong','Quang','015','01-01-2007','232A','Nam',17000,'005',1)


--Ràng buộc khi cập nhật nhân viên thì không được cập nhật những nhân viên ở TP HCM
create trigger trg_UpdateNhanVien on NhanVien
for update
as
	if(select dchi from inserted) like '%TPHCM'
		begin 
			print 'Dia chi khong hop le'
			rollback transaction
		end
select * from NHANVIEN
update NHANVIEN set  HONV= 'Tran' where MANV ='009'


--bai2.
--Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động thêm mới nhân viên.
create trigger trg_insertNhanVien2a on NhanVien
after insert
as
	begin 
		select count(case when upper (PHAI) = N'Nam' then 1 end) Nam,
			count(case when upper(PHAI) = N'Nữ' then 1 end) Nữ
		from NHANVIEN
end

insert into NHANVIEN 
values ('Tran','Phuong','Quang','023','01-01-1975','232A',N'Nữ',17000,'005',1)
select * from NHANVIEN


create trigger trg_insertNhanVien2b on NhanVien
after insert
as
begin 
	if update (Phai)
		begin
			select count(case when upper (PHAI) = N'Nam' then 1 end) Nam,
				count(case when upper(PHAI) = N'Nữ' then 1 end) Nữ
			from NHANVIEN
		end
end
update NHANVIEN set PHAI = N'Nam' where MANV = '006'
select * from NHANVIEN

--Hiển thị tổng số lượng đề án mà mỗi nhân viên đã làm khi có hành động xóa trên bảng
--DEAN
create trigger trg_insert_DEAN on DEAN
after delete
as
	begin 
		select ma_nvien, count (MADA) as ' so luong du an' from PHANCONG 
		group by MA_NVIEN
	end

select * from DEAN
insert into DEAN values ('HTTT', 25, 'Ben Tre', 3)
delete from DEAN where MADA=25


--bài3
--Xóa các thân nhân trong bảng thân nhân có liên quan khi thực hiện hành động xóa nhân viên trong bảng nhân viên.
create trigger trg_delete_thannhan_NV on NHANVIEN
instead of delete
as
	begin
		delete from THANNHAN where MA_NVIEN in(select MANV from deleted)
		delete from NHANVIEN where MANV in (select MANV from deleted)
	end
select * from NHANVIEN
select * from THANNHAN
select * from PHANCONG
insert into THANNHAN values ('022','An','Nam','2009-01-01','Con Trai')
delete from NHANVIEN where MANV ='022'

--Khi thêm một nhân viên mới thì tự động phân công cho nhân viên làm đề án có MADA
--là 1.
create trigger trg_insert_NHANVIEN3b on NHANVIEN
after insert 
as
	begin
		insert into PHANCONG values ((select MANV from inderted),1,1,35)
	end
insert into NHANVIEN 
values ('Tran','Phuong','Quang','033','01-01-1975','232A',N'Nữ',17000,'005',1)
select * from NHANVIEN
select * from PHANCONG

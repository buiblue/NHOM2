create table VATTU
(
MAVT CHAR(4),
TENVT VARCHAR(40),
DVTINH VARCHAR(20),
SLCON NVARCHAR(100),
CONSTRAINT PK_VATTU PRIMARY KEY (MAVT)
)
CREATE TABLE HDBAN
(
MAHD int,
NGAYXUAT SMALLDATETIME,
HOTENKHACH VARCHAR(40),
CONSTRAINT PK_HBBAN PRIMARY KEY (MAHD)
)
CREATE TABLE HANGXUAT
(
MAHD int,
MAVT CHAR(4),
DONGIA money,
SLBAN INT,
CONSTRAINT PK_HANGXUAT PRIMARY KEY (MAHD,MAVT)
)
insert into VATTU values('BC01','But chi','cay',50)
insert into VATTU values('BT01','But Long','cay',20)

insert into HDBAN values('HD01','20-10-2020','TRAN THI A')
insert into HDBAN values('HD02','17-10-2021','TRAN THI B')

insert into HANGXUAT values('HD01','BC01',3000,'20')
insert into HANGXUAT values('HD01','BC01',3000,'10')
insert into HANGXUAT values('HD02','BT01',8000,'70')
insert into HANGXUAT values('HD01','BC01',8000,'10')

--CÂU 2:
select top 1 MAHD, sum(DONGIA) as TongTien from HANGXUAT group by MAHD,
DONGIA order by DONGIA desc
-- CÂU 3:
CREATE FUNCTION f3 (
    @MAHD varchar(10)
)
RETURNS TABLE
AS
RETURN
    SELECT 
        HX.MAHD,
        HD.NGAYXUAT,
        HD.MAVT,
        HX.DONGIA,
        HX.SLBAN,  
        CASE
            WHEN WEEKDAY(HD.NGAYXUAT) = 0 THEN N'Thứ hai'            
            WHEN WEEKDAY(HD.NGAYXUAT) = 1 THEN N'Thứ ba'
            WHEN WEEKDAY(HD.NGAYXUAT) = 2 THEN N'Thứ tư'
            WHEN WEEKDAY(HD.NGAYXUAT) = 3 THEN N'Thứ năm'
            WHEN WEEKDAY(HD.NGAYXUAT) = 4 THEN N'Thứ sáu'
            WHEN WEEKDAY(HD.NGAYXUAT) = 5 THEN N'Thứ bảy'
            ELSE N'Chủ nhật'
        END AS NGAYTHU
    FROM HANGXUAT HX
    INNER JOIN HDBAN HD ON HX.MAHD = HD.MAHD
    WHERE HX.MAHD = @MAHD;
--CÂU 4
CREATE PROCEDURE p4 
@thang int, @nam int 
AS
SELECT 
SUM(SLBAN * DONGIA)
FROM HANGXUAT HX
INNER JOIN HDBAN HD ON HX.MAHD = HD.MAHD
where MONTH(HD.NGAYXUAT) = @THANG AND YEAR(HD.NGAYXUAT) = @NAM;


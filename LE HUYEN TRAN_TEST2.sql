--Câu 1
/****** Object:  Table [dbo].[HangXuat] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HangXuat](
	[MaHD] [nchar](10) NOT NULL,
	[MaVT] [nchar](10) NOT NULL,
	[DonGia] [money] NULL,
	[SLBan] [tinyint] NULL,
 CONSTRAINT [PK_HangXuat] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC,
	[MaVT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HDBan] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HDBan](
	[MaHD] [nchar](10) NOT NULL,
	[NgayXuat] [smalldatetime] NULL,
	[HoTenKhach] [nchar](40) NULL,
 CONSTRAINT [PK_HDBan] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VatTu]    Script Date: 13/12/2022 2:12:27 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VatTu](
	[TenVT] [nchar](10) NULL,
	[MaVT] [nchar](10) NOT NULL,
	[DVTinh] [nchar](10) NULL,
	[SLCon] [smallint] NULL,
 CONSTRAINT [PK_VatTu] PRIMARY KEY CLUSTERED 
(
	[MaVT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[HangXuat] ([MaHD], [MaVT], [DonGia], [SLBan]) VALUES (N'01', N'A01', 3000, 10)
INSERT [dbo].[HangXuat] ([MaHD], [MaVT], [DonGia], [SLBan]) VALUES (N'02', N'B01', 6000, 30)
INSERT [dbo].[HangXuat] ([MaHD], [MaVT], [DonGia], [SLBan]) VALUES (N'03', N'A01', 3000, 15)
INSERT [dbo].[HangXuat] ([MaHD], [MaVT], [DonGia], [SLBan]) VALUES (N'04', N'B01', 6000, 20)
GO
INSERT [dbo].[HDBan] ([MaHD], [NgayXuat], [HoTenKhach]) VALUES (N'001', CAST(N'2019-03-27T00:00:00' AS SmallDateTime), N'Phạm Văn A                            ')
INSERT [dbo].[HDBan] ([MaHD], [NgayXuat], [HoTenKhach]) VALUES (N'002', CAST(N'2021-01-12T00:00:00' AS SmallDateTime), N'Phan Thị B                            ')
GO
INSERT [dbo].[VatTu] ([TenVT], [MaVT], [DVTinh], [SLCon]) VALUES (N'Tẩy', N'A01', N'cái', 785)
INSERT [dbo].[VatTu] ([TenVT], [MaVT], [DVTinh], [SLCon]) VALUES (N'Thước', N'B01', N'cái', 450)
GO
USE [master]
GO
ALTER DATABASE [QLHANG] SET  READ_WRITE 
GO


--CÂU2
use QLHANG
go
select top 1 MaHD, sum(DonGia) as TongTien from HangXuat group by MaHD, DonGia order by DonGia desc

--CÂU3
CREATE FUNCTION f3 (
    @MaHD varchar(10)
)
RETURNS TABLE
AS
RETURN
    SELECT 
        HX.MaHD,
        HD.NgayXuat,
        HD.MaVT,
        HX.DonGia,
        HX.SLBan,  
        CASE
            WHEN WEEKDAY(HD.NgayXuat) = 0 THEN N'Thứ hai'            
            WHEN WEEKDAY(HD.NgayXuat) = 1 THEN N'Thứ ba'
            WHEN WEEKDAY(HD.NgayXuat) = 2 THEN N'Thứ tư'
            WHEN WEEKDAY(HD.NgayXuat) = 3 THEN N'Thứ năm'
            WHEN WEEKDAY(HD.NgayXuat) = 4 THEN N'Thứ sáu'
            WHEN WEEKDAY(HD.NgayXuat) = 5 THEN N'Thứ bảy'
            ELSE N'Chủ nhật'
        END AS NGAYTHU
    FROM HangXuat HX
    INNER JOIN HDBan HD ON HX.MaHD = HD.MaHD
    WHERE HX.MaHD = @MaHD;

--CÂU4
CREATE PROCEDURE p4 
@thang int, @nam int 
AS
SELECT 
SUM(SLBan * DonGia)
FROM HangXuat HX
INNER JOIN HDBan HD ON HX.MaHD = HD.MaD
where MONTH(HD.NgayXuat) = @THANG AND YEAR(HD.NgayXuat) = @NAM;
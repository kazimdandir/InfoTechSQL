USE [master]
GO
/****** Object:  Database [Kutuphane]    Script Date: 10.03.2024 11:35:34 ******/
CREATE DATABASE [Kutuphane]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Kutuphane', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Kutuphane.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Kutuphane_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Kutuphane_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Kutuphane] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Kutuphane].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Kutuphane] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Kutuphane] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Kutuphane] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Kutuphane] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Kutuphane] SET ARITHABORT OFF 
GO
ALTER DATABASE [Kutuphane] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Kutuphane] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Kutuphane] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Kutuphane] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Kutuphane] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Kutuphane] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Kutuphane] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Kutuphane] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Kutuphane] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Kutuphane] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Kutuphane] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Kutuphane] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Kutuphane] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Kutuphane] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Kutuphane] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Kutuphane] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Kutuphane] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Kutuphane] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Kutuphane] SET  MULTI_USER 
GO
ALTER DATABASE [Kutuphane] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Kutuphane] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Kutuphane] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Kutuphane] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Kutuphane] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Kutuphane] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Kutuphane] SET QUERY_STORE = OFF
GO
USE [Kutuphane]
GO
/****** Object:  Table [dbo].[islem]    Script Date: 10.03.2024 11:35:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[islem](
	[islemno] [int] IDENTITY(1,1) NOT NULL,
	[ogrno] [int] NULL,
	[kitapno] [int] NULL,
	[atarih] [date] NULL,
	[vtarih] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[islemno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kitap]    Script Date: 10.03.2024 11:35:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kitap](
	[kitapno] [int] IDENTITY(1,1) NOT NULL,
	[isbnno] [int] NULL,
	[kitapadi] [nvarchar](50) NULL,
	[yazarno] [int] NULL,
	[turno] [int] NULL,
	[sayfasayisi] [int] NULL,
	[puan] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[kitapno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ogrenci]    Script Date: 10.03.2024 11:35:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ogrenci](
	[ogrno] [int] IDENTITY(1,1) NOT NULL,
	[ograd] [nvarchar](50) NULL,
	[ogrsoyad] [nvarchar](50) NULL,
	[cinsiyet] [nvarchar](10) NULL,
	[dtarih] [date] NULL,
	[sinif] [nvarchar](10) NULL,
	[puan] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ogrno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tur]    Script Date: 10.03.2024 11:35:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tur](
	[turno] [int] IDENTITY(1,1) NOT NULL,
	[turadi] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[turno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Yazar]    Script Date: 10.03.2024 11:35:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Yazar](
	[yazarno] [int] IDENTITY(1,1) NOT NULL,
	[yazarad] [nvarchar](50) NULL,
	[yazarsoyad] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[yazarno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[islem] ON 

INSERT [dbo].[islem] ([islemno], [ogrno], [kitapno], [atarih], [vtarih]) VALUES (1, 1, 1, CAST(N'2023-05-05' AS Date), CAST(N'2023-09-05' AS Date))
INSERT [dbo].[islem] ([islemno], [ogrno], [kitapno], [atarih], [vtarih]) VALUES (2, 2, 2, CAST(N'2023-03-07' AS Date), CAST(N'2023-10-08' AS Date))
SET IDENTITY_INSERT [dbo].[islem] OFF
GO
SET IDENTITY_INSERT [dbo].[Kitap] ON 

INSERT [dbo].[Kitap] ([kitapno], [isbnno], [kitapadi], [yazarno], [turno], [sayfasayisi], [puan]) VALUES (1, 5, N'Araba sevdası', 2, 1, 500, 100)
INSERT [dbo].[Kitap] ([kitapno], [isbnno], [kitapadi], [yazarno], [turno], [sayfasayisi], [puan]) VALUES (2, 6, N'Abasıyanık', 1, 2, 350, 95)
SET IDENTITY_INSERT [dbo].[Kitap] OFF
GO
SET IDENTITY_INSERT [dbo].[Ogrenci] ON 

INSERT [dbo].[Ogrenci] ([ogrno], [ograd], [ogrsoyad], [cinsiyet], [dtarih], [sinif], [puan]) VALUES (1, N'Ahmet', N'Genç', N'Erkek', CAST(N'1995-10-01' AS Date), N'2c', 100)
INSERT [dbo].[Ogrenci] ([ogrno], [ograd], [ogrsoyad], [cinsiyet], [dtarih], [sinif], [puan]) VALUES (2, N'Orhan', N'Yeni', N'Erkek', CAST(N'2006-12-07' AS Date), N'1a', 110)
INSERT [dbo].[Ogrenci] ([ogrno], [ograd], [ogrsoyad], [cinsiyet], [dtarih], [sinif], [puan]) VALUES (3, N'Selami', N'Kurt', N'Kadın', CAST(N'1999-08-10' AS Date), N'3b', 96)
SET IDENTITY_INSERT [dbo].[Ogrenci] OFF
GO
SET IDENTITY_INSERT [dbo].[Tur] ON 

INSERT [dbo].[Tur] ([turno], [turadi]) VALUES (1, N'Komedi')
INSERT [dbo].[Tur] ([turno], [turadi]) VALUES (2, N'Korku')
INSERT [dbo].[Tur] ([turno], [turadi]) VALUES (3, N'Drama')
SET IDENTITY_INSERT [dbo].[Tur] OFF
GO
SET IDENTITY_INSERT [dbo].[Yazar] ON 

INSERT [dbo].[Yazar] ([yazarno], [yazarad], [yazarsoyad]) VALUES (1, N'Sait Faik', N'Abasıyanık')
INSERT [dbo].[Yazar] ([yazarno], [yazarad], [yazarsoyad]) VALUES (2, N'Recaizade Mahmut', N'Ekrem')
SET IDENTITY_INSERT [dbo].[Yazar] OFF
GO
ALTER TABLE [dbo].[islem]  WITH CHECK ADD FOREIGN KEY([kitapno])
REFERENCES [dbo].[Kitap] ([kitapno])
GO
ALTER TABLE [dbo].[islem]  WITH CHECK ADD FOREIGN KEY([ogrno])
REFERENCES [dbo].[Ogrenci] ([ogrno])
GO
ALTER TABLE [dbo].[Kitap]  WITH CHECK ADD FOREIGN KEY([turno])
REFERENCES [dbo].[Tur] ([turno])
GO
ALTER TABLE [dbo].[Kitap]  WITH CHECK ADD FOREIGN KEY([yazarno])
REFERENCES [dbo].[Yazar] ([yazarno])
GO
USE [master]
GO
ALTER DATABASE [Kutuphane] SET  READ_WRITE 
GO

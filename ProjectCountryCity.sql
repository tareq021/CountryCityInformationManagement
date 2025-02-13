USE [master]
GO
/****** Object:  Database [CountryCityDB]    Script Date: 11-Apr-16 5:29:56 AM ******/
CREATE DATABASE [CountryCityDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CountryCityDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\CountryCityDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CountryCityDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\CountryCityDB_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CountryCityDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CountryCityDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CountryCityDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CountryCityDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CountryCityDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CountryCityDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CountryCityDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CountryCityDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CountryCityDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CountryCityDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CountryCityDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CountryCityDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CountryCityDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CountryCityDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CountryCityDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CountryCityDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CountryCityDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CountryCityDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CountryCityDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CountryCityDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CountryCityDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CountryCityDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CountryCityDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CountryCityDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CountryCityDB] SET  MULTI_USER 
GO
ALTER DATABASE [CountryCityDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CountryCityDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CountryCityDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CountryCityDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [CountryCityDB]
GO
/****** Object:  Table [dbo].[City]    Script Date: 11-Apr-16 5:29:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[City](
	[CityName] [varchar](max) NOT NULL,
	[CityAbout] [varchar](max) NULL,
	[CityDweller] [int] NULL,
	[CityLocation] [varchar](max) NULL,
	[CityWeather] [varchar](max) NULL,
	[CityCountry] [varchar](max) NOT NULL,
	[CityId] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Country]    Script Date: 11-Apr-16 5:29:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Country](
	[CountryName] [varchar](100) NOT NULL,
	[CountryAbout] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[viewCities]    Script Date: 11-Apr-16 5:29:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[viewCities]
as
select cy.CityName as CityName, cy.CityAbout as CityAbout,
cy.[CityDweller] as CityDwellers, cy.CityLocation as CityLocation, 
cy.CityWeather as CityWeather, cn.CountryName, cn.CountryAbout
from City cy inner join Country cn on cy.CityCountry=cn.CountryName;
GO
/****** Object:  View [dbo].[viewCountries]    Script Date: 11-Apr-16 5:29:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from Country
--select count(City.CityName) from City where City.CityCountry='Italy';


CREATE view [dbo].[viewCountries]
as
select cn.CountryName as Name, cn.CountryAbout as About,count(cy.CityName) as [No. of cities],sum(ISNULL(cy.CityDweller,0)) as [NoOfCityDwellers]  
 from Country cn left outer join City cy
  on cn.CountryName= cy.CityCountry  
   group by cn.CountryName, cn.CountryAbout ;

  
  
  
  -- select * from viewCountries ;



GO
USE [master]
GO
ALTER DATABASE [CountryCityDB] SET  READ_WRITE 
GO

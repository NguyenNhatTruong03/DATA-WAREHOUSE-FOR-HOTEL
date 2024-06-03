/****** Object:  Database UNKNOWN    Script Date: 23/5/2024 12:09:32 AM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/

DROP DATABASE Resort_Hotel_DW
GO
CREATE DATABASE Resort_Hotel_DW
GO
ALTER DATABASE Resort_Hotel_DW
SET RECOVERY SIMPLE
GO

USE Resort_Hotel_DW
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;





-- Create a schema to hold user views (set schema name on home page of workbook).
-- It would be good to do this only if the schema doesn't exist already.
GO
CREATE SCHEMA MDWT
GO






/* Drop table dbo.DimDate */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimDate 
;

/* Create table dbo.DimDate */
CREATE TABLE dbo.DimDate (
   [Datekey]  int   NOT NULL
,  [arrival_date_year]  varchar(50)  DEFAULT '9999' NOT NULL
,  [arrival_date_month]  varchar(50)  DEFAULT '0' NOT NULL
,  [arrival_date_week_number]  varchar(50)  DEFAULT '53' NOT NULL
,  [arrival_date_day_of_month]  varchar(50)  DEFAULT '0' NOT NULL
, CONSTRAINT [PK_dbo.DimDate] PRIMARY KEY CLUSTERED 
( [Datekey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimDate
;

INSERT INTO dbo.DimDate (Datekey, arrival_date_year, arrival_date_month, arrival_date_week_number, arrival_date_day_of_month)
VALUES (-1, '9999', '0', '53', '0')
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[Date]'))
DROP VIEW [MDWT].[Date]
GO
CREATE VIEW [MDWT].[Date] AS 
SELECT [Datekey] AS [Datekey]
, [arrival_date_year] AS [arrival_date_year]
, [arrival_date_month] AS [arrival_date_month]
, [arrival_date_week_number] AS [arrival_date_week_number]
, [arrival_date_day_of_month] AS [arrival_date_day_of_month]
FROM dbo.DimDate
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Datekey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Datekey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'arrival_date_year', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'arrival_date_year'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'arrival_date_month', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'arrival_date_month'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'arrival_date_week_number', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'arrival_date_week_number'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'arrival_date_day_of_month', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'arrival_date_day_of_month'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Datekey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always describe your columns', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'arrival_date_year'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always describe your columns', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'arrival_date_month'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always describe your columns', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'arrival_date_week_number'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Datekey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Datekey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'arrival_date_year'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'arrival_date_month'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'arrival_date_week_number'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'arrival_date_day_of_month'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Datekey'; 
;





/* Drop table dbo.DimCustomers */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimCustomers') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimCustomers 
;

/* Create table dbo.DimCustomers */
CREATE TABLE dbo.DimCustomers (
   [CustomerKey]  int   NOT NULL
,  [Country]  varchar(20)  DEFAULT 'NULL' NOT NULL
,  [CustomerType]  varchar(50)  DEFAULT 'NULL' NOT NULL
,  [is_repeated_guest]  int  DEFAULT 0 NOT NULL
,  [previous_cancellations]  int  DEFAULT 0 NOT NULL
,  [previous_bookings_not_canceled]  int  DEFAULT 0 NOT NULL
, CONSTRAINT [PK_dbo.DimCustomers] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimCustomers
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Customers', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimCustomers
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimCustomers
;

INSERT INTO dbo.DimCustomers (CustomerKey, Country, CustomerType, is_repeated_guest, previous_cancellations, previous_bookings_not_canceled)
VALUES (-1, '', '', -1, -1, -1)
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[Customers]'))
DROP VIEW [MDWT].[Customers]
GO
CREATE VIEW [MDWT].[Customers] AS 
SELECT [CustomerKey] AS [CustomerKey]
, [Country] AS [Country]
, [CustomerType] AS [CustomerType]
, [is_repeated_guest] AS [is_repeated_guest]
, [previous_cancellations] AS [previous_cancellations]
, [previous_bookings_not_canceled] AS [previous_bookings_not_canceled]
FROM dbo.DimCustomers
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Country', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerType', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerType'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'is_repeated_guest', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'is_repeated_guest'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'previous_cancellations', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'previous_cancellations'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'previous_bookings_not_canceled', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'previous_bookings_not_canceled'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business key from source system (aka natural key)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always describe your columns', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerType'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always describe your columns', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'is_repeated_guest'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always describe your columns', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'previous_cancellations'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerType'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'is_repeated_guest'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'previous_cancellations'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'previous_bookings_not_canceled'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
;





/* Drop table dbo.DimHotel */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimHotel') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimHotel 
;

/* Create table dbo.DimHotel */
CREATE TABLE dbo.DimHotel (
   [HotelKey]  int   NOT NULL
,  [HotelName]  varchar(50)   NOT NULL
, CONSTRAINT [PK_dbo.DimHotel] PRIMARY KEY CLUSTERED 
( [HotelKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimHotel
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimHotel
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimHotel
;

INSERT INTO dbo.DimHotel (HotelKey, HotelName)
VALUES (-1, '')
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[Hotel]'))
DROP VIEW [MDWT].[Hotel]
GO
CREATE VIEW [MDWT].[Hotel] AS 
SELECT [HotelKey] AS [HotelKey]
, [HotelName] AS [HotelName]
FROM dbo.DimHotel
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'HotelKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimHotel', @level2type=N'COLUMN', @level2name=N'HotelKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'HotelName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimHotel', @level2type=N'COLUMN', @level2name=N'HotelName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimHotel', @level2type=N'COLUMN', @level2name=N'HotelKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business key from source system (aka natural key)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimHotel', @level2type=N'COLUMN', @level2name=N'HotelName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimHotel', @level2type=N'COLUMN', @level2name=N'HotelKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimHotel', @level2type=N'COLUMN', @level2name=N'HotelKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimHotel', @level2type=N'COLUMN', @level2name=N'HotelName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimHotel', @level2type=N'COLUMN', @level2name=N'HotelKey'; 
;





/* Drop table dbo.FactCanceled */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.FactCanceled') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.FactCanceled 
;

/* Create table dbo.FactCanceled */
CREATE TABLE dbo.FactCanceled (
   [HotelKey]  int   NOT NULL
,  [DateKey]  int   NOT NULL
,  [CustomerKey]  int   NOT NULL
,  [ADR]  float   NULL
, CONSTRAINT [PK_dbo.FactCanceled] PRIMARY KEY NONCLUSTERED 
( [DateKey], [CustomerKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactCanceled
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Canceled', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactCanceled
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactCanceled
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[Canceled]'))
DROP VIEW [MDWT].[Canceled]
GO
CREATE VIEW [MDWT].[Canceled] AS 
SELECT [HotelKey] AS [HotelKey]
, [DateKey] AS [DateKey]
, [CustomerKey] AS [CustomerKey]
, [ADR] AS [ADR]
FROM dbo.FactCanceled
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'HotelKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'HotelKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ADR', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'ADR'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to dimHotel', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'HotelKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to dimDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to dimCustomer', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always add a description!', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'ADR'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'HotelKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1,2,3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'9,5', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'ADR'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'HotelKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Amount', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'ADR'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'HotelKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactCanceled', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
;





/* Drop table dbo.FactBooking */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.FactBooking') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.FactBooking 
;

/* Create table dbo.FactBooking */
CREATE TABLE dbo.FactBooking (
   [HotelKey]  int   NOT NULL
,  [DateKey]  int   NOT NULL
,  [CustomerKey]  int   NOT NULL
,  [meal]  nvarchar(255)   NULL
,  [market_segment]  nvarchar(255)   NOT NULL
,  [agent]  nvarchar(255)   NULL
,  [reserved_room_type]  nvarchar(255)   NOT NULL
,  [deposit_type]  nvarchar(255)   NOT NULL
,  [required_car_parking_spaces]  int   NULL
,  [total_of_special_requests]  int   NULL
, CONSTRAINT [PK_dbo.FactBooking] PRIMARY KEY NONCLUSTERED 
( [DateKey], [CustomerKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactBooking
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Booking', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactBooking
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactBooking
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[Booking]'))
DROP VIEW [MDWT].[Booking]
GO
CREATE VIEW [MDWT].[Booking] AS 
SELECT [HotelKey] AS [HotelKey]
, [DateKey] AS [DateKey]
, [CustomerKey] AS [CustomerKey]
, [meal] AS [meal]
, [market_segment] AS [market_segment]
, [agent] AS [agent]
, [reserved_room_type] AS [reserved_room_type]
, [deposit_type] AS [deposit_type]
, [required_car_parking_spaces] AS [required_car_parking_spaces]
, [total_of_special_requests] AS [total_of_special_requests]
FROM dbo.FactBooking
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'HotelKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'HotelKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'meal', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'meal'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'market_segment', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'market_segment'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'agent', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'agent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'reserved_room_type', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'reserved_room_type'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'deposit_type', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'deposit_type'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'required_car_parking_spaces', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'required_car_parking_spaces'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'total_of_special_requests', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'total_of_special_requests'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimHotel', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'HotelKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimCustomers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'HotelKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1,2,3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'HotelKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'meal'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'market_segment'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'agent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'reserved_room_type'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'deposit_type'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Amount', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'required_car_parking_spaces'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Amount', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'total_of_special_requests'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'HotelKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactBooking', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
;
ALTER TABLE dbo.FactCanceled ADD CONSTRAINT
   FK_dbo_FactCanceled_HotelKey FOREIGN KEY
   (
   HotelKey
   ) REFERENCES DimHotel
   ( HotelKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactCanceled ADD CONSTRAINT
   FK_dbo_FactCanceled_DateKey FOREIGN KEY
   (
   DateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactCanceled ADD CONSTRAINT
   FK_dbo_FactCanceled_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES DimCustomers
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactBooking ADD CONSTRAINT
   FK_dbo_FactBooking_HotelKey FOREIGN KEY
   (
   HotelKey
   ) REFERENCES DimHotel
   ( HotelKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactBooking ADD CONSTRAINT
   FK_dbo_FactBooking_DateKey FOREIGN KEY
   (
   DateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactBooking ADD CONSTRAINT
   FK_dbo_FactBooking_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES DimCustomers
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 

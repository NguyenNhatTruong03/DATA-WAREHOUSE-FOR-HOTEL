create database Resort_Hotel_Stage

use Resort_Hotel_Stage

CREATE TABLE StageDate (
   Datekey  int
,  arrival_date_year  varchar(50)
,  arrival_date_month  varchar(50)
,  arrival_date_week_number  varchar(50)
,  arrival_date_day_of_month  varchar(50)
);

CREATE TABLE StageCustomers (
   CustomerKey  int
,  Country  varchar(20)
,  CustomerType  varchar(50)
,  is_repeated_guest  int
,  previous_cancellations  int
,  previous_bookings_not_canceled  int
);

CREATE TABLE StageHotel (
   HotelKey  int
,  HotelName  varchar(50)
);

CREATE TABLE StageCanceled (
   HotelKey  int
,  DateKey  int
,  CustomerKey  int
,  ADR  float
);

CREATE TABLE StageBooking (
   HotelKey  int
,  DateKey  int
,  CustomerKey  int
,  meal nvarchar(255)
,  market_segment  nvarchar(255)
,  agent  nvarchar(255)
,  reserved_room_type nvarchar(255)
,  deposit_type  nvarchar(255)
,  required_car_parking_spaces int
,  total_of_special_requests  int
);
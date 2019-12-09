-- use master;
-- go

-- DROP DATABASE PizzaBox;

-- -- create
-- create database PizzaBox;
-- go
USE master;
GO

DROP DATABASE PizzaBox;

create database PizzaBox;
go

USE Pizzabox;
GO

create schema [Order];
go

create schema Account;
go

create table [Order].[Order]
(
    OrderId int not null identity(1,2) --primary key
    ,UserId int not null --foreign key references Account.User.UserId
    ,StoreId int not null --foreign key
    ,TotalCost numeric(5,2) not null
    ,OrderDate datetime2(7) not null --checked
    -- ,Active bit not null --default
    --,constraint PK_Order_OrderId primary key (OrderId)
    --,constraint FK_Order_UserId foreign key (UserId) references Account.User(UserId)
);

create table [Order].[OrderPizza]
(
    OrderPizzaId int not null identity(1,2)
    ,OrderId int not null
    ,PizzaId int not null
)

create table [Order].[Pizza]
(
    PizzaId int not null identity(1,2)
    ,SizeId int not null --foreign
    ,CrustId int not null --foreign
    ,Price numeric(4,2) not null
    -- ,Active bit not null
)

-- alter
alter table [Order].[Order]
    add constraint PK_Order_OrderId primary key (OrderId);

alter table [Order].[OrderPizza]
    add constraint PK_OrderPizza_OrderPizzaId primary key (OrderPizzaId);

alter table [Order].[Pizza]
    add constraint PK_Pizza_PizzaId primary key (PizzaId);

alter table [Order].[OrderPizza]
    add constraint FK_OrderPizza_OrderId foreign key (OrderId) references [Order].[Order](OrderId);

alter table [Order].[OrderPizza]
    add constraint FK_OrderPizza_PizzaId foreign key (PizzaId) references [Order].[Pizza](PizzaId);

-- alter table [Order].[Order]
--     add constraint DF_Order_Active default (1) for Active;

-- alter table [Order].[Pizza]
--     add constraint DF_Pizza_Active default (1) for Active;

alter table [Order].[Order]
    add constraint CK_Order_OrderDate check (OrderDate > '2019-11-11');

alter table [Order].[Order]
    drop constraint CK_Order_OrderDate;

alter table [Order].[Order]
    add TipAmount numeric(2,2) null;

alter table [Order].[Order]
    drop column TipAmount;

-- drop
drop table [Order].[OrderPizza];

-- truncate
truncate table [Order].[OrderPizza];

ALTER TABLE [Order].Pizza
    DROP COLUMN Active;
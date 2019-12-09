USE master;
GO


-- create
CREATE DATABASE PizzaBox;
-- clone the model database:
-- 3 files
-- .mdf (master data file) - first file that the database create to hold the database stuff.  Govern the database.
-- .ldf (log data file) - keep tracks of the changes that were made to the database
-- .ndf (none master data file) - replicate the data file, while keep the file small.  Contain the actual data of the database.
-- max space of 64 bit
--
GO

USE PizzaBox;
GO



-- Schema are namespaces in C#
--      collation, latin general (ci as), etc
--         support UTF-8 include Mandarin, Korean, etc.
--      Symbolic languages -- Cyrillic, Hebrew collation

-- CREATE SCHEMA Orders;
CREATE SCHEMA [Order];
GO

CREATE SCHEMA Accounts;
GO

-- 4-date formats - DATE, TIME, DATETIME (3 digits after the second), DATETIME2 (7 digits after the second)
-- datetime2 precision in nanosecond
-- numbers - Decimal(3,2) --> 999.99, Numeric(3,2) --> 9.99
-- ACTIVEFLY to determine inactive or active but use bit

-- CREATE TABLE Orders.Order
CREATE TABLE [Order].[Order]
(
    -- Method 1
    -- OrderID INT UNIQUE IDENTITY(1, 2) NOT NULL PRIMARY KEY,         -- can't change the primary key or data
    -- UserID INT NOT NULL REFERENCES Account.User.UserID,                -- 2NF user and order
    -- Method 2
    OrderID INT UNIQUE IDENTITY(1, 2) NOT NULL,                         -- 1NF every record is unique with an ID, -- tiny 8 bit, small 16, int 32, big 64
    UserID INT NOT NULL,                                                -- 2NF user and order
    StoreID INT NOT NULL,
    OrderDateTime DATETIME2(7) NOT NULL,                                -- datetime is to the milliseconds, 0 is second, 7 is 7 digits after the second
    TotalCost DECIMAL(3, 2) NOT NULL,                                   -- identity auto increment, a type of sequence in T-SQL, others are called auto increment
    Active bit not null,                                                 --
    CONSTRAINT PK_OrderId PRIMARY KEY (OrderId),                        -- Doesn't need indexing
    CONSTRAINT FK_UserId FOREIGN KEY (UserId) REFERENCES Account.User(UserId)
);

CREATE TABLE [Order].[OrderPizza]
-- CREATE TABLE Orders.OrderPizza
(
  OrderPizzaId int not null identity(1, 2),
  OrderId int not null,
  PizzaId int not null
)

CREATE TABLE [Order].[Pizza]
-- CREATE TABLE Orders.Pizza
(
    PizzaId int not null IDENTITY(1, 2),
    Price DECIMAL(2, 2) not null,
    SizeId int not null,
    CrustId int not null
)

-- ALTER TABLE Orders.Order
ALTER TABLE [Order].[Order]
    ADD CONSTRAINT PK_Order_OrderId PRIMARY KEY (OrderId)

ALTER TABLE [Order].[OrderPizza]
    ADD CONSTRAINT PK_OrderPizza_OrderPizzaId PRIMARY KEY (OrderPizzaId)

ALTER TABLE [Order].[Order]
    ADD CONSTRAINT PK_Pizza_PizzaId PRIMARY KEY (PizzaId)

ALTER TABLE Orders.[OrderPizza]
    ADD CONSTRAINT FK_OrderPizza_OrderId FOREIGN KEY (OrderId) REFERENCES [Order].[Order](OrderId);

ALTER TABLE [Order].[OrderPizza]
    ADD CONSTRAINT FK_OrderPizza_PizzaId FOREIGN KEY (PizzaId) REFERENCES [Order].[Pizza](PizzaId);

ALTER TABLE [Order].[Order]
    ADD CONSTRAINT DF_Order_Active DEFAULT(1) for Active; -- 1 bit

ALTER TABLE [Order].[Order]
    ADD CONSTRAINT CK_Order_Total CHECK (TotalCost < 500);

ALTER TABLE [Order].[Order]
    ADD CONSTRAINT CK_Order_OrderDate CHECK (OrderDate >= '2019-11-11');
    -- ADD CONSTRAINT CK_Order_OrderDate CHECK (OrderDate >= year('2019-11-11'));

ALTER TABLE [Order].[Order]
    DROP CONSTRAINT CK_Order_OrderDate;

ALTER TABLE [Order].[Order]
    ADD TipAmount Decimal(2,2) NULL;

ALTER TABLE [Order].[Order]
    DROP COLUMN TipAmount;

-- drop
-- can the database for everything, if not drop the proxy first, then the other.

DROP TABLE [Order].OrderPizza;
DROP TABLE [Order].[Pizza];
DROP TABLE [Order].[Order];

-- truncate
TRUNCATE TABLE [Order].[OrderPizza];





-- session increment while the session is run, but reset after complete
-- crosssection - a seed, and a step
-- even number are for hackers?
--
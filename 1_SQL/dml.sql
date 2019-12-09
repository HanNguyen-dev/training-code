USE AdventureWorks2017;
GO      -- run by itself (the transaction) (the GO is the block scope)

-- select clause, select is Console.Write(), mean it just prints.  It just prints.
-- select for horizontal
SELECT 1 + 1;
SELECT * FROM Person.Person;

SELECT firstname, lastname, middlename
FROM Person.Person;

SELECT firstname, lastname, middlename
FROM Person.Person
WHERE FirstName = 'robert';

SELECT firstname, lastname, middlename
FROM Person.Person
WHERE FirstName <> 'robert' AND FirstName <> 'john'; -- everyone except roberts and johns

SELECT firstname, lastname, middlename
FROM Person.Person
WHERE FirstName LIKE '%robert%';  -- % mean 0 or many characters, in this case before and after robert

SELECT firstname, lastname, middlename
FROM Person.Person
WHERE FirstName LIKE '%r%e' OR FirstName LIKE 'robert_';    -- _ mean exacting one character, in this case, one character from robert

SELECT firstname, lastname, middlename
FROM Person.Person
WHERE FirstName LIKE 'r[aeiou]%';

SELECT count(*) AS Amount, firstname, lastname -- singular for Alias
FROM Person.Person
WHERE FirstName = 'robert' OR FirstName = 'john'
GROUP BY FirstName, LastName;

SELECT count(*) AS [Numer Of], firstname, lastname -- or " "
FROM Person.Person
WHERE FirstName = 'robert' OR FirstName = 'john'
GROUP BY FirstName, LastName;

SELECT count(*) AS "Amount of", firstname, lastname
FROM Person.Person
WHERE FirstName = 'robert' OR FirstName = 'john' AND count(*) > 1
GROUP BY FirstName, LastName;

SELECT count(*) AS [Numer Of], firstname, lastname -- or " "
FROM Person.Person
WHERE FirstName LIKE 'robert%' OR FirstName = 'john'
GROUP BY FirstName, LastName
HAVING Count(*) > 1;

-- where is to from, having is to group
-- query run from the last time when a query is run.

SELECT count(*) AS [Numer Of], firstname, lastname -- or " "
FROM Person.Person
WHERE FirstName = 'robert' OR FirstName = 'john'
GROUP BY FirstName, LastName
HAVING Count(*) > 1
ORDER BY FirstName asc, LastName asc;

SELECT count(FirstName) AS [Numer Of], firstname, lastname -- or " "
FROM Person.Person
WHERE FirstName = 'robert' OR FirstName = 'john'
GROUP BY FirstName, LastName
HAVING Count(*) > 1
ORDER BY FirstName asc, LastName asc;

--mode of execution

/*
 FROM
 WHERE
 GROUP BY
 HAVING
 SELECT
 ORDER BY
 */

 -- INSERT about

SELECT * FROM Person.Address;

INSERT into Person.Address
VALUES ('UT', NULL, 'Arlington', 79, 76010, 0xE6100000010CAE8BFC28BCE4474067A89189898A5EC9, 9aadcb0d-36cf-483f-84d8-585c2d4ec6e9aa, '2019-11-08');

INSERT into Person.Address(AddressLine1, AddressLine2, City, StateProvinceID, PostalCode, SpatialLocation, rowguid, ModifiedDate)
VALUES ('UT', 'American Dream City', 'Arlington', 79, 76010, 0xE6100000010CAE8BFC28BCE4474067A89189898A5EC7, '9aadcb0d-36cf-483f-84d8-585c2d4ec6aa', '2019-11-08');

INSERT INTO Person.Address(AddressLine2, AddressLine1, City, StateProvinceID, PostalCode, SpatialLocation, rowguid, ModifiedDate)
SELECT *
FROM AdventureWorks2017.Person.Address
where AddressLine1 = 'UT';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS;
-- WHERE TABLE_NAME = Person;

INSERT INTO Person.Address(AddressLine1, AddressLine2, City, StateProvinceID, PostalCode, SpatialLocation, rowguid, ModifiedDate)
VALUES ('UT', 'American Dream City', 'Arlington', 79, 98011, 0xE6100000010CAE8BFC28BCE4474067A89189898A5EC0, '9aadcb0d-36cf-483f-84d8-585c2d4ec6e3', '2007-12-04')

SELECT *
FROM Person.Address
WHERE AddressLine1 = 'UT';


BULK INSERT Person.Address FROM 'data.csv' WITH (rowterminator = '\n', fieldterminator = ',');

-- update
-- write a select statement first before writing an UPDATE statement

SELECT FirstName
FROM Person.Person
WHERE FirstName = 'robert';

UPDATE Person.Person
SET FirstName = 'john'
WHERE FirstName = 'robert';

UPDATE pp
SET FirstName = 'robert'
FROM Person.Person AS pp
WHERE pp.LastName = 'jones';

-- RPA (resume proceduring event)

SELECT *
FROM Person.Person AS pp
WHERE pp.LastName = 'jones';

-- two meaning of null. 1) the value of null.  2) no information is given.  NULL is not NULL (two different value used with IS instead of =)

-- delete

-- SELECT *
-- FROM Person.Person AS PP
-- WHERE PP.MiddleName = 'NULL';


DELETE 
FROM Person.Person
WHERE MiddleName IS NULL AND FirstName = 'Xavier';


-- INNER and LEFT are similar, INNER Jimmy has to have an address, LEFT Jimmy doesn't have to an address
SELECT pp.FirstName, pp.LastName, pa.AddressLine1, pa.City, pa.postalcode
FROM Person.Person AS pp
INNER JOIN Person.BusinessEntityAddress as pbea 
ON pbea.BusinessEntityID = pp.BusinessEntityID
INNER JOIN Person.Address AS pa ON pa.addressID = pbea.AddressID
WHERE pp.FirstName = 'jimmy';
-- INNER and LEFT (everything that is in address will be in BusinessEntityAddress) thus they are the same
-- start with the table with the less amount of information
-- also try INNER and LEFT to almost everything
-- Do not mixed LEFT and RIGHT join

-- RedGate is a DB mapper software

-- looking for products that Jimmy brought
-- person.person, sales.customer, sales.SalesOrderheader, sales.order, 

SELECT pp.FirstName, pp.LastName, ppt.Name, ssoh.OrderDate --, pa.AddressLine1, pa.City, pa.postalcode
FROM Person.Person AS pp
INNER JOIN Person.BusinessEntityAddress as pbea ON pbea.BusinessEntityID = pp.BusinessEntityID
INNER JOIN Person.Address AS pa ON pa.addressID = pbea.AddressID
INNER JOIN Sales.Customer AS sc ON sc.CustomerID = pp.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader AS ssoh ON ssoh.CustomerID = sc.CustomerID
INNER JOIN Sales.SalesOrderDetail AS ssod ON ssod.SalesOrderID = ssoh.SalesOrderID
INNER JOIN Production.Product AS ppt ON ppt.ProductID = ssod.ProductID
WHERE pp.FirstName = 'jimmy' AND DATEPART(MONTH, ssoh.OrderDate) = 7
AND ppt.Name LIKE '%tire%'; -- or MONTH(ssoh.OrderData) = 7, T-SQL is zero base
-- year month day
-- T-SQL and general SQL is 1 base.
-- CTE aka subquery, to reduce the amount of JOIN (data)during the multijoin process. (Common Table Expression)


SELECT pp.FirstName, pp.LastName, ppt.Name, ssoh.OrderDate --, pa.AddressLine1, pa.City, pa.postalcode
FROM Person.Person AS pp
INNER JOIN Person.BusinessEntityAddress as pbea ON pbea.BusinessEntityID = pp.BusinessEntityID
INNER JOIN Person.Address AS pa ON pa.addressID = pbea.AddressID
INNER JOIN Sales.Customer AS sc ON sc.CustomerID = pp.BusinessEntityID
INNER JOIN 
(
    SELECT salesorderid, customerid, OrderDate
    FROM Sales.SalesOrderHeader
    WHERE DATEPART(MONTH, OrderDate) = 7
) AS ssoh ON ssoh.CustomerID = sc.CustomerID
INNER JOIN Sales.SalesOrderDetail AS ssod ON ssod.SalesOrderID = ssoh.SalesOrderID
INNER JOIN
(
    SELECT productid, name
    FROM Production.Product
    WHERE Name like '%tire%'
) AS ppt ON ppt.ProductID = ssod.ProductID
WHERE pp.FirstName = 'jimmy'; -- or MONTH(ssoh.OrderData) = 7, T-SQL is zero base
-- year month day
-- T-SQL and general SQL is 1 base.
-- CTE aka subquery, to reduce the amount of JOIN (data)during the multijoin process. (Common Table Expression)


-- The following is an example of CTE

WITH OrderHeader AS 
(
    SELECT salesorderid, customerid
    FROM Sales.SalesOrderHeader
    WHERE DATEPART(month, OrderDate) = 7
),
Product AS
(
    SELECT productid, name
    FROM Production.Product
    WHERE Name like '%tire%'
)
SELECT pp.FirstName, pp.LastName, ppt.Name
FROM Person.Person AS pp
INNER JOIN Person.BusinessEntityAddress as pbea ON pbea.BusinessEntityID = pp.BusinessEntityID
INNER JOIN Person.Address AS pa ON pa.addressID = pbea.AddressID
INNER JOIN Sales.Customer AS sc ON sc.CustomerID = pp.BusinessEntityID
INNER JOIN OrderHeader AS ssoh ON ssoh.CustomerID = sc.CustomerID
INNER JOIN Sales.SalesOrderDetail AS ssod ON ssod.SalesOrderID = ssoh.SalesOrderID
INNER JOIN Product AS ppt ON ppt.ProductID = ssod.ProductID
WHERE pp.FirstName = 'jimmy'; -- or MONTH(ssoh.OrderData) = 7, T-SQL is zero base

SELECT distinct pp.firstname, pp.lastname, pp1.firstname, pp1.lastname
FROM Person.Person AS pp
INNER JOIN Person.Person AS pp1
ON pp.firstname = pp1.LastName; -- join can also works on data type

-- use a union for this self join

SELECT pp.firstname, pp.LastName
FROM Person.Person AS pp
INTERSECT
SELECT pp1.lastname, pp1.FirstName
FROM Person.Person AS pp1;
-- ON pp.firstname = pp1.LastName; -- join can also works on data type
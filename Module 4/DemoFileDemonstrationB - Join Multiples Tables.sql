-- Demonstration B

-- Step 1: Open a new query window to the TSQL database

USE TSQL;
GO

-- Step 2: Join 2 tables
/*
	Select and execute the following query
	to demonstrate a two-table inner join.
	Point out that there are 77 rows output.
*/

SELECT C.categoryid,
	C.categoryname,
	P.productid,
	P.productname
FROM Production.Categories AS C
JOIN Production.Products AS P
	ON (C.categoryid = P.categoryid);
GO

-- Step 3: Join 2 tables
/*
	Select and execute the following query
	to demonstrate a two-table inner composite join.
	Point out that there are 27 rows output without a distinct filter.
*/

SELECT E.city,
	E.country
FROM Sales.Customers AS C
JOIN HR.Employees AS E
	ON (C.city = E.city AND C.country = E.country);
GO

-- Step 4: Join 2 tables
/*
	Select and execute the following query
	to demonstrate a two-table inner composite join.
	Point out that there are 3 rows output with a distinct filter.
*/

SELECT DISTINCT E.city,
	E.country
FROM Sales.Customers AS C
JOIN HR.Employees AS E
	ON (C.city = E.city AND C.country = E.country);
GO

-- Step 5: Join multiples tables
/*
	Select and execute the following query
	to demonstrate a two-table inner join.
	Point out that the elements needed to add and display data
	from a third table have been commented out to join
	the first two tables only 830 rows will be returned.
*/

SELECT C.custid,
	C.companyname,
	O.orderid,
	O.orderdate --, OD.productid, OD.qty
FROM Sales.Customers AS C
JOIN Sales.Orders AS O
	ON (C.custid = O.custid);
--JOIN Sales.OrderDetails AS OD
--	ON (O.orderid = OD.orderid)
GO

-- Step 6: Join 3 tables
/*
	Select and execute the following query
	to demonstrate a three-table inner join.
	2155 rows will be returned. Why?
*/

SELECT *
FROM Sales.Customers AS C
JOIN Sales.Orders AS O
	ON (C.custid = O.custid)
JOIN Sales.OrderDetails AS OD
	ON (O.orderid = OD.orderid);
GO

-- R: Because the Sales.OrderDetails table has an orderid that contains one or more products.
-- That's why the number of rows returned grow up.
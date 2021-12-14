-- Demonstration A

-- Step 1: Open a new query window to the TSQL database.

USE TSQL;
GO

-- Step 2: Select and execute the following queries to illustrate scalar functions.

SELECT orderid, YEAR(orderdate) AS orderyear
FROM Sales.Orders;
GO

SELECT ABS(-1.0), ABS(0.0), ABS(1.0);
GO

SELECT CAST(SYSDATETIME() AS DATE) AS [current_date];
GO

SELECT DB_NAME() AS [current_database];
GO

/*
-- Step 3: Select and execute the following query to illustrate a simple Aggregate function demo without
	GROUP BY (GROUP BY will be covered in a later module).
*/

SELECT COUNT(*) AS numorders, SUM(unitprice) AS totalsales
FROM Sales.OrderDetails;
GO

-- Step 4: Select and execute the following query to illustrate a simple ranking function.

SELECT TOP (5) productid, productname, unitprice,
	RANK() OVER(ORDER BY unitprice DESC) AS rankbyprice
FROM Production.Products
ORDER BY rankbyprice;
GO
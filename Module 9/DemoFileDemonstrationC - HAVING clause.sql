-- Demonstration C

-- Step 1: Change to AdventureWorks2016 database.

USE AdventureWorks2016;
GO

-- Step 2a: Using the HAVING clause.
/*
	Select and execute the following query to show the use of a HAVING clause.
	This query has no HAVING clause.
*/

SELECT
	CustomerID,
	COUNT(*) AS count_orders
FROM Sales.SalesOrderHeader
GROUP BY CustomerID;
GO

-- Step 2b: This query uses a HAVING clause to filter out customers with fewer than 10 orders.

SELECT
	CustomerID,
	COUNT(*) AS count_orders
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
HAVING COUNT(*) >= 10;
GO

/*
	Step 2c: Review the logical order of opertaions the column alias for COUNT(*) hasn't been processed yet
	when HAVING refers to it.
	This will FAIL.
*/

SELECT
	CustomerID,
	COUNT(*) AS count_orders
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
HAVING count_orders >= 10;
GO

/*
	Step 2d: Select and execute the following queries to show difference between WHERE filter and HAVING filter:
	The following query uses a WHERE clause to filter orders.
*/

SELECT
	COUNT(*) AS cnt,
	AVG(OrderQty) AS [avg_qty]
FROM Production.Product AS P
INNER JOIN Sales.SalesOrderDetail AS OD
	ON (P.ProductID = OD.ProductID)
WHERE OD.OrderQty > 20
GROUP BY P.ProductLine;
GO

-- Step 2e: This query uses a HAVING clause to filter groups with an average quantity > 20

SELECT
	COUNT(*) AS cnt,
	AVG(OrderQty) AS [avg_qty]
FROM Production.Product AS P
INNER JOIN Sales.SalesOrderDetail AS OD
	ON P.productid = OD.productid
GROUP BY P.ProductLine
HAVING AVG(OrderQty) > 20;
GO

-- Step 2f: Select and execute the following query to show all customers and how many orders they have placed.

SELECT
	C.CustomerID,
	COUNT(*) AS no_of_orders
FROM Sales.Customer AS C
INNER JOIN Sales.SalesOrderHeader AS O
	ON (C.CustomerID = O.CustomerID)
GROUP BY C.CustomerID
ORDER BY no_of_orders DESC;
GO

-- Step 2g: Use HAVING to filter only customers who have placed more than 20 orders.

SELECT
	C.CustomerID,
	COUNT(*) AS no_of_orders
FROM Sales.Customer AS C
INNER JOIN Sales.SalesOrderHeader AS O
	ON (C.CustomerID = O.CustomerID)
GROUP BY C.CustomerID
HAVING COUNT(*) > 20
ORDER BY no_of_orders DESC;
GO

-- Step 2h: Select and execute the following query to show all products and in how many orders they appear.

SELECT
	P.ProductID,
	COUNT(*) AS cnt
FROM Production.Product AS P
INNER JOIN Sales.SalesOrderDetail AS OD
	ON (P.ProductID = OD.ProductID)
GROUP BY P.ProductID
ORDER BY cnt DESC;
GO

/*
	Step 2i: Use HAVING to filter only products which have been ordered less than 20 times.
	9 rows returned.
*/

SELECT
	P.ProductID,
	COUNT(*) AS cnt
FROM Production.Product AS P
INNER JOIN Sales.SalesOrderDetail AS OD
	ON (P.ProductID = OD.ProductID)
GROUP BY P.ProductID
HAVING COUNT(*) < 20
ORDER BY cnt DESC;
GO
--  Demonstration C

-- Step 1: Open a new query window to the AdventureWorksLT Database.

USE AdventureWorksLT;
GO

-- Step 2: Join 2 tables.
/*
	Select and execute the following query
	to show only matching customers and orders.
*/

SELECT C.CustomerID, soh.SalesOrderID
FROM SalesLT.Customer C
JOIN SalesLT.SalesOrderHeader SOH
	ON C.CustomerID = SOH.CustomerID;
GO

-- Step 3: Join 2 tables.
/*
	Select and execute the following query
	to show all customers and any matching orders.
*/

SELECT *
FROM SalesLT.Customer C
LEFT OUTER JOIN SalesLT.SalesOrderHeader SOH
	ON C.CustomerID = SOH.CustomerID;
GO

-- Step 4: Join 2 tables.
/*
	Select and execute the following query
	to show a left outer join.
*/

USE TSQL;
GO
SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
LEFT OUTER JOIN Sales.Orders AS O
	ON C.custid = O.custid;
GO

-- Step 5: Join 2 tables.
/*
	Select and execute the following query
	to show customers without orders.
*/

USE TSQL;
GO
SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
LEFT OUTER JOIN SALES.Orders AS O
	ON C.custid = O.custid
WHERE O.orderid IS NULL;
GO

-- STEP 6: Join 2 tables.
/*
	Select and execute the following query
	to show a right outer join.
*/

USE TSQL;
GO
SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
RIGHT OUTER JOIN Sales.Orders AS O
	ON C.custid = O.orderid;
GO

-- Step 7: Join 2 tables.
/*
	Select and execute the following query
	to show orders without customers.
*/

USE TSQL;
GO
SELECT C.custid, C.companyname, O.custid, O.orderdate
FROM Sales.Customers AS C
RIGHT OUTER JOIN Sales.Orders AS O
	ON C.custid = O.custid
WHERE C.custid IS NULL;
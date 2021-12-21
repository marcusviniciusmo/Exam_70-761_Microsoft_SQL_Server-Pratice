-- Demonstration C

-- Step 1: Open a new qurey window to the TSQL database.

USE TSQL;
GO

-- Step 2: Using EXISTS. Select this query and execute it to show any customer who placed an order.

SELECT custid, companyname
FROM Sales.Customers AS C
WHERE EXISTS
	(SELECT *
	FROM Sales.Orders AS O
	WHERE C.custid = O.custid);
GO

-- Step 3: Using NOT EXISTS. Return any customer who has not placed an order.

SELECT custid, companyname
FROM Sales.Customers AS C
WHERE NOT EXISTS
	(SELECT *
	FROM Sales.Orders AS O
	WHERE C.custid = O.custid);
GO

-- Step 4a: Compare COUNT(*) > 0 TO EXISTS:
-- Use COUNT(*) > 0

SELECT empid, lastname
FROM HR.Employees AS E
WHERE
	(SELECT COUNT(*)
	FROM Sales.Orders AS O
	WHERE O.empid = E.empid) > 0;
GO

-- Step 4b: Use EXISTS

SELECT empid, lastname
FROM HR.Employees AS E
WHERE EXISTS
	(SELECT *
	FROM Sales.Orders AS O
	WHERE O.empid = E.empid);
GO
-- Demonstration A

-- Step 1: Open a new query window to the TSQL database

USE TSQL;
GO

-- Step 2: Join 2 tables
/*
	Select and execute the following query
	to illustrate ANSI SQL-89 syntax to join 2 tables.
	Point out that 830 rows are returned.
*/

SELECT C.companyname, O.orderdate
FROM Sales.Customers AS C, Sales.Orders AS O
WHERE C.custid = O.custid;
GO

-- Step 3: Join 2 tables
/*
	Select and execute the following query
	to illustrate ANSI SQL-89 syntax omitting the WHERE clause
	and causing an inadvertent Cartesian join.
	Point out that 75530 rows are returned.
*/

SELECT C.companyname, O.orderdate
FROM Sales.Customers AS C, Sales.Orders AS O;
GO

-- Step 4: Join 2 tables
/*
	Select and execute the following query
	to illustrate ANSI SQL-92 syntax to join 2 tables.
	Point out that 830 rows returned.
*/

SELECT C.companyname,
	O.orderdate
FROM Sales.Customers AS C
JOIN Sales.Orders AS O
	ON (C.custid = O.custid);

-- Step 5: Join 2 tables
/*
	Select and execute the following query
	to illustrate ANSI SQL-92 syntax.
	Note that the ON clause is deliberately omitted to cause an error,
	showing the protection against accidental Cartesian Products.
	THIS WILL INTENTIONALLY CAUSE AN ERROR.
*/

SELECT C.companyname,
	O. orderdate
FROM Sales.Customers AS C
JOIN Sales.Orders AS O
	--ON C.custid = O.custid;
GO
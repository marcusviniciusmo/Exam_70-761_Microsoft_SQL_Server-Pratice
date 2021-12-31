-- Demonstration B

-- Step 1: Open a new query window to the TSQL database.

USE TSQL;
GO

-- Step 2: Using INTERSECT. Select this query and execute it to show the use of INTERSECT to return only rows found in both tables.

SELECT
	country, region, city
FROM HR.Employees

INTERSECT -- 3 distinct rows

SELECT
	country, region, city
FROM Sales.Customers;
GO

-- Step 3: Using EXCEPT. Return only rows from left table (HR.Employees)

SELECT
	country, region, city
FROM HR.Employees

EXCEPT

SELECT
	country, region, city
FROM Sales.Customers;
GO

-- Reverse position of tables, return only rows from Sales.Customers

SELECT
	country, region, city
FROM Sales.Customers

EXCEPT

SELECT
	country, region, city
FROM HR.Employees;
GO
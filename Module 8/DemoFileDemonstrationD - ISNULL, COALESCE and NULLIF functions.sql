-- Demonstration D

-- Step 1: Open a new query window to the TSQL datababse.

USE TSQL;
GO

-- Step 2: Select and execute the following query to illustrate the ISNULL function.

SELECT
	custid, city,
	ISNULL(region, 'N/A') AS region, country
FROM Sales.Customers;
GO

-- Step 3: Select and execute the following query to illustrate the COALESCE function.

SELECT
	custid, country, region, city,
	country + ', ' + COALESCE(region, ' ') + ', ' + city AS location
FROM Sales.Customers;
GO

-- Step 4a: Select and execute the following query to illustrate the NULLIF function.
-- First, set up sample data.

CREATE TABLE dbo.employee_goals
	( emp_id INT
	, goal INT
	, actual INT);
GO

-- Step 4b: Populate the sample data.

INSERT INTO dbo.employee_goals
VALUES
	(1, 100, 110),
	(2, 90, 90),
	(3, 100, 90),
	(4, 100, 80);
GO

-- Step 4c: Show the sample data.

SELECT
	emp_id, goal, actual
FROM dbo.employee_goals;
GO

-- Step 4d: Use NULLIF to show which employees have actual values different from their goals.

SELECT
	emp_id,
	NULLIF(actual, goal) AS actual_if_different
FROM dbo.employee_goals;
GO

-- Step 5: Clean up demo table.

DROP TABLE DBO.employee_goals;
GO
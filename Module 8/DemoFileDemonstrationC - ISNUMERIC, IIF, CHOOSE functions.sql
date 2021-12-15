-- Demonstration C

-- Step 1: Open a new query window to the TSQL database.

USE TSQL;
GO

-- Step 2: Select and execute the following query to illustrate the ISNUMERIC function with a character input.

SELECT ISNUMERIC('SQL') AS isnumeric_result;
GO

-- Step 3: Select and execute the following query to illustrate the ISNUMERIC function with a float input.

SELECT ISNUMERIC('1E3') AS isnumeric_result;
GO

-- Step 4: Select and execute the following query to illustrate the IIF function.

SELECT
	productid, unitprice,
	IIF(unitprice > 50, 'high', 'low') AS pricepoint
FROM Production.Products;
GO

-- Step 5: Select and execute the following query to illustrate the CHOOSE function.

SELECT CHOOSE(3, 'Beverages', 'Condiments', 'Confections') AS choose_result;
GO
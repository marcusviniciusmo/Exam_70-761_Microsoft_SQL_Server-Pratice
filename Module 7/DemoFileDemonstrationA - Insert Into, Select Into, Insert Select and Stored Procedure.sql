-- Demonstration A

-- Step 1: Connect to the TSQL database.

USE TSQL;
GO

-- Step 2: First try to INSERT by stored procedure to see that it doesn't work because it is not there.

INSERT INTO Production.Products
	( productid
	, productname
	, supplierid
	, categoryid
	, unitprice )
EXEC Production.AddNewProducts;
GO

/*
	To make this routine work we remove some rows from two linked tables to allow deletion,
	delete the rows and then put the rows back ;-)
*/

-- Step 3: Create a backup of the Products with a chosen ID.

DROP TABLE IF EXISTS NewProducts;
GO

SELECT * INTO NewProducts
FROM Production.Products
WHERE productid >= 70;
GO

-- Step 4: Create a backup of the Order Details for the chosen productID.

DROP TABLE IF EXISTS NewOrderDetails;
GO

SELECT * INTO NewOrderDetails
FROM Sales.OrderDetails
WHERE productid >= 70;
GO

-- Step 5: Delete the copied data from the original tables

DELETE
FROM Sales.OrderDetails
OUTPUT deleted.*
WHERE productid >= 70;
GO

DELETE
FROM Production.Products
OUTPUT deleted.*
WHERE productid >= 70;
GO

-- Step 6: Create a stored procedure.
/*
	Now we can put back the rows from the NewTables, using the INSERT statement.
	Firstly the Products, for which we will create a run a stored procedure.
*/

DROP PROCEDURE IF EXISTS Production.AddNewProducts;
GO

CREATE PROCEDURE Production.AddNewProducts
AS
	BEGIN
		SELECT productid, productname, supplierid, categoryid, unitprice
		FROM NewProducts;
	END
GO

-- Step 7: having created it, we can run it to feed the missing rows into the Products table

INSERT INTO Production.Products (productid, productname, supplierid, categoryid, unitprice)
EXEC Production.AddNewProducts;
GO

SELECT *
FROM Production.Products
WHERE productid >= 70;
GO

-- Step 8: The OrderDetails will be put back using INSERT..SELECT.

INSERT Sales.OrderDetails (orderid, productid, unitprice, qty, discount)
OUTPUT inserted.*
SELECT * FROM NewOrderDetails;
GO

-- Step 9: Clean up the database.

DROP TABLE NewProducts;
GO

DROP TABLE NewOrderDetails;
GO

DROP PROCEDURE Production.AddNewProducts;
GO
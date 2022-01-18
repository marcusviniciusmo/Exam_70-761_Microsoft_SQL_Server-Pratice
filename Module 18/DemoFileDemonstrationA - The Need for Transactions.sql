-- Demonstratio A

-- Step 1: Open a new query window to the TSQL database.

USE TSQL;
GO

-- Step 2: Create a table to support the demonstrations. Clean up if the tables already exists.

IF OBJECT_ID('dbo.SimpleOrderDetails', 'U') IS NOT NULL
	DROP TABLE dbo.SimpleOrderDetaisl;
IF OBJECT_ID('dbo.SimpleOrders', 'U') IS NOT NULL
	DROP TABLE dbo.SimpleOrders;
GO

CREATE TABLE dbo.SimpleOrders(
	orderid INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	custid INT NOT NULL FOREIGN KEY REFERENCES Sales.Customers(custid),
	empid INT NOT NULL FOREIGN KEY REFERENCES HR.Employees(empid),
	orderdate DATETIME NOT NULL
);
GO

CREATE TABLE dbo.SimpleOrderDetails(
	orderid INT NOT NULL FOREIGN KEY REFERENCES dbo.SimpleOrders(orderid),
	productid INT NOT NULL FOREIGN KEY REFERENCES Production.Products(productid),
	unitprice MONEY NOT NULL,
	qty SMALLINT NOT NULL,
	CONSTRAINT PK_OrderDetails PRIMARY KEY (orderid, productid)
);
GO

-- Step 3: Execute a multi statement batch with error.
-- Note: THIS STEP WILL CAUSE AN ERROR.

BEGIN TRY
	INSERT INTO dbo.SimpleOrders(custid, empid, orderdate) VALUES (68, 9, '2006-07-12');
	INSERT INTO dbo.SimpleOrders(custid, empid, orderdate) VALUES (88, 3, '2006-07-15');
	INSERT INTO dbo.SimpleOrderDetails(orderid, productid, unitprice, qty) VALUES (1, 2, 15.20, 20);
	INSERT INTO dbo.SimpleOrderDetails(orderid, productid, unitprice, qty) VALUES (999, 77, 26.20, 15);
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrNum, ERROR_MESSAGE() AS ErrMsg;
END CATCH;
GO

-- Step 4: Show that even with exception handling, partial success occurred and some rows were inserted.

SELECT
	orderid, custid, empid, orderdate
FROM dbo.SimpleOrders;
SELECT
	orderid, productid, unitprice, qty
FROM dbo.SimpleOrderDetails;

-- Step 5: Clean up demonstration tables.

IF OBJECT_ID('dbo.SimpleOrderDetails', 'U') IS NOT NULL
	DROP TABLE dbo.SimpleOrderDetails;
GO
IF OBJECT_ID('dbo.SimpleOrders', 'U') IS NOT NULL
	DROP TABLE dbo.SimpleOrders;
GO
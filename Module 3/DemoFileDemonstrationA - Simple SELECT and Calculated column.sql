-- Demonstration A - Use the AdventureWorksLT database on SQL Azure

-- Step 1: Connect to the AdventureWorksLT database
/*
	The USE statement is not currently compatible with SQL Azure databases.
	Instead, select	AdventureWorksLT from the Available Databases list.
*/

USE AdventureWorksLT;
GO

-- Step 2: Simple SELECT query
/*
	Select and execute the following query to retrieve all columns,
	all rows from SalesLT.ProductCategory table
*/

SELECT *
FROM SalesLT.ProductCategory;
GO

-- Step 3: Simple SELECT query
/*
	Select and execute the following query to retrieve all columns,
	all rows from SalesLT.ProductCategory table without using *
*/

SELECT ProductCategoryID,
	ParentProductCategoryID,
	Name,
	rowguid,
	ModifiedDate
FROM SalesLT.ProductCategory;
GO

-- Step 4: Simple SELECT query
/*
	Select and execute the following query to retrieve only ProductNumber,
	Name, Color, ListPrice columns from SalesLT.Product table
*/

SELECT ProductNumber,
	Name,
	Color,
	ListPrice
FROM SalesLT.Product;
GO

-- Step 5: Simple SELECT query
/*
	Select and execute the following query to retrive only Title,
	FirstName, LastName, CompanyName, EmailAddress columns from the SalesLT.Customer table
*/

SELECT Title,
	FirstName,
	LastName,
	CompanyName,
	EmailAddress
FROM SalesLT.Customer;
GO

-- Step 6: Simple SELECT query with calculated column
/*
	Select and execute the following query to manipulate columns from SalesLT.Product table.
	Note that lack of name for the new calculated column.
*/

SELECT ProductID,
	Name,
	ListPrice,
	(ListPrice * 1.1)
FROM SalesLT.Product;
GO

-- Step 7: Simple SELECT query with calculated column
/*
	Select and execute the following query to manipulate columns
	from SalesLT.SalesOrderDetail table.
	Note that the lack of name for the new calculated column.
*/

SELECT SalesOrderID,
	ProductID,
	UnitPrice,
	OrderQty,
	(UnitPrice * OrderQty)
FROM SalesLT.SalesOrderDetail;
GO
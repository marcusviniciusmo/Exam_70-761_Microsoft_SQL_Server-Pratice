---------------------------------------------------------------------
-- LAB 03

-- Exercise 1
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	TASK 1

	Using SSMS, connect to MIA-SQL using Windows Authentication
	(if you are connecting to an on-premises instance of SQL Server)
	or SQL authentication (if you are using SQL Azure).
	In Object Explorer, expand the TSQL database and expand the Tables folder.
	Take a look at the names of the tables in the Sales schema.
*/

-- Sales.Customers
-- Sales.OrderDetails
-- Sales.Orders
-- Sales.Shippers

/*
---------------------------------------------------------------------
	TASK 2

	Write a SELECT statement that will return all rows and all columns
	from the Sales.Customers table.
	Tip: You can use drag-and-drop functionality to drag items like table and column names
	from Oject Explorer to the query window.
	Write the same SELECT statement using drag-and-drop functionality.
	Execute the written statement and compare the results that you got
	with the desired results shown in the file Lab Exercise 1 - Task 2 Result.txt
*/

SELECT *
FROM Sales.Customers;
GO

-- Drag-and-drop
SELECT *
FROM [Sales].[Customers];
GO

/*
---------------------------------------------------------------------
	TASK 3

	Expand the Sales.Customers table in the Object Explorer and expand the Columns folder.
	Observe all columns in the table.
	Write a SELECT statement to return the contactname, address, postalcode, city and country columns.
	Execute the written statement and compare the results
	that you got with the desired results show in the file Lab Exercise 1 - Task 3 Result.txt.
	What is the number of rows affected by the last query?
	(Tip: Because you are issuing a SELECT statement agains the whole table,
	the number of rows will be the same as number of rows for the whole Sales.Customer table.)
*/

SELECT contactname,
	address,
	postalcode,
	city,
	country
FROM Sales.Customers;
GO
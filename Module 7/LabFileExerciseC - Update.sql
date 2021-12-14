---------------------------------------------------------------------
-- LAB 07
--
-- Exercise 3
---------------------------------------------------------------------

USE tempdb;
GO

-- Step 1: Setup exercise environment

CREATE SCHEMA Sales;
GO

/*
	Note that there is a much more efficient way, as above, of deleting existing objects in SQL Server 2016.
	However one often needs to get meta data information from the Information_Schema so both methods are
	useful to know about. The alternative method is used in the 99 Cleanup script, which can be used at the
	end of this lab or if you want to restart part way through.
*/

IF EXISTS ( SELECT *
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_NAME = 'Customers'
			AND TABLE_SCHEMA = 'Sales'
			AND TABLE_CATALOG = 'AdventureWorks2016')
			DROP TABLE AdventureWorks2016.Sales.Customer;
GO

SELECT * INTO Sales.Customers
FROM TSQL.Sales.Customers
WHERE contactname NOT IN (
	'Taylor, Maurice',
	'Mallit, Ken',
	'Tiano, Mike');
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Note, if no update is made then swap the titles around ;-)
*/

UPDATE Sales.Customers
SET contacttitle = 'Sales Consultant'
OUTPUT	inserted.contactname	AS 'New Name'
,		deleted.contactname		AS 'Old Name'
,		inserted.contacttitle	AS 'New Title'
,		deleted.contacttitle	AS 'Old Title'
,		inserted.city			AS 'New City'
,		deleted.city			AS 'Old City'
WHERE city = 'Berlin'
AND contacttitle = 'Sales Representative';

SELECT *
FROM Sales.Customers
WHERE city = 'Berlin';
GO

-- Step 2: Clean up

DROP TABLE IF EXISTS Sales.Customers;
GO

DROP SCHEMA IF EXISTS Sales;
GO
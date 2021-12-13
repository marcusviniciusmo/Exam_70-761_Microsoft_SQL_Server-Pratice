---------------------------------------------------------------------
-- LAB 07
--
-- Exercise 2
---------------------------------------------------------------------

USE tempdb;
GO

-- Step 1: Setup exercise environment.

CREATE SCHEMA Sales;
GO

/*
	Note that there is a much more efficient way, as above, of deleting existing ojects in SQL Server 2016.
	However one often needs to get meta data information from the Information_Schema so both methods are
	useful 	to know about. The alternative method is used in the 99 Cleanup script, which can be used at the
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

IF EXISTS ( SELECT *
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_NAME = 'PotentialCustomers'
			AND TABLE_SCHEMA = 'dbo'
			AND TABLE_CATALOG = 'AdventureWorks2016')
			DROP TABLE AdventureWorks2016.dbo.PotentialCustomer;
GO

SELECT * INTO dbo.PotentialCustomer FROM TSQL.Sales.Customers
WHERE contactname IN (
	'Taylor, Maurice',
	'Mallit, Ken',
	'Tiano, Mike');
GO

/*
---------------------------------------------------------------------
	>> TASK 1
*/

INSERT INTO Sales.Customers
	(companyname
	, contactname
	, contacttitle
	, address
	, city
	, region
	, postalcode
	, country
	, phone
	, fax)
OUTPUT inserted.*
SELECT
	companyname,
	contactname,
	contacttitle,
	address,
	city,
	region,
	postalcode,
	country,
	phone,
	fax
FROM dbo.PotentialCustomer;

-- Step 2: Clean up

DROP TABLE IF EXISTS dbo.PotentialCustomer;
GO

DROP TABLE IF EXISTS Sales.Customers;
GO

DROP SCHEMA IF EXISTS Sales;
GO
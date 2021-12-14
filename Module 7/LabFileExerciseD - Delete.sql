---------------------------------------------------------------------
-- LAB 07
--
-- Exercise 4
---------------------------------------------------------------------

USE tempdb;
GO

/*
	-- Step 1: Setup exercise environment

	Note that there is a much more efficient way, as above, of deleting existing objects in SQL Server 2016.
	However one often needs to get meta data information from the Information_Schema so both methods are
	useful to know about. The alternative method is used in the 99 Cleanup script, which can be used at the
	end of this lab or if you want to restart part way through.
*/

IF EXISTS ( SELECT *
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_NAME = 'PotentialCustomers'
			AND TABLE_SCHEMA = 'dbo'
			AND TABLE_CATALOG = 'AdventureWorks2016')
			DROP TABLE AdventureWorks2016.dbo.PotentialCustomers;
GO

SELECT * INTO dbo.PotentialCustomers
FROM TSQL.Sales.Customers
WHERE contactname IN (
	'Taylor, Maurice',
	'Mallit, Ken',
	'Tiano, Mike'
);
GO

/*
---------------------------------------------------------------------
	>> TASK 1
*/

DELETE FROM dbo.PotentialCustomers
OUTPUT deleted.*
WHERE contactname IN (
	'Taylor, Maurice',
	'Mallit, Ken',
	'Tiano, Mike'
);
GO

-- Step 2: Clean up

DROP TABLE IF EXISTS dbo.PotentialCustomers;
GO
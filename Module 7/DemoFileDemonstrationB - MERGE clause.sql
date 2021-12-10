-- Demonstration B

-- Step 1: Connect to the AdventureWorks2016 database or connect to Azure Database if you have access to it.

USE AdventureWorks2016;
GO

SELECT * INTO Store FROM Sales.Store					-- Make a copy of the Sales.Store table
SELECT TOP (10) * FROM Sales.Store						-- Show taht you have done this
SELECT TOP (10) * INTO StoreBackup FROM Sales.Store		-- Copy the top 10 rows into source
SELECT * FROM StoreBackup								-- Make a copy of the Sales.Store table
SELECT * FROM Store										-- Make a copy of the Sales.Store table

-- Step 2: Remove the copied rows from the Store table

DELETE FROM Store
OUTPUT deleted.*
WHERE BusinessEntityID <= (SELECT MAX(BusinessEntityID) FROM StoreBackup) -- Remove top 10 rows from target

-- Step 3: Show that they have been removed

SELECT BusinessEntityID FROM Store				-- Show that the rows have been copied back into Sales
INTERSECT
SELECT BusinessEntityID FROM StoreBackup

-- Step 4: Use the MERGE statement to put them back

MERGE TOP (10) INTO Store AS Destination									-- Known in online help as Target, which is a reserved word
	USING StoreBackup AS StagingTable										-- Known in online help as the source, which is also a reserved word
	ON (Destination.BusinessEntityID = StagingTable.BusinessEntityID)		-- the matching control column
WHEN NOT MATCHED THEN
	INSERT ( BusinessEntityID
		   , Name
		   , SalesPersonID
		   , Demographics
		   , rowguid
		   , ModifiedDate
			)
	VALUES ( StagingTable.BusinessEntityID
		   , StagingTable.Name
		   , StagingTable.SalesPersonID
		   , StagingTable.Demographics
		   , StagingTable.rowguid
		   , StagingTable.ModifiedDate
		   )
	OUTPUT inserted.*;

-- Step 5: SELECT * FROM Sales.Store where 1 = 0 -- used to extract column names for all columns, without cost of data access

SELECT BusinessEntityID FROM Store				-- Show that the rows have been copied back into Sales
INTERSECT
SELECT BusinessEntityID FROM StoreBackup

UPDATE Store SET Name = 'TestUpdate'
OUTPUT inserted.Name AS NewName,
	   deleted.Name  AS OldName
WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM StoreBackup)		-- Updates Names in store that are for backend up sotres

SELECT * FROM Store WHERE Name = 'TestUpdate'								-- Show that they have been changed

-- Step 6: Use the Merge statement to change the names back

MERGE TOP (10) INTO Store AS Destination								-- Known in online help as Target, which is a reserved word
	USING StoreBackup AS StagingTable									-- Known in online help as the source, which is also a reserved word
	ON (Destination.BusinessEntityID = StagingTable.BusinessEntityID)	-- the matching control column
WHEN MATCHED THEN --
	UPDATE SET
				Destination.BusinessEntityID = StagingTable.BusinessEntityID
		,		Destination.Name			 = StagingTable.Name
		,		Destination.SalesPersonID	 = StagingTable.SalesPersonID
		,		Destination.Demographics	 = StagingTable.Demographics
		,		Destination.rowguid			 = StagingTable.rowguid
		,		Destination.ModifiedDate	 = StagingTable.ModifiedDate
OUTPUT $Action, inserted.*, deleted.*;

/*
	Ensure that the environment has been restored to the
	state it was in before the changes were made
*/

SELECT * FROM Store

-- Step 7: Clean up the database

DROP TABLE IF EXISTS Store;
DROP TABLE IF EXISTS StoreBackup;
GO
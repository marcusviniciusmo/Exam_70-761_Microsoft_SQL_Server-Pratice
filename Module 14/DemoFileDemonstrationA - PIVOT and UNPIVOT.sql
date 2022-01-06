-- Demonstration A

-- Step 1: Open a new query window to the TSQL database.

USE TSQL;
GO

-- Step 2: Create view for inner derived table (for screen space/convenience).

IF OBJECT_ID('Sales.CategoryQtyYear', 'V') IS NOT NULL
	DROP VIEW Sales.CategoryQtyYear;
GO

CREATE VIEW Sales.CategoryQtyYear
AS
	SELECT
		C.categoryname AS Category,
		D.qty AS Qty,
		YEAR(O.orderdate) AS Orderyear
	FROM Production.Categories AS C
		INNER JOIN Production.Products AS P
			ON (P.categoryid = C.categoryid)
		INNER JOIN Sales.OrderDetails AS D
			ON (D.productid = P.productid)
		INNER JOIN Sales.Orders AS O
			ON (O.orderid = D.orderid);
GO

-- Step 3: Test view, review data.

SELECT
	Category, Qty, Orderyear
FROM Sales.CategoryQtyYear;
GO

-- Step 4: PIVOT and UNPIVOT. PIVOT Categories on orderyear.

SELECT
	Category, [2006], [2007], [2008]
FROM (
		SELECT
			Category, Qty, Orderyear
		FROM Sales.CategoryQtyYear
	) AS D
	PIVOT(SUM(Qty) FOR orderyear IN ([2006], [2007], [2008])) AS pvt
ORDER BY Category;
GO

-- Step 5: Setup for UNPIVOT demo. Pivot categories on orderyear, save to temp table. Create staging table to hold pivoted table.

CREATE TABLE [Sales].[PivotedCategorySales](
	[Category] [NVARCHAR](15) NOT NULL,
	[2006] [INT] NULL,
	[2007] [INT] NULL,
	[2008] [INT] NULL);
GO

-- Populate it by pivoting from view.

INSERT INTO Sales.PivotedCategorySales
	(Category, [2006], [2007], [2008])
SELECT
	Category, [2006], [2007], [2008]
FROM (
		SELECT
			Category, Qty, Orderyear
		FROM Sales.CategoryQtyYear
	) AS D
	PIVOT(SUM(Qty) FOR orderyear IN ([2006], [2007], [2008])) AS P;
GO

-- Testing staging table.

SELECT
	Category, [2006], [2007], [2008]
FROM Sales.PivotedCategorySales;
GO

-- Step 6: UNPIVOT.

SELECT
	Category, Qty, Orderyear
FROM Sales.PivotedCategorySales
UNPIVOT(qty FOR orderyear IN ([2006], [2007], [2008])) AS unpvt;
GO

-- Step 7: Clean up.

IF OBJECT_ID('Sales.CategoryQtyYear', 'V') IS NOT NULL
	DROP VIEW Sales.CategoryQtyYear;
GO

IF OBJECT_ID('Sales.PivotedCategorySales') IS NOT NULL
	DROP TABLE Sales.PivotedCategorySales;
GO
-- Demonstration A

-- Step 1: Open a new query window to the TSQL database.

USE TSQL;
GO

-- Step 2: Creating windows with OVER.
-- Setup views for demo.

IF OBJECT_ID('Production.CategorizedProducts', 'V') IS NOT NULL
	DROP VIEW Production.CategorizedProducts
GO

CREATE VIEW Production.CategorizedProducts
AS
	SELECT
		Production.Categories.categoryid AS CatID,
		Production.Categories.categoryname AS CatName,
		Production.Products.productname AS ProdName,
		Production.Products.unitprice AS UnitPrice
	FROM Production.Categories
	INNER JOIN Production.Products
		ON (Production.Categories.categoryid = Production.Products.categoryid);
GO

IF OBJECT_ID('Sales.CategoryQtyYear', 'V') IS NOT NULL
	DROP VIEW Sales.CategoryQtyYear
GO

CREATE VIEW Sales.CategoryQtyYear
AS
	SELECT
		C.categoryname AS Category,
		SUM(D.qty) AS Qty,
		YEAR(O.orderdate) AS Orderyear
	FROM Production.Categories AS C
		INNER JOIN Production.Products AS P
			ON (P.categoryid = C.categoryid)
		INNER JOIN Sales.OrderDetails AS D
			ON (D.productid = P.productid)
		INNER JOIN Sales.Orders AS O
			ON (O.orderid = D.orderid)
	GROUP BY C.categoryname, YEAR(O.orderdate);
GO

-- Step 3: Using OVER with ordering. Ranking products by price from high to low.

SELECT
	CatID, CatName, ProdName, UnitPrice,
		RANK() OVER(
			ORDER BY UnitPrice DESC) AS PriceRank
FROM Production.CategorizedProducts
ORDER BY PriceRank;
GO

-- Ranking products by price in descending order in each category. Note the ties.

SELECT
	CatID, CatName, ProdName, UnitPrice,
		RANK() OVER(
			PARTITION BY CatID
			ORDER BY UnitPrice DESC) AS PriceRank
FROM Production.CategorizedProducts
ORDER BY CatID;
GO

/*
	Step 4: Use framing to create running total. Display a running total of quantity per product category. This uses framing to set boundaries
	at the start of the set and the current row, for each partition.
*/

SELECT
	Category, Qty, Orderyear,
		SUM(Qty) OVER(
			PARTITION BY category
			ORDER BY orderyear
			ROWS BETWEEN UNBOUNDED PRECEDING
			AND CURRENT ROW) AS RunningQty
FROM Sales.CategoryQtyYear;
GO

-- Display a running total of quantity per year.

SELECT
	Category, Qty, Orderyear,
		SUM(Qty) OVER(
			PARTITION BY orderyear
			ORDER BY category
			ROWS BETWEEN UNBOUNDED PRECEDING
			AND CURRENT ROW) AS RunningQty
FROM Sales.CategoryQtyYear;
GO

-- Show both side-by-side per category and per-year

SELECT
	Category, Qty, Orderyear,
		SUM(Qty) OVER(
			PARTITION BY orderyear
			ORDER BY category
			ROWS BETWEEN UNBOUNDED PRECEDING
			AND CURRENT ROW) AS RunningTotalByYear,
		SUM(Qty) OVER(
			PARTITION BY category
			ORDER BY orderyear
			ROWS BETWEEN UNBOUNDED PRECEDING
			AND CURRENT ROW) AS RunningTotalByCategory
FROM Sales.CategoryQtyYear
ORDER BY Orderyear, Category;
GO

-- Clean up

IF OBJECT_ID('Production.CategorizedProducts', 'V') IS NOT NULL
	DROP VIEW Production.CategorizedProducts;
GO

IF OBJECT_ID('Sales.CategoryQtyYear', 'V') IS NOT NULL
	DROP VIEW Sales.CategoryQtyYear;
GO
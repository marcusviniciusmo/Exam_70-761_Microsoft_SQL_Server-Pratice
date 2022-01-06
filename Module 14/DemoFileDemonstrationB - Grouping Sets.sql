-- Demonstration B

-- Step 1: Open a new query window to the TSQL database.

USE TSQL;
GO

-- Step 2: Setup objects for demo.

IF OBJECT_ID('Sales.CategorySales', 'V') IS NOT NULL
	DROP VIEW Sales.CategorySales;
GO

CREATE VIEW Sales.CategorySales
AS
	SELECT
		C.categoryname AS Category,
		O.empid AS Emp,
		O.custid AS Cust,
		D.qty AS Qty,
		YEAR(O.orderdate) AS Orderyear
	FROM Production.Categories AS C
		INNER JOIN Production.Products AS P
			ON (P.categoryid = C.categoryid)
		INNER JOIN Sales.OrderDetails AS D
			ON (D.productid = P.productid)
		INNER JOIN Sales.Orders AS O
			ON (O.orderid = O.orderid)
	WHERE C.categoryid IN (1, 2, 3) AND O.custid BETWEEN 1 AND 5; -- limits results for slides
GO

-- Step 3: Show query without use of grouping sets

SELECT
	Category, NULL AS Cust, SUM(Qty) AS TotalQty
FROM Sales.CategorySales
GROUP BY Category

UNION ALL

SELECT
	NULL, Cust, SUM(Qty) AS TotalQty
FROM Sales.CategorySales
GROUP BY Cust

UNION ALL

SELECT
	NULL, NULL, SUM(Qty) AS TotalQty
FROM Sales.CategorySales;
GO

-- Step 4: Query with grouping sets.

SELECT
	Category, Cust, SUM(Qty) AS TotalQty
FROM Sales.CategorySales
GROUP BY
	GROUPING SETS ((Category), (Cust), ())
ORDER BY Category, Cust;
GO

-- Step 5: Query with CUBE.

SELECT
	Category, Cust, SUM(Qty) AS TotalQty
FROM Sales.CategorySales
GROUP BY CUBE (Category, Cust)
ORDER BY Category, Cust;
GO

-- Step 6: With ROLLUP.

SELECT
	Category, Cust, SUM(Qty) AS TotalQty
FROM Sales.CategorySales
GROUP BY ROLLUP (Category, Cust)
ORDER BY Category, Cust;
GO

-- Step 7: Using GROUPING_ID.

SELECT
	GROUPING_ID(Category) AS grpCat,
	GROUPING_ID(Cust) AS grpCust,
	Category, Cust, SUM(Qty) AS TotalQty
FROM Sales.CategorySales
GROUP BY CUBE (Category, Cust)
ORDER BY Category, Cust;
GO

-- Step 8: Clean up.

IF OBJECT_ID('Sales.CategorySales', 'V') IS NOT NULL
	DROP VIEW Sales.CategorySales;
GO
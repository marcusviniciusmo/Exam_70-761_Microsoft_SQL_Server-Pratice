-- Demonstration B

-- Step 1: Open a new query	window to the TSQL database.

USE TSQL;
GO

-- Step 2: Setup views for demo

IF OBJECT_ID('Production.CategorizedProducts', 'V') IS NOT NULL
	DROP VIEW Production.CategorizedProducts;
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
			on (Production.Categories.categoryid = Production.Products.categoryid);
GO

IF OBJECT_ID('Sales.CategoryQtyYear', 'V') IS NOT NULL
	DROP VIEW Sales.CategoryQtyYear;
GO

CREATE VIEW Sales.CategoryQtyYear
AS
	SELECT
		C.categoryname AS category,
		SUM(D.qty) AS Qty,
		YEAR(O.orderdate) AS Orderyear
	FROM Production.Categories AS C
		INNER JOIN Production.Products AS P
			ON (P.productid = C.categoryid)
		INNER JOIN Sales.OrderDetails AS D
			ON (D.productid = P.productid)
		INNER JOIN Sales.Orders AS O
			ON (O.orderid = D.orderid)
		GROUP BY C.categoryname, YEAR(O.orderdate);
GO

IF OBJECT_ID('Sales.OrdersByEmployeeYear', 'V') IS NOT NULL
	DROP VIEW Sales.OrdersByEmployeeYear;
GO

CREATE VIEW Sales.OrdersByEmployeeYear
AS
	SELECT
		E.empid AS Employee,
		YEAR(O.orderdate) AS Orderyear,
		SUM(D.qty * D.unitprice) AS Totalsales
	FROM HR.Employees AS E
		INNER JOIN Sales.Orders AS O
			ON (O.empid = E.empid)
		INNER JOIN Sales.OrderDetails AS D
			ON (D.orderid = O.orderid)
	GROUP BY E.empid, YEAR(O.orderdate);
GO

-- Step 3: Using Window Aggregate Functions. RANK demo from Lesson 2 Slide.

SELECT
	productid,
	productname,
	unitprice,
		RANK() OVER(
			ORDER BY unitprice DESC) AS PriceRank
FROM Production.Products
ORDER BY PriceRank;
GO

-- Step 4: Simple aggregate window function. Show SUM computed per partition. Note: no need for ORDER BY within OVER() in this example.

SELECT
	custid,
	ordermonth,
	qty,
		SUM(qty) OVER(
			PARTITION BY custid) AS totalpercust
FROM Sales.CustOrders;
GO

-- Step 5: Side-by-side use of aggregate functions with OVER().

SELECT
	CatID, CatName, ProdName, UnitPrice,
		SUM(UnitPrice) OVER(
			PARTITION BY CatID) AS Total,
		AVG(UnitPrice) OVER(
			PARTITION BY CatID) AS Average,
		COUNT(UnitPrice) OVER(
			PARTITION BY CatID) AS ProdsPerCat
FROM Production.CategorizedProducts
ORDER BY CatID;
GO

-- Step 6: Compare RANK with DENSE_RANK to show treatment of ties. Note the gaps in RANK not present in DENSE_RANK.

SELECT
	CatID, CatName, ProdName, UnitPrice,
		RANK() OVER(
			PARTITION BY CatID
			ORDER BY UnitPrice DESC) AS PriceRank,
		DENSE_RANK() OVER(
			PARTITION BY CatID
			ORDER BY UnitPrice DESC) AS DensePriceRank
FROM Production.CategorizedProducts
ORDER BY CatID;
GO

-- Step 7: Row_Number.

SELECT
	CatID, CatName, ProdName, UnitPrice,
		ROW_NUMBER() OVER(
			PARTITION BY CatID
			ORDER BY UnitPrice DESC) AS RowNumber
FROM Production.CategorizedProducts
ORDER BY CatID;
GO

-- Step 8: NTILE to create 7 groups.

SELECT
	CatID, CatName, ProdName, UnitPrice,
		NTILE(7) OVER(
			PARTITION BY CatID
			ORDER BY UnitPrice DESC) AS NT
FROM Production.CategorizedProducts
ORDER BY CatID, NT;
GO

-- Step 9: Offset Functions. LAG to compare one year's sale to last. Note partitioning by employee.

SELECT
	Employee, Orderyear, Totalsales AS CurrentSales,
		LAG(Totalsales, 1, 0) OVER(
			PARTITION BY employee
			ORDER BY orderyear) AS previousyearsales
FROM Sales.OrdersByEmployeeYear
ORDER BY Employee, Orderyear;
GO

-- Step 10: Use FIRST_VALUE to compare current row to first in partition.

SELECT
	Employee,
	Orderyear,
	Totalsales AS CurrentSales,
	(Totalsales - FIRST_VALUE(Totalsales) OVER(
		PARTITION BY employee
		ORDER BY orderyear)) AS salesdiffsincefirstyear
FROM Sales.OrdersByEmployeeYear
ORDER BY Employee, Orderyear;
GO

-- Step 11: Clean up.

IF OBJECT_ID('Production.CategorizedProducts', 'V') IS NOT NULL
	DROP VIEW Production.CategorizedProducts;
GO

IF OBJECT_ID('Sales.CategoryQtyYear', 'V') IS NOT NULL
	DROP VIEW Sales.CategoryQtyYear;
GO

IF OBJECT_ID('Sales.OrdersByEmployeeYear', 'V') IS NOT NULL
	DROP VIEW Sales.OrdersByEmployeeYear;
GO
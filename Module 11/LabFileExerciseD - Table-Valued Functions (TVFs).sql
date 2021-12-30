---------------------------------------------------------------------
-- LAB 11
--
-- Exercise 4
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a SELECT statement against the Sales.OrderValues view and retrieve the custid and totalsalesamount columns as a total of the
	val column. Filter the results to include orders only for the order year 2007.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 82 - Lab Exercise 4 -
	Task 1 Result.txt.
	Define inline table-valued function using the following function header and add your previous query after the RETURN clause.
	Modify the query by replacing the constant year value 2007 in WHERE clause with the parameter @orderyear.
	Highlight the complete code and execute it. This will create an inline table-valued function named dbo.fnGetSalesByCustomer.
*/

SELECT
	custid,
	SUM(val) AS totalsalesamount
FROM Sales.OrderValues
WHERE YEAR(orderdate) = 2007
GROUP BY custid;
GO

-- Initial SQL statement

CREATE FUNCTION dbo.fnGetSalesByCustomer
(@orderyear AS INT) RETURNS TABLE
AS
RETURN

SELECT
	custid,
	SUM(val) AS totalsalesamount
FROM Sales.OrderValues
WHERE YEAR(orderdate) = @orderyear
GROUP BY custid;
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Write a SELECT statement to retrieve the custid and totalsalesamount columns from the dbo.fbGetSalesByCustomer inline table-valued function.
	Use the value 2007 for the needed parameter.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 83 - Lab Exercise 4 -
	Task 2 Result.txt.
*/

SELECT
	custid, totalsalesamount
FROM dbo.fnGetSalesByCustomer(2007);
GO

/*
---------------------------------------------------------------------
	>> TASK 3

	In this task, you will query the Production.Products and Sales.OrderDetails tables. Write a SELECT statement that retrieves the top three
	sold products based on the total sales value for the customer with ID 1. Return the productid and productname columns from the
	Production.Products table. Use the qty and unitprice columns from the Sales.OrderDetails table to compute each order line's value, and
	return the sum of all values per product, naming the resulting column totalsalesamount. Filter the results to include only the rows where
	the custid value is equal to 1.
	Execute the T-SQL code and compare the results that you got with the recommended result shown in the file 84 - Lab Exercise 4 - Task 3_1
	Result.txt.
	Create an inline table-valued function based on the follwoing function header, using the previous SELECT statement. Replace the constant
	custid value 1 in the query with the function's input parameter @custid.
	Highlight the complete code and execute it. This will create an inline table-valued function named dbo.fnGetTop3ProductsForCustomer that
	excepts a parameter for the customer id.
	Test the created inline table-valued function by writing a SELECT statement against it and use the value 1 for the customer id parameter.
	Retrieve the productid, productname, and totalsalesamount columns, and use the alias p for the inline table-valued function.
	Execute the T-SQL code and compare the results that you got with the recommended result shown in the file 85 - Lab Exercise 4 - Task 3_2
	Result.txt.
*/

-- Solution 3_1

SELECT TOP (3)
	P.productid,
	MAX(P.productname) AS productname,
	SUM(D.qty * D.unitprice) AS totalsalesamount
FROM Sales.Orders AS O
INNER JOIN Sales.OrderDetails AS D
	ON (O.orderid = D.orderid)
INNER JOIN Production.Products AS P
	ON (P.productid = D.productid)
WHERE O.custid = 1
GROUP BY P.productid
ORDER BY totalsalesamount DESC;
GO

-- Solution 3_2

CREATE FUNCTION dbo.fnGetTop3ProductsForCustomer
(@custid AS INT) RETURNS TABLE
AS
RETURN

SELECT TOP (3)
	P.productid,
	MAX(P.productname) AS productname,
	SUM(D.qty * D.unitprice) AS totalsalesamount
FROM Sales.Orders AS O
INNER JOIN Sales.OrderDetails AS D
	ON (O.orderid = D.orderid)
INNER JOIN Production.Products AS P
	ON (P.productid = D.productid)
WHERE O.custid = @custid
GROUP BY P.productid
ORDER BY totalsalesamount DESC;
GO

-- Test

SELECT
	p.productid,
	p.productname,
	p.totalsalesamount
FROM dbo.fnGetTop3ProductsForCustomer(1) AS p;
GO

/*
---------------------------------------------------------------------
	>> TASK 4

	Write a SELECT statement to retrieve the same result as in Exercise 3, Task 3, but use the created inline table-valued function
	in task 2 (dbo.fnGetSalesByCustomer).
	Execute the written statement and compare the results that you got with the recommended result shown in the file 86 - Lab Exercise 4 -
	Task 4.Result.txt.
*/

SELECT
	C.custid, C.contactname,
	sales2007.totalsalesamount AS salesamt2007,
	sales2008.totalsalesamount AS salesamt2008,
	COALESCE((sales2008.totalsalesamount - sales2007.totalsalesamount) / sales2007.totalsalesamount * 100, 0) AS percentgrowth
FROM Sales.Customers AS C
LEFT OUTER JOIN dbo.fnGetSalesByCustomer(2007) AS sales2007
	ON (C.custid = sales2007.custid)
LEFT OUTER JOIN dbo.fnGetSalesByCustomer(2008) AS sales2008
	ON (C.custid = sales2008.custid)
ORDER BY percentgrowth DESC;
GO

/*
---------------------------------------------------------------------
	>> TASK 5

	Remove the created inline table-valued functions by executing the provided T-SQL statement. Execute this query code exactly
	as written inside a query window.
*/

IF OBJECT_ID('dbo.fnGetSalesByCustomer') IS NOT NULL
	DROP FUNCTION dbo.fnGetSalesByCustomer;
GO

IF OBJECT_ID('dbo.fnGetTop3ProductsForCustomer') IS NOT NULL
	DROP FUNCTION dbo.fnGetTop3ProductsForCustomer;
GO
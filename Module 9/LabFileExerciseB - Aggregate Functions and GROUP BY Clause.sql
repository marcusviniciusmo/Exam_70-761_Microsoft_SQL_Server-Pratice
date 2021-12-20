---------------------------------------------------------------------
-- LAB 09
--
-- Exercise 2
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a SELECT statement to retrieve the orderid column from the Sales.Orders table and the total sales amount per orderid.
	(Hint: Multiply the qty and unitprice columns from the Sales.OrderDetails table). Use the alias salesmount for the calculated
	column. Sort the result by the total sales amount in descending order.
	Execute the written statement and compare the results that you got with the desired results shown in the file 62 - Lab Exercise 2 -
	Task 1 Result.txt.
*/

SELECT
	O.orderid,
	SUM(OD.qty * OD.unitprice) AS salesmount
FROM Sales.Orders AS O
INNER JOIN Sales.OrderDetails AS OD
	ON (O.orderid = OD.orderid)
GROUP BY O.orderid
ORDER BY salesmount DESC;
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Copy the T-SQL statement in Task 1 and modify it to include the total of number of order lines for each order
	and the average order line sales amount value within the order. Use the aliases nooforderlines and avgsalesamountperorderline,
	respectively.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 63 - Lab Exercise 2 -
	Task 2 Result.txt.
*/

SELECT
	O.orderid,
	SUM(OD.qty * OD.unitprice) AS salesmount,
	COUNT(*) AS nooforderlines,
	AVG(OD.qty * OD.unitprice) AS avgsalesamountperorderline
FROM Sales.Orders AS O
INNER JOIN Sales.OrderDetails AS OD
	ON (O.orderid = OD.orderid)
GROUP BY O.orderid
ORDER BY salesmount DESC;
GO

/*
---------------------------------------------------------------------
	>> TASK 3

	Write a SELECT statement to retrieve the total sales amount for each month. The SELECT clause should include a calculated column
	named yearmonthno (YYYYMM notation) based on the orderdate column in the Sales.Orders table and a total sales amount (multiply
	the qty and unitprice columns from the Sales.OrderDetails table). Order the result by the yearmonthno calculated column.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 64 - Lab Exercise 2 -
	Task 3 Result.txt.
*/

SELECT
	YEAR(O.orderdate) * 100 + MONTH(O.orderdate) AS yearmonthno,
	SUM(OD.qty * OD.unitprice) AS salesamountpermonth
FROM Sales.Orders AS O
INNER JOIN Sales.OrderDetails AS OD
	ON (O.orderid = OD.orderid)
GROUP BY YEAR(O.orderdate), MONTH(O.orderdate)
ORDER BY yearmonthno;
GO

/*
---------------------------------------------------------------------
	>> TASK 4

	Write a SELECT statement to retrieve all the customers (including those that did not place any orders) and their total sales amount,
	maximum sales amount per order line, and number of order lines.
	The SELECT clause should include the custid and contactname columns from the Sales.Customers table and four calculated columns based on
	appropriate aggregate functions:
		- totalsalesamount, representing the total sales amount per order.
		- maxsalesamountperorderline, representing the maximum sales amount per order line.
		- numberofrows, representing the number of rows (use * in the COUNT function).
		- numberoforderlines, representing the number of order lines (use the orderid column in the COUNT function).
	Order the result by the totalsalesamount column.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 65 - Lab Exercise 2 -
	Task 4 Result.txt.
	Notice that the custid 22 and 57 rows have a NULL in the column with the SUM and MAX aggregate functions. What are their values in the
	COUNT columns? Why are they different?
*/

SELECT
	C.custid, C.contactname,
	SUM(OD.qty * OD.unitprice) AS totalsalesamount,
	MAX(OD.qty * OD.unitprice) AS maxsalesamountperorderline,
	COUNT(*) AS numberofrows,
	COUNT(O.orderid) AS numberoforderlines
FROM Sales.Customers AS C
LEFT OUTER JOIN Sales.Orders AS O
	ON (C.custid = O.custid)
LEFT OUTER JOIN Sales.OrderDetails AS OD
	ON (O.orderid = OD.orderid)
GROUP BY C.custid, C.contactname
ORDER BY totalsalesamount;
GO
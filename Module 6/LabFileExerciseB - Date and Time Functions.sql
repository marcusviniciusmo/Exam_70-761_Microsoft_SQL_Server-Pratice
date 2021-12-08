---------------------------------------------------------------------
-- LAB 07
--
-- Exercise 2
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a SELECT statement to retrieve distinct values for the custid column from the Sales.Orders table.
	Filter the results to include only orders placed in February 2008.
	Execute the written statement and compare the results that you got with the desired results shown in the file
	62 - Lab Exercise 2 - Task 1 Result.txt.
*/

-- SOLUTION 1:
SELECT DISTINCT custid
FROM Sales.Orders
WHERE YEAR(orderdate) = 2008
	AND MONTH(orderdate) = 2;
GO

-- SOLUTION 2:
SELECT DISTINCT custid
FROM Sales.Orders
WHERE orderdate >= '20080201'
	AND orderdate < '20080301';
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Write a SELECT statement with these columns:
	- Current date and time.
	- First date of the current month.
	- Last date of the current month.
	Execute the written statement and compare the results that you got with the recommended result shown in the file
	63 - Lab Exercise 2 - Task 2 Result.txt. The results will be differ because they rely on the current date.
*/

SELECT
	CURRENT_TIMESTAMP AS currentdatetime,
	DATEADD(DAY, 1, EOMONTH(CURRENT_TIMESTAMP, -1)) AS firstdate,
	EOMONTH(CURRENT_TIMESTAMP) AS lastdate

/*
---------------------------------------------------------------------
	>> TASK 3

	Write a SELECT statement against the Sales.Orders table and retrieve the orderid, custid and orderdate columns.
	Filter the results to include only orders placed in the last five days of the order month.
	Execute the written statement and compare the results that you got with the recommended result shown in the file
	64 - Lab Exercise 2 - Task 3 Result.txt.
*/

SELECT orderid, custid, orderdate
FROM Sales.Orders
WHERE
	DATEDIFF(DAY, orderdate, EOMONTH(orderdate)) < 5;
GO

/*
---------------------------------------------------------------------
	>> TASK 4

	Write a SELECT statement against the Sales.Orders and Sales.OrderDetails tables and retrieve all the distinct values
	for the productid column. Filter the results to include only orders placed in the first 10 weeks of the year 2007.
	Execute the written statement and compare the results that you got with the recommended result shown in the file
	65 - Lab Exercise 2 - Task 4 Result.txt.
*/

SELECT DISTINCT productid
FROM Sales.Orders AS O
INNER JOIN Sales.OrderDetails AS OD
	ON (O.orderid = OD.orderid)
WHERE DATEPART(WEEK, orderdate) <= 10
	AND YEAR(orderdate) = '2007'
GO
---------------------------------------------------------------------
-- LAB 13
--
-- Exercise 2
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Define a CTE named OrderRows based on a query that retrieves the orderid, orderdate, and val columns from Sales.OrderValues view. Add a
	calculated column named rowno using the ROW_NUMBER function, ordering by the orderdate and orderid columns.
	Write a SELECT statement against the CTE and use the LEFT JOIN with the same CTE to retrieve the current row and the previous row based on
	the rowno column. Return the orderid, orderdate, and val columns for the current row and the val column from the previous row as prevval. Add
	a calculated column named diffprev to show the difference between the current val and previous val.
	Execute the T-SQL code and compare the results that you got with the desired results shown in the file 62 - Lab Exercise 2 - Task 1
	Result.txt.
*/

WITH OrderRows
AS
(
	SELECT
		orderid, orderdate,
		ROW_NUMBER() OVER(
			ORDER BY orderdate, orderid
		) AS rowno,
		val
	FROM Sales.OrderValues
)

SELECT
	O1.orderid,
	O1.orderdate,
	O1.rowno,
	O1.val,
	O2.val AS prevval,
	(O1.val - O2.val) AS diffprev
FROM OrderRows AS O1
LEFT OUTER JOIN OrderRows AS O2
	ON (O1.orderid = O2.orderid + 1);
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Write a SELECT statement that uses the LAG funtion to achieve the same results as the query in the previous Task. The query should
	not define a CTE.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 63 - Lab Exercise 2 -
	Task 2 Result.txt.
*/

SELECT
	orderid,
	orderdate,
	val,
	LAG(val) OVER(
		ORDER BY orderdate, orderid) AS diffprev,
	(val - LAG(val) OVER(
		ORDER BY orderdate, orderid
	)) AS prevval
FROM Sales.OrderValues;
GO

/*
---------------------------------------------------------------------
	>> TASK 3

	Define a CTE named SalesMonth2007 that creates two columns: monthno (the month number of the orderdate column) and val (aggregate val column).
	Filter the results to include only order year 2007 and group by monthno.
	Write a SELECT statement that retrieves the monthno and val columns from the CTE and adds three calculated columns:
		- avglast3months. This column should contain the average sales amount for last three months before the current month. (Use multiple LAG
			functions and divide the sum by three). You can assume that there's a row for each month in the CTE.
		- diffjanuary. This column should contain the difference between the current val and the January val. (Use the FIRST_VALUE function.)
		- nextval. This column should contain the next month value of the val column.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 64 - Lab Exercise 2 - Task 3
	Result.txt. You will practice how to do this correctly in the next exercise.
*/

WITH SalesMonth2007
AS
(
	SELECT
		MONTH(orderdate) AS monthno,
		SUM(val) AS val
	FROM Sales.OrderValues
	WHERE orderdate >= '20070101' AND orderdate < '20080101'
	GROUP BY MONTH(orderdate)
)

SELECT
	monthno,
	val,
	((LAG(val, 1, 0) OVER(
		ORDER BY monthno) +
	LAG(val, 2, 0) OVER(
		ORDER BY monthno) +
	LAG(val, 3, 0) OVER(
		ORDER BY monthno)) / 3) AS avglast3months,
	val - FIRST_VALUE(val) OVER(
		ORDER BY monthno
		ROWS UNBOUNDED PRECEDING) AS diffjanuary,
	LEAD(val) OVER(
		ORDER BY monthno) AS nextval
FROM SalesMonth2007;
GO
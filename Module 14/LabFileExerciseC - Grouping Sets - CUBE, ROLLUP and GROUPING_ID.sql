---------------------------------------------------------------------
-- LAB 14
--
-- Exercise 3
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a SELECT statement against the Sales.Customers table and retrieve the country column, the city column, and a calculated column
	noofcustomers as a count of customers. Retrieve multiple grouping sets based on the country and city columns, the country column, the city
	column, and a column with an empty grouping set.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 72 - Lab Exercise 3 -
	Task 1 Result.txt.
*/

SELECT
	country, city, COUNT(custid) AS noofcustomers
FROM Sales.Customers
GROUP BY
	GROUPING SETS
	(
		(country, city),
		(country),
		(city),
		()
	);
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Write a SELECT statement against the view Sales.OrderValues and retrieve these columns:
		- Year of the orderdate column as orderyear
		- Month of the orderdate column as ordermonth
		- Day of the orderdate column as orderday
		- Total sales value using the val column as salesvalue
	Return all possible grouping sets based on the orderyear, ordermonth, and orderday columns.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 73 - Lab Exercise 3 -
	Task 2 Result.txt. Notice the total number of rows in your results.
*/

SELECT
	YEAR(orderdate) AS orderyear,
	MONTH(orderdate) AS ordermonth,
	DAY(orderdate) AS orderday,
	SUM(val) AS salesvalue
FROM Sales.OrderValues
GROUP BY CUBE (YEAR(orderdate), MONTH(orderdate), DAY(orderdate))
GO

/*
---------------------------------------------------------------------
	>> TASK 3

	Copy the previous query and modify it to use the ROLLUP subclause instead of the CUBE subclause.
	Execute the modified query and compare the results that you got with the recommended result shown in the file 74 - Lab Exercise 3 -
	Task 3 Result.txt. Notice the number of rows in your results.
	Whaat is the difference between the ROLLUP and CUBE subclauses?
	Which is the more appropriate subclause to use in this example?
*/

SELECT
	YEAR(orderdate) AS orderyear,
	MONTH(orderdate) AS ordermonth,
	DAY(orderdate) AS orderday,
	SUM(val) AS salesvalue
FROM Sales.OrderValues
GROUP BY ROLLUP (YEAR(orderdate), MONTH(orderdate), DAY(orderdate));
GO

/*
	Answer: ROLLUP creates subtotals at any level of aggregation needed, from the most detailed up to a grand total. CUBE is an extension similar
	to ROLLUP, enabling a single statement to calculate all possible combinations of subtotal. In this example is more appropriate the use of the
	ROLLUP sublcause.
*/

/*
---------------------------------------------------------------------
	>> TASK 4

	Write a SELECT statement against the Sales.OrderValues view and retrieve these columns:
		- Calculated column with the alias groupid (use the GROUPING_ID function with the order year and order month as the imput parameters)
		- Year of the orderdate column as orderyear
		- Month of the orderdate column as ordermonth
		- Total sales value using the val column as salesvalue
	Since year and month form a hierarchy, return all interesting grouping sets based on the orderyear and ordermonth columns and sort the result
	by groupid, orderyear, and ordermonth.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 75 - Lab Exercise 3 -
	Task 4 Result.txt.
*/

SELECT
	GROUPING_ID(YEAR(orderdate), MONTH(orderdate)) AS groupid,
	YEAR(orderdate) AS orderyear,
	MONTH(orderdate) AS ordermonth,
	SUM(val) AS salesvalue
FROM Sales.OrderValues
GROUP BY ROLLUP (YEAR(orderdate), MONTH(orderdate))
ORDER BY groupid, orderyear, ordermonth;
GO
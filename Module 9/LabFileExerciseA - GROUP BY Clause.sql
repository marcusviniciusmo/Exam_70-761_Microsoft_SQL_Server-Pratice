---------------------------------------------------------------------
-- LAB 09
--
-- Exercise 1
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a SELECT statement that will return groups of customers that made a purchase. The SELECT clause should include
	the custid column from the Sales.Orders table and the contactname column from the Sales.Customers table. Group by both
	columns and filter only the orders from the Sales Employee whose empid equals five.
	Execute the written statement and compare the results that you got with the desired results shown in the file 52 - Lab
	Exercise 1 - Task 1 Result.txt
*/

SELECT
	O.custid,
	C.contactname
FROM Sales.Orders AS O
INNER JOIN Sales.Customers AS C
	ON (O.custid = C.custid)
WHERE O.empid = 5
GROUP BY O.custid, C.contactname
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Copy the T-SQL statement in Task 1 and modify it to include the city column from the Sales.Customers table in the SELECT clause.
	Execute the query. You will get an error. What is the error message? Why?
	Correct the query so that it will execute properly.
	Execute the query and compare the results that you got with the desired results shown in the file 53 - Lab Exercise 1 - Task 2
	Result.txt.
*/

SELECT
	O.custid,
	C.contactname,
	C.city
FROM Sales.Orders AS O
INNER JOIN Sales.Customers AS C
	ON (O.custid = C.custid)
WHERE O.empid = 5
GROUP BY O.custid, C.contactname;
GO

/*
	Answer: The 'Sales.Customers.City' column is invalid because is not contained in an aggregation function neither in a GROUP BY clause.
	The 'Sales.Customers.City' column must be in the GROUP BY clause too.
*/

-- Correction

SELECT
	O.custid,
	C.contactname,
	C.city
FROM Sales.Orders AS O
INNER JOIN Sales.Customers AS C
	ON (O.custid = C.custid)
WHERE O.empid = 5
GROUP BY O.custid, C.contactname, C.city;
GO

/*
---------------------------------------------------------------------
	>> TASK 3

	Write a SELECT statement that will return groups of rows based on the custid column and a calculated column orderyear
	representing the order year based on the orderdate column from the Sales.Orders table. Filter the results to include
	only the orders from the sales employee whose empid equal five.
	Execute the written statement and compare the results that you got with the desired results shown in the file 54 - Lab
	Exercise 1 - Task 3 Result.txt.
*/

SELECT
	custid,
	YEAR(orderdate) AS orderyear
FROM Sales.Orders
WHERE empid = 5
GROUP BY custid, YEAR(orderdate)
ORDER BY custid, orderyear;
GO

/*
---------------------------------------------------------------------
	>> TASK 4

	Write a SELECT statement to retrieve groups of rows based on the categoryname column in the Production.Categories table.
	Filter the results to include only the product categories that were ordered in the year 2008.
	Execute the written statement and compare the results that you got with the desired results shown in the file 55 - Lab
	Exercise 1 - Task 4 Result.txt.
*/

SELECT
	C.categoryid,
	C.categoryname
FROM Sales.Orders AS O
INNER JOIN Sales.OrderDetails AS OD
	ON (O.orderid = OD.orderid)
INNER JOIN Production.Products AS P
	ON (P.productid = OD.productid)
INNER JOIN Production.Categories AS C
	ON (C.categoryid = P.categoryid)
WHERE orderdate >= '20080101' AND orderdate < '20090101'
GROUP BY C.categoryid, C.categoryname
ORDER BY C.categoryid;
GO
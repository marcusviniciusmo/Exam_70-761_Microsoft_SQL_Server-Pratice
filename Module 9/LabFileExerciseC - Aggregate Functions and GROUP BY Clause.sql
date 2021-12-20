---------------------------------------------------------------------
-- LAB 09
--
-- Exercise 3
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	A junior analyst prepared a T-SQL statement to retrieve the number of orders and the number of costumers for each order year.
	Observe the provided T-SQL statement and execute it:
	Observe the result and notice that the number of orders is the same as the number of costumers. Why?
	Correct the T-SQL statement to show the correct number of customers that placed an order for each year.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 72 - Lab Exercise 3 -
	Task 1 Result.txt.
*/

SELECT
	YEAR(orderdate) AS orderyear,
	COUNT(orderid) AS nooforders,
	COUNT(custid) AS noofcustomers
FROM Sales.Orders
GROUP BY YEAR(orderdate);
GO

/*
	Answer: Because the number of rows is the same for both columns and the T-SQL statement is counting the total of rows with.
	Same values are counted more than one time.
*/

SELECT
	YEAR(orderdate) AS orderyear,
	COUNT(orderid) AS nooforders,
	COUNT(DISTINCT custid) AS noofcustomers
FROM Sales.Orders
GROUP BY YEAR(orderdate);
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Write a SELECT statement to retrieve the number of customers based on the first letter of the values in the contactname column
	from the Sales.Customers table. Add an additional column to show the total number of orders placed by each group of customers.
	Use the aliases firstletter, noofcustomers and nooforders. Order the result by the firstletter column.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 73 - Lab Exercise 3 -
	Task 2 Result.txt.
*/

SELECT
	SUBSTRING(C.contactname, 1, 1) AS firstletter,
	COUNT(DISTINCT C.custid) AS noofcustomers,
	COUNT(O.orderid) AS nooforders
FROM Sales.Customers AS C
LEFT OUTER JOIN Sales.Orders AS O
	ON (C.custid = O.custid)
GROUP BY SUBSTRING(contactname, 1, 1)
ORDER BY firstletter;
GO

/*
---------------------------------------------------------------------
	>> TASK 3

	Copy the T-SQL statement in Exercise 1, Task 4, and modify to include the following information about for each product category:
	total sales amount, number of order, and average sales amount per order. Use the aliases totalsalesamount, nooforders, and
	avgsalesamountperorder, respectively.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 74 - Lab Exercise 3 -
	Task 3 Result.txt.
*/

SELECT
	C.categoryid,
	C.categoryname,
	SUM(OD.qty * OD.unitprice) AS totalsalesamount,
	COUNT(DISTINCT O.orderid) AS nooforders,
	SUM(OD.qty * OD.unitprice) / COUNT(DISTINCT O.orderid) AS avgsalesamountperorder
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
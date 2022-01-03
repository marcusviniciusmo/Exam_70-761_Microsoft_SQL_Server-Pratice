---------------------------------------------------------------------
-- LAB 12
--
-- Exercise 3
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a SELECT statement to retrieve the custid column from the Sales.Orders table. Filter the results to include only customers that bought
	more than 20 different products (based on the productid column from the Sales.OrderDetails table).
	Execute the written statement and compare the results that you got with the recommended result shown in the file 72 - Lab Exercise 3 -
	Task 1 Result.txt.
*/

SELECT
	O.custid
FROM Sales.Orders AS O
INNER JOIN Sales.OrderDetails AS D
	ON (O.orderid = D.orderid)
GROUP BY O.custid
HAVING COUNT(DISTINCT D.productid) > 20;
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Write a SELECT statement to retrieve the custid column from the Sales.Orders table. Filter the results to include only customers from the
	country USA and exclude all customers from the previous (Task 1) result. (Hint: Use the EXCEPT operator and the previous query).
	Execute the written statement and compare the results that you got with the recommended result shown in the file 73 - Lab Exercise 3 -
	Task 2 Result.txt.
*/

SELECT
	custid
FROM Sales.Customers
WHERE country = 'USA'

EXCEPT

SELECT
	O.custid
FROM Sales.Orders AS O
INNER JOIN Sales.OrderDetails AS D
	ON (D.orderid = O.orderid)
GROUP BY O.custid
HAVING COUNT(DISTINCT D.productid) > 20;
GO

/*
---------------------------------------------------------------------
	>> TASK 3

	Write a SELECT statement to retrieve the custid colum from the Sales.Orders table. Filter only customers that have a total sales value
	greater than $10,000. Calculate the sales value using the qty and unitprice columns from the Sales.OrderDetails table.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 73 - Lab Exercise 3 -
	Task 3 Result.txt.
*/

SELECT
	O.custid
FROM Sales.Orders AS O
INNER JOIN Sales.OrderDetails AS D
	ON (O.orderid = D.orderid)
GROUP BY custid
HAVING SUM(D.qty * D.unitprice) > 10000
ORDER BY custid;
GO

/*
---------------------------------------------------------------------
	>> TASK 4

	Copy the T-SQL statement from Task 2. Add the INTERSECT operator at the end of the statement. After the INTERSECT operator, add
	the T-SQL statement from Task 3.
	Execute the T-SQL statement and compare the results that you got with the recommended result shown in the file 74 - Lab Exercise 3 -
	Task 4 Result.txt. Notice the total number of rows in the result.
	Can you explain in business terms which customers are part of the result?
*/

SELECT
	custid
FROM Sales.Customers
WHERE country = 'USA'

EXCEPT

SELECT
	O.custid
FROM Sales.Orders AS O
INNER JOIN Sales.OrderDetails AS D
	ON (O.orderid = D.orderid)
GROUP BY custid
HAVING COUNT(DISTINCT D.productid) > 20

INTERSECT

SELECT
	custid
FROM SALES.Orders AS O
INNER JOIN Sales.OrderDetails AS D
	ON (O.orderid = D.orderid)
GROUP BY custid
HAVING SUM(D.qty * D.unitprice) > 10000;
GO

/*
	Answer: The customers that are part of the result are those one have the country USA, excluding the customers that bought more than 20
	different products and including the customers that have a total sales amount greater than $10,000. The precedence order is INTERSECT,
	and then is executed the EXCEPT operator.
*/

/*
---------------------------------------------------------------------
	>> TASK 5

	Copy the T-SQL statement from the previous Task and add parentheses around the first two SELECT statements (from the beginning until the
	INTERSECT operator).
	Execute the T-SQL statement and compare the results that you got with the recommended result shown in the file 75 - Lab Exercise 3 -
	Task 5 Result.txt. Notice the total number of rows in the result.
	Is the result different than the result from Task 4? Please explain why.
	What is the precedence among the set operators?
*/

(SELECT
	custid
FROM Sales.Customers
WHERE country = 'USA'

EXCEPT

SELECT
	O.custid
FROM SALES.Orders AS O
INNER JOIN Sales.OrderDetails AS D
	ON (O.orderid = D.orderid)
GROUP BY custid
HAVING COUNT(DISTINCT D.productid) > 20)

INTERSECT

SELECT
	O.custid
FROM Sales.Orders AS O
INNER JOIN Sales.OrderDetails AS D
	ON (O.orderid = D.orderid)
GROUP BY custid
HAVING SUM(D.qty * D.unitprice) > 10000;
GO

/*
	Answer: The result is different because the precedence order is: parentheses, then INTERSECT operator, and then EXCEPT operator.
*/
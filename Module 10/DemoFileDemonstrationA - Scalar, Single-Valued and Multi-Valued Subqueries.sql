-- Demonstration A

-- Step 1: Open a new query window to the TSQL database.

USE TSQL;
GO

-- Step 2: Scalar Subqueries. Select this query and execute it to obtain most recent order.

SELECT MAX(orderid) AS lastorder
FROM Sales.Orders;
GO

-- Step 3: Select this query and execute it to find details in Sales.OrderDetails for most recent order.

SELECT *
FROM Sales.OrderDetails
WHERE orderid =
	(SELECT MAX(orderid) AS lastorder
	FROM Sales.Orders);
GO

-- Step 4: This will FAIL, since subquery returns more than 1 value.

SELECT orderid, productid, unitprice, qty
FROM Sales.OrderDetails
WHERE orderid = 
	(SELECT orderid AS O
	FROM Sales.Orders
	WHERE empid = 2);
GO

-- Step 5: Multi-valued subqueries. Select this query and execute it to return order info for customers in Mexico.

SELECT custid, orderid
FROM Sales.Orders
WHERE custid IN
	(SELECT custid
	FROM Sales.Customers
	WHERE country = N'Mexico');
GO

-- Step 6: Same result expressed as a join:

SELECT C.custid, O.orderid
FROM Sales.Customers AS C
INNER JOIN Sales.Orders AS O
	ON (C.custid = O.custid)
WHERE C.country = N'Mexico';
GO
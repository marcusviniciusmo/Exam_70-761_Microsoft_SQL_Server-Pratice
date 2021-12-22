---------------------------------------------------------------------
-- LAB 10
--
-- Exercise 2
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> Task 1

	Write a SELECT statement to retrieve the productid and productname columns from the Production.Products table. Filter the results
	to include only products that were sold in high quantities (more than 100 products) for a specific order line.
	Execute the written statement and compare the results that you got with the desired results shown in the file 62 - Lab Exercise 2 -
	Task 1 Result.txt.
*/

SELECT productid, productname
FROM Production.Products
WHERE productid IN
	(SELECT productid
	FROM Sales.OrderDetails
	WHERE qty > 100);
GO

/*
---------------------------------------------------------------------
	>> Task 2

	Write a SELECT statement to retrieve the custid and contactname columns from the Sales.Customers table. Filter the results
	to include only those customers that do not have any placed orders.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 63 - Lab Exercise 2 -
	Task 2 Result.txt.
*/

SELECT custid, contactname
FROM Sales.Customers
WHERE custid NOT IN
	(SELECT custid
	FROM Sales.Orders);
GO

/*
---------------------------------------------------------------------
	>> Task 3

	The IT department has written a T-SQL statement that inserts an additional row in the Sales.Orders table. This row has a NULL in the
	custid column.
	Execute this query exactly as written inside a query window.
	Copy the T-SQL statement you wrote in Task 2 and execute it.
	Observe the result. How many rows are in the result? Why?
	Modify the T-SQL statement to retrieve the same number of rows as in Task 2. (Hint: You have to remove the rows with an unknown value
	in the custid column.)
	Execute the modified statement and compare the results that you got with the recommended result shown in the file 64 - Lab Exercise 2 -
	Task 3 Result.txt.
*/

INSERT INTO Sales.Orders
	(custid, empid, orderdate, requireddate, shippeddate, shipperid, freight,
	shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry)
VALUES
	(NULL, 1, '20111231', '20111231', '20111231', 1, 0,
	'ShipOne', 'ShipAddress', 'ShipCity', 'RA', '1000', 'USA');
GO

-- NULL issue

SELECT custid, contactname
FROM Sales.Customers
WHERE custid NOT IN
	(SELECT custid
	FROM Sales.Orders);
GO

/*
	Answer: 0 rows returned. Because there is a NULL value.
*/

SELECT custid, contactname
FROM Sales.Customers
WHERE custid NOT IN
	(SELECT custid
	FROM Sales.Orders
	WHERE custid IS NOT NULL)
GO
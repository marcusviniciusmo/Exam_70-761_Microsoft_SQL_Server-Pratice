---------------------------------------------------------------------
-- LAB 12
--
-- Exercise 1
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a SELECT statement to return the productid and productname columns from the Production.Products table. Filter the results
	to include only products that have a categoryid value 4.
	Execute the written statement and compare the results that you got with the desired results shown in the file 52 - Lab Exercise 1 -
	Task 1 Result.txt.
*/

SELECT
	productid, productname
FROM Production.Products
WHERE categoryid = 4;
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Write a SELECT statement to return the productid and productname columns from the Production.Products table. Filter the results
	to include only products that have a total sales amount more than $50,000. For the total sales amount, you will need to query the
	Sales.OrderDetails table and aggregate all order line values (qty * unitprice) for each product.
	Execute the written statement and compare the results that you got with the desired results shown in the file 53 - Lab Exercise 1 -
	Task 2 Result.txt Remember the number of rows in the result.
*/

SELECT
	P.productid, P.productname
FROM Production.Products AS P
INNER JOIN Sales.OrderDetails AS D
	ON (D.productid = P.productid)
GROUP BY P.productid, P.productname
HAVING SUM(D.qty * D.unitprice) > 50000;
GO

/*
---------------------------------------------------------------------
	>> TASK 3

	Write a SELECT statement that uses the UNION operator to retrieve the productid and productname columns from the T-SQL statements
	in Task 1 and Task 2.
	Execute the written statement and compare the results that you got with the desired results shown in the file 54 - Lab Exercise 1 -
	Task 3_1 Result.txt.
	What is the total number of rows in the result? If you compare this number with an aggregate value of the number of rows from Task 1
	and Task 2 is there any difference?
	Copy the T-SQL statement and modify it to use the UNION ALL operator.
	Execute the written statement and compare the results that you got with the desired results shown in the file 55 - Lab Exercise 1 -
	Task 3_2 Result.txt.
	what is the total number of rows in the result? What is the difference between the UNION and UNION ALL operators?
*/

-- UNION

SELECT
	productid, productname
FROM Production.Products
WHERE categoryid = 4

UNION

SELECT
	P.productid, P.productname
FROM Sales.OrderDetails AS D
INNER JOIN Production.Products AS P
	ON (P.productid = D.productid)
GROUP BY P.productid, P.productname
HAVING SUM(D.qty * D.unitprice) > 50000;
GO

/*
	Answer: 12 rows. There is a difference, the aggregate value is 14 rows and using UNION operator the number of rows is 12.
*/

-- UNION ALL

SELECT
	productid, productname
FROM Production.Products
WHERE categoryid = 4

UNION ALL

SELECT
	P.productid, P.productname
FROM Sales.OrderDetails AS D
INNER JOIN Production.Products AS P
	ON (D.productid = P.productid)
GROUP BY P.productid, P.productname
HAVING SUM(D.qty * D.unitprice) > 50000;
GO

/*
	Answer: 14 rows. The UNION operator brings the distinct rows and the UNION ALL operator brings the all rows.
*/

/*
---------------------------------------------------------------------
	>> TASK 4

	Write a SELECT statement to retrieve the custid and contactname columns from the Sales.Customers table. Display the top 10 customers
	by sales amount for January 2008 and display the top 10 customers by sales amount for February 2008 (Hint: Write two SELECT statements
	each joining Sales.Customers and Sales.OrderValues and use the appropriate set operator.)
	Execute the T-SQL code and compare the results that you got with the desired results shown in the file 56 - Lab Exercise 1 -
	Task 4 Result.txt.
*/

SELECT
	C1.custid, C1.contactname
FROM (
		SELECT TOP (10)
			O.custid, C.contactname
		FROM Sales.OrderValues AS O
		INNER JOIN Sales.Customers AS C
			ON (C.custid = O.custid)
		WHERE O.orderdate >= '20080101' AND O.orderdate < '20080201'
		GROUP BY O.custid, C.contactname
		ORDER BY SUM(O.val) DESC
	) AS C1

UNION

SELECT
	C2.custid, C2.contactname
FROM (
		SELECT TOP (10)
			O.custid, C.contactname
		FROM Sales.OrderValues AS O
		INNER JOIN Sales.Customers AS C
			ON (C.custid = O.custid)
		WHERE O.orderdate >= '20080201' AND O.orderdate < '20080301'
		GROUP BY O.custid, C.contactname
		ORDER BY SUM(O.val) DESC
	) AS C2;
GO
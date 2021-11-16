---------------------------------------------------------------------
-- LAB 04
--
-- Exercise 4
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a SELECT statement to retrieve the custid and contactname columns from the Sales.Customers table and
	the orderid column from the Sales.Orders table. The statement should retrieve all rows from the Sales.Customers table.
	Execute the written statement and compare the results that you got with the recommended result shown in the file
	82 - Lab Exercise 4 - Task 1 Result.txt.
	Notice the values in the column orderid. Are there any missing values (maarked as NULL)? Why?
*/

SELECT C.custid, C.contactname, O.orderid
FROM Sales.Customers AS C
LEFT OUTER JOIN SALES.Orders AS O
	ON C.custid = O.custid;
GO

/*
	Answer 1: Yes, there are missing values.
	Answer 2: Because the query will show all the rows from the Sales.Customers table (LEFT OUTER JOIN)
	and there are some rows with a value in custid column from Sales.Customers that won't exist in Sales.Orders table.
*/
---------------------------------------------------------------------
-- LAB 05
--
-- Exercise 1
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a SELECT statement that will return the custid, companyname, contactname, address, city, country and phone columns
	from the Sales.Customers table.
	Filter the results to include only the customers from the country Brazil.
	Execute the written statement and compare the results that you got with the desired results shown in the file 52 - Lab
	Exercise 1 Task 1 Result.txt.
*/

SELECT custid, companyname, contactname, address, city, country, phone
FROM Sales.Customers
WHERE country = N'Brazil';
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Write a SELECT statement that will return the custid, companyname, contactname, address, city, country and phone columns
	from the Sales.Customers table.
	Filter the results to include only customers from the countries Brazil, UK and USA.
	Execute the written statement and compare the results that you got with the desired results shown in the file 53 - Lab
	Exercise 1 Task 2 Result.txt.
*/

SELECT custid, companyname, contactname, address, city, country, phone
FROM Sales.Customers
WHERE country IN (N'Brazil', N'UK', N'USA');
GO

/*
---------------------------------------------------------------------
	>> TASK 3

	Write a SELECT statement that will return the custid, companyname, contactname, address, city, country and phone columns
	from the Sales.Customers table.
	Filter the results to include only the customers with a contact name starting with the letter A.
	Execute the written statement and compare the results that you got with the desired results shown in the file 54 - Lab
	Exercise 1 - Task 3 Result.txt.
*/

SELECT custid, companyname, contactname, address, city, country, phone
FROM Sales.Customers
WHERE contactname LIKE N'A%';
GO

/*
---------------------------------------------------------------------
	>> TASK 4a

	The IT department has written a T-SQL statement that retrieves the custid and companyname columns from the Sales.Customers table
	and the orderid column from the Sales.Orders table.
	Execute the query. Notice two things:
	- First, the query retrieves all the rows from the Sales.Customers table.
	- Second, there is a comparison operator in the ON clause specifying that the city column should be equal to the value "Paris".
*/

SELECT C.custid, C.companyname, O.orderid, *
FROM Sales.Customers AS C
LEFT OUTER JOIN Sales.Orders AS O
	ON (C.custid = O.custid AND C.city = N'Paris');
GO

/*
---------------------------------------------------------------------
	>> TASK 4b

	Copy the provided T-SQL statement and modify it to have a comparison operator for the city column in the WHERE clause.
	Execute the query.
	Compare the results that you got with the desired results shown in the file 56 - Lab Exercise 1 - Task 4b Result.txt.
	In the result the same as in the first T-SQL statement? Why? What is the difference between specifyng the predicate in the ON clause
	and in the WHERE clause?
*/

SELECT C.custid, C.companyname, O.orderid
FROM Sales.Customers AS C
LEFT OUTER JOIN Sales.Orders AS O
	ON (C.custid = O.custid)
WHERE C.city = N'Paris';
GO

/*
	Answer 1: It's not the same result.
	Answer 2: In Task 4a, the result is the comparison between custid from Sales.Customers table and custid from Sales.Orders table AND
	at the same time the result when the city is "Paris". In Task 4b, the result is a comparison, and then is filtered with the city is
	"Paris".
*/

/*
---------------------------------------------------------------------
	>> TASK 5

	Write a T-SQL statement to retrieve customers from the Sales.Customers table that do not have matching orders in the Sales.Orders table.
	Matching customers with orders is based on a comparison between the customer's custid value and the order's custid value.
	Retrieve the custid and companyname columns from Sales.Customers table.
	(Hint: Use a T-SQL statement that is similar to the one in the previous task.)
	Execute the written statement and compare the results that you got with the desired results shown in the file 57 - Lab Exercise 1 -
	Task 5 Result.txt.
*/

SELECT C.custid, C.companyname
FROM Sales.Customers AS C
LEFT OUTER JOIN Sales.Orders AS O
	ON (C.custid = O.custid)
WHERE O.custid IS NULL;
GO
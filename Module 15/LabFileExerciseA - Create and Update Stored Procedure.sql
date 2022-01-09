---------------------------------------------------------------------
-- LAB 15
--
-- Exercise 1
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Execute the provided T-SQL code to create the stored procedure Sales.GetTopCustomers.
	Write a T-SQL statement to execute the created procedure.
	Execute the T-SQL statement and compare the results that you got with the desired results shown in the file 52 - Lab Exercise 1 -
	Task 1 Result.txt.
*/

CREATE PROCEDURE Sales.GetTopCustomers
AS
	SELECT TOP (10)
		C.custid,
		C.contactname,
		SUM(O.val) AS salesvalue
	FROM Sales.OrderValues AS O
	INNER JOIN Sales.Customers AS C
		ON (C.custid = O.custid)
	GROUP BY C.custid, C.contactname
	ORDER BY salesvalue DESC;
GO

-- Solution

EXECUTE Sales.GetTopCustomers;
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	The IT department has changed the stored procedure from Task 1 and has supplied you with T-SQL code to apply the needed changes. Execute the
	provided T-SQL code.
	Write a SELECT statement to execute the modified stored procedure.
	Execute the T-SQL statement and compare the results that you got with the desired results shown in the file 53 - Lab Exercise 1 -
	Task 2 Result.txt.
	What is the difference between the previous T-SQL code and this one?
	If some applications are using the stored procedure from Task 1, would they still work properly after the changes you have applied in Task 2?
*/

ALTER PROCEDURE Sales.GetTopCustomers
AS
	SELECT
		C.custid,
		C.contactname,
		SUM(O.val) AS salesvalue
	FROM Sales.OrderValues AS O
	INNER JOIN Sales.Customers AS C
		ON (C.custid = O.custid)
	GROUP BY C.custid, C.contactname
	ORDER BY salesvalue DESC
	OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
GO

EXECUTE Sales.GetTopCustomers;
GO

/*
	Answer: The previous T-SQL code always show only ten rows and this one show the ten first results based on the OFFSET clause.
*/
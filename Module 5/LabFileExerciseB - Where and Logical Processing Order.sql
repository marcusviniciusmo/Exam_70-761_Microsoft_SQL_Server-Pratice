---------------------------------------------------------------------
-- LAB 05
--
-- Exercise 2
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a SELECT statement to retrieve the custid and contactname columns from the Sales.Customers table and the orderid and orderdate
	columns from Sales.Orders table.
	Filter the results to include only orders placed on or after April, 1 2008 (filter the orderdate column).
	Then sort the result by orderdate in descending order and custid in ascending order.
	Execute the written statement and compare the results that you got with the desired results in shown in the file 62 - Lab Exercise 2 -
	Task 1 Result.txt.
*/

SELECT C.custid, C.contactname, O.orderid, O.orderdate
FROM Sales.Customers AS C
INNER JOIN Sales.Orders AS O
	ON (C.custid = O.custid)
WHERE O.orderdate >= '20080401'
ORDER BY O.orderdate DESC, C.custid ASC;
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Execute the query exactly as written inside a query window and observe the result.
	You get an error. What is the error message? Why do you think you got this error? (Tip: Remember the logical processing order of the query).
	Apply the needed changes to the SELECT statement so that it will run without an error. Test the changes by executing the T-SQL statement.
	Observe and compare the results that you got with the recommended result shown in the file 63 - Lab Exercise 2 - Task 2 Result.txt.
*/

SELECT
	E.empid, E.lastname, E.firstname, E.title, E.mgrid,
	M.lastname AS mgrlastname, M.firstname AS mgrfirstname
FROM HR.Employees AS E
INNER JOIN HR.Employees AS M
	ON (E.mgrid = M.empid)
WHERE mgrlastname = N'Buck'

/*
	Answer 1: Name of column 'mgrlastname' is invalid.
	Answer 2: In the logical processing order of the query, the WHERE clause comes first then SELECT clause. In the WHERE statement,
	the predicate is an alias declared in the SELECT clause, and that's why the WHERE clause don't recognize that alias.
*/

SELECT
	E.empid, E.lastname, E.firstname, E.title, E.mgrid,
	M.lastname AS mgrlastname, M.firstname AS mgrfirstname
FROM HR.Employees AS E
INNER JOIN HR.Employees AS M
	ON (E.mgrid = M.empid)
WHERE M.lastname = N'Buck';
GO

/*
---------------------------------------------------------------------
	>> TASK 3a

	Copy the existing T-SQL statement from Task 2 and modify it so that the result will return all employees and be ordered by the
	manager's first name.
	Try first to use the source column name.
*/

SELECT
	E.empid, E.lastname, E.firstname, E.title, E.mgrid,
	M.lastname AS mgrlastname, M.firstname AS mgrfirstname
FROM HR.Employees AS E
INNER JOIN HR.Employees AS M
	ON (E.mgrid = M.empid)
--ORDER BY HR.Employees.firstname
ORDER BY M.firstname;
GO

/*
---------------------------------------------------------------------
	>> TASK 3b

	Now try to use the alias column name.
	Execute the written statement and compare the results with the recommended result shown in the file 64 - Lab Exercise 2 - Task
	3 Result.txt.
	Why were you equally able to use a source column name or alias column name?
*/

SELECT
	E.empid, E.lastname, E.firstname, E.title, E.mgrid,
	M.lastname AS mgrlastname, M.firstname AS mgrfirstname
FROM HR.Employees AS E
INNER JOIN HR.Employees AS M
	ON (E.mgrid = M.empid)
--ORDER BY mgrfirstname;
ORDER BY M.lastname;
GO

/*
	Answer: Because in the logical processing order, the ORDER BY clause comes after the SELECT clause, and that's why
	the ORDER BY clause is able to recognize the source column name or alias column name.
*/
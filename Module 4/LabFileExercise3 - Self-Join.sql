---------------------------------------------------------------------
-- LAB 04
--
-- Exercise 3
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	In order to better understand the needed tasks, you will first write a SELECT statement agains the HR.Employees table
	showing the empid, lastname, firstname, title, and mgrid columns.
	Execute the written statement and compare the results that you got with the recommended result shown in the file
	72 - Lab Exercise 3 - Task 1 Results.txt. Notice the values in the mgrid column. The mgrid column is in a relationship
	with empid column. This is called a self-referencing relationship.
*/

SELECT empid, lastname, firstname, title, mgrid
FROM HR.Employees

/*
---------------------------------------------------------------------
	>> TASK 2

	Copy the SELECT statement from Task 1 and modify it to include additional columns for the manager information (lastname, firstname)
	using a self-join. Assign the aliases mgrlastname and mgrfistname respectively, to distinguish the manager names from the employee names.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 73 - Lab Exercise 3 -
	Task 2 Results.txt. Notice the number of rows returned.
	It is mandatory to use table aliases when writting a statement with a self-join? Can you use a full source table name as alias? Please explain.
	Why did you get fewer rows in T-SQL statement under Task 2 compared to Task 1?
*/

SELECT E.empid, E.lastname, E.firstname, E.title, E.mgrid, M.lastname AS mgrlastname, M.firstname AS mgrfirstname
FROM HR.Employees AS E
JOIN HR.Employees AS M
	ON E.mgrid = M.empid;
GO

/*
	Answer 1: Yes, it is mandatory.
	Answer 2: No, it's not possible use the full source table, because the names are the same.
	Answer 3: Because the mgrid column contain a row with NULL value, tha won't be shown in the SELECT statement with join.
*/
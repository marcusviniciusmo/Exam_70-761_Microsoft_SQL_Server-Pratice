---------------------------------------------------------------------
-- LAB 16
--
-- Exercise 4
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write T-SQL code to create a synonym named dbo.Person for the Person.Person table in the AdventureWorks2016 database. Execute the written
	statement.
	Write a SELECT statement against the dbo.Person synonym and retrieve the Firstname and Lastname columns. Execute the SELECT statement.
	Observe and compare the results that you got with the recommended result shown in the file 82 - Lab Exercise 4- Task 1 Result.txt.
*/

CREATE SYNONYM dbo.Person 
FOR AdventureWorks2016.Person.Person;
GO

SELECT FirstName, LastName
FROM dbo.Person;
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Execute the provided T-SQL code to remove the synonym.
*/

DROP SYNONYM IF EXISTS dbo.Person;
GO
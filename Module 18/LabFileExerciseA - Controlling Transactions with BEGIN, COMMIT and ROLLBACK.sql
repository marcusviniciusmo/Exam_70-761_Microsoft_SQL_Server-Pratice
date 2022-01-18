---------------------------------------------------------------------
-- LAB 18
--
-- Exercise 1
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	The IT department has provided the following T-SQL code.
	This code inserts two rows into the HR.Employees table. By default, SQL Server treats each individual statement as a transaction. In order
	words, by default, SQL Server automatically commits the transaction at the end of each individual statement. So in this case the default
	behavior would be two transactions since you have two INSERT statements. (Do not worry about the details of the INSERT statements because
	they are only meant to provide sample code for the transaction scenario.)
	In this example, you would like to control the transaction and execute both INSERT statements inside one transaction.
	Before the supplied T-SQL code, write a statement to open a transaction. After the supplied INSERT statements, write a statement to commit
	the transaction. Highligh all of the T-SQL code and execute it.
	Observe and compare the results that you got with the desired results shown in the file 52 - Lab Exercise 1 - Task 1_1 Result.txt.
	Write a SELECT statement to retrieve the empid, lastname, and firstname columns from the HR.Employees table. Order the employees table by the
	empid column in descending order.
	Observe and compare the results that you got with the desired results shown in the file 53 - Lab Exercise 1 - Task 1_2 Result.txt.
*/

-- Solution 1_1

BEGIN TRANSACTION
	INSERT INTO HR.Employees
		(lastname, firstname, title, titleofcourtesy, birthdate, hiredate,
			address, city, region, postalcode, country, phone, mgrid)
	VALUES (
		N'Johnson', N'Test 1', N'Sales Manager', N'Mr.', '19700101', '20110101',
			N'Some Address 18', N'Ljubliana', NULL, N'1000', N'Slovenia', N'(386) 113322', 2);
	INSERT INTO HR.Employees
		(lastname, firstname, title, titleofcourtesy, birthdate, hiredate,
			address, city, region, postalcode, country, phone, mgrid)
	VALUES (
		N'Robertson', N'Test 2', N'Sales Representative', N'Mr.', '19850101', '20110601',
			N'Some Address 22', N'Ljubliana', NULL, N'1000', N'Slovenia', N'(386) 553344', 10);
COMMIT TRANSACTION;
GO

-- Solution 1_2

SELECT
	empid, lastname, firstname
FROM HR.Employees
ORDER BY empid DESC;
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Execute the provided T-SQL code to delete rows inserted from the previous Task.
*/

DELETE HR.Employees
WHERE empid IN (10, 11)
DBCC CHECKIDENT ('HR.Employees', RESEED, 9);

/*
---------------------------------------------------------------------
	>> TASK 3

	The IT department has provided T-SQL code (which happens to the same code as in Task 1). Before the provided T-SQL code, write a statement to
	start a transaction.
	Highlight the written statement and the provided T-SQL code, and execute it.
	Write a SELECT statement to retrieve the empid, lastname, and fistname columns from the HR.Employees table. Order the employees by the empid
	column.
	Execute the written SELECT statement and notice the two new rows in the result set.
	Observe and compare the results that you got with the desired results shown in the file 54 - Lab Exercise 1 - Task 3_1 Result.txt.
	After the written SELECT statement, write a ROLLBACK statement to cancel the transaction. Execute only the ROLLBACK statement.
	Highlight and again execute the written SELECT statement against the HR.Employees table.
	Observe and compare the result that you got with the desired results shown in the file 55 - Lab Exercise 1 - Task 3_2 Result.txt. Notice that
	the two new rows are no longer present in the table.
*/

-- Solution 3_1

BEGIN TRANSACTION
	INSERT INTO HR.Employees
		(lastname, firstname, title, titleofcourtesy, birthdate, hiredate,
			address, city, region, postalcode, country, phone, mgrid)
	VALUES (
		N'Johnson', N'Test 1', N'Sales Manager', N'Mr.', '19700101', '20110101',
			N'Some Address 18', N'Ljubliana', NULL, N'1000', N'Slovenia', N'(386) 113322', 2);
	INSERT INTO HR.Employees
		(lastname, firstname, title, titleofcourtesy, birthdate, hiredate,
			address, city, region, postalcode, country, phone, mgrid)
	VALUES (
		N'Robertson', N'Test 2', N'Sales Representative', N'Mr.', '19850101', '20110601',
			N'Some Address 22', N'Ljubliana', NULL, N'1000', N'Slovenia', N'(386) 553344', 10);

	SELECT
		empid, lastname, firstname
	FROM HR.Employees
	ORDER BY empid DESC;
GO

-- Solution 3_2

ROLLBACK TRANSACTION;
GO

SELECT
	empid, lastname, firstname
FROM HR.Employees
ORDER BY empid DESC;
GO

/*
---------------------------------------------------------------------
	>> TASK 4

	Execute the provided T-SQL code.
*/

DBCC CHECKIDENT ('HR.Employees', RESEED, 9);
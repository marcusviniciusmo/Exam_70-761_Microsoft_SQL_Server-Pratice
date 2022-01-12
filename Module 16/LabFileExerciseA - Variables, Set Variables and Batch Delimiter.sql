---------------------------------------------------------------------
-- LAB 16
--
-- Exercise 1
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a T-SQL code that will create a variable called @num as an int data type. Set the value of the variable to 5 and display the value
	of the variable using the alias mynumber. Execute the T-SQL code.
	Observe and compare the results that you got with the desired results shown in the file 52 - Lab Exercise 1 - Task 1_1 Result.txt.
	Write the batch delimiter GO after the written T-SQL code. In addition, write new T-SQL code that defines two variables, @num1 and @num2,
	both as an int data type. Set the values to 4 and 6, respectively. Write a SELECT statement to retrieve the sum of both variables using
	the alias totalnum. Execute the T-SQL code.
	Observe and compare the results that you got with the desired results shown in the file 53 - Lab Exercise 1 - Task 1_2 Result.txt.
*/

-- Solution 1_1

DECLARE @num INT;
SET @num = 5

SELECT @num AS mynumber;

GO

-- Solution 1_2

DECLARE @num1 INT, @num2 INT;
SET @num1 = 4;
SET @num2 = 6;

SELECT (@num1 + @num2) AS totalnum;

/*
---------------------------------------------------------------------
	>> TASK 2

	Write a T-SQL code that defines the variable @empname as an nvarchar(30) data type.
	Set the value by executing a SELECT statement against the HR.Employees table. Compute a value that concatenates the firstname and lastname
	columns values. Add a space between the two columns values and filter the result to return the employee whose empid value is equal to 1.
	Return the @empname variable's value using the alias employee.
	Execute the T-SQL code.
	Observe and compare the results that you got with the desired results shown in the file 54 - Lab Exercise 1 - Task 2 Result.txt.
	What would happen if the SELECT statement would return more than one row?
*/

DECLARE @empname NVARCHAR(30);

SET @empname = (
	SELECT CONCAT(firstname, N' ', lastname)
	FROM HR.Employees
	WHERE empid = 1);

SELECT @empname AS employee;
GO

/*
	Answer: The SET in variable @empname broke, beacuse the query returned more than 1 value.
*/

/*
---------------------------------------------------------------------
	>> TASK 3

	Copy the T-SQL code from Task 2 and modify it by defining an additional variable named @empid with an int data type. Set the variable's value
	to 5. In the WHERE clause, modify the SELECT statement to use the newly created variable as a value for the column empid.
	Execute the modified T-SQL code.
	Observe and compare the results that you got with the desired results shown in the file 55 - Lab Exercise 1 - Task 3 Result.txt.
	Change the @empid variable's value from 5 to 2 and execute the modified T-SQL code to observe the changes.
*/

DECLARE @empname NVARCHAR(30),
	@empid INT;

SET @empid = 5;

SET @empname = (
	SELECT CONCAT(firstname, N' ', lastname)
	FROM HR.Employees
	WHERE empid = @empid);

SELECT @empname AS employee;
GO

/*
---------------------------------------------------------------------
	>> TASK 4

	Copy the T-SQL code from Task 3 and modify it by adding the batch delimiter GO before the statement:
		SELECT @empname AS employee
	Execute the modified T-SQL code.
	What happended? What is the error message? Can you explain why the batch delimiter caused an error?
*/

DECLARE @empname NVARCHAR(30),
	@empid INT;

SET @empid = 5;

SET @empname = (
	SELECT CONCAT(firstname, N' ', lastname)
	FROM HR.Employees
	WHERE empid = @empid);

GO
SELECT @empname AS employee;

/*
	Answer: The scope of the variable @empname ends in the batch delimiter, therefore is not possible use this variable in the SELECT statement.
*/
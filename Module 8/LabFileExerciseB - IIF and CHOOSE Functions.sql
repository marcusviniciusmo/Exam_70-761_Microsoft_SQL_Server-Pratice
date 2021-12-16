---------------------------------------------------------------------
-- LAB 08
--
-- Exercise 2
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a SELECT statement against the Sales.Customers table and retrieve the custid and contactname columns.	Add a
	calculated column named segmentgroup using a logical function IIF with the value "Target group" for customers
	that are from Mexico and have in the contact title the value "Owner". Use the value "Other" for the rest of the
	customers.
	Execute the written statement and compare the results that you got with the desired results shown in the file
	62 - Lab Exercise 2 - Task 1 Result.txt.
*/

SELECT
	custid, contactname,
	IIF(country = N'Mexico' AND contacttitle = N'Owner', N'Target group', N'Other') AS segmentgroup
FROM Sales.Customers;
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Modify the T-SQL statement from Task 1 to change the calculated column to show the value "Target group"
	for all customers without a missing value in the region attribute or with the value "Owner" in the
	contact tittle attribute.
	Execute the written statement and compare the results that you got with the recommended result shown in
	the file 63 - Lab Exercise 2 - Task 2 Result.txt.
*/

SELECT
	custid, contactname,
	IIF(region IS NOT NULL OR contacttitle = N'Owner', N'Target group', N'Other') AS segmentgroup
FROM Sales.Customers;
GO

/*
---------------------------------------------------------------------
	>> TASK 3

	Write a SELECT statement against the Sales.Customers table and retrieve the custid and contactname columns.
	Add a calculated column named segmentgroup using the logical function CHOOSE with four possible descriptions
	("Group one", "Group two", "Group three", "Group four"). Use the modulo operator on the column custid. (Use
	the expression custid % 4 + 1 to determine the target group).
	Execute the written statement and compare the results that you got with the recommended result shown in the
	file 64 - Lab Exercise 2 - Task 3 Result.txt.
*/

SELECT
	custid, contactname,
	CHOOSE(custid % 4 + 1, N'Group one', N'Group two', N'Group three', N'Group four') AS segmentgroup
FROM Sales.Customers;
GO
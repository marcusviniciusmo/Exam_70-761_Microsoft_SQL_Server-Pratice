---------------------------------------------------------------------
-- LAB 06
--
-- Exercise 4
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a SELECT statement to retrieve the contactname column from the Sales.Customers table.	Based on this column,
	add a calculated column named lastname, which sould consist of all the characters before the comma.
	Execute the written statement and compare the results that you got with the recommended result shown in the file
	82 - Lab Exercise 4 - Task 1 Result.txt.
*/

SELECT
	contactname,
	SUBSTRING(contactname, 0, CHARINDEX(N',', contactname)) AS lastname
FROM Sales.Customers;
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Write a SELECT statement to retrieve the contactname column from the Sales.Customers table and replace the comma
	in the contact name with an empty string. Based on this column, add a calculated column named firstname which should
	consist of all characters after the comma.
	Execute the written statement and compare the results that you got with the recommended result shown in the file
	83 - Lab Exerecise 4 - Task 2 Result.txt.
*/

SELECT
	REPLACE(contactname, N',', N'') as newcontactname,
	SUBSTRING(contactname, CHARINDEX(N',', contactname) + 1, LEN(contactname) - CHARINDEX(',', contactname) + 1) AS firstname
FROM Sales.Customers;
GO

/*
---------------------------------------------------------------------
	>> TASK 3

	Write a SELECT statement to retrieve the custid column from the Sales.Customers table. Add a new calculated column to create
	a string representation of the custid as a fixed-wtdh (6 characters) customer code prefixed with the letter C and leading
	zeros. For example, the custdid value 1 should look like C00001.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 84 - Lab
	Exercise 4 - Task 3 Result.txt.
*/

SELECT
	custid,
	CONCAT(N'C', RIGHT(REPLICATE(N'0', 5) + CAST(custid AS VARCHAR(5)), 5)) AS custnewid
FROM Sales.Customers;
GO

-- Using FORMAT

SELECT
	custid,
	FORMAT(custid, N'\C0000') AS custnewid
FROM Sales.Customers;
GO

/*
---------------------------------------------------------------------
	>> TASK 4

	Write a SELECT statement to retrieve the contactname column from the Sales.Customers table. Add a calculated column,
	which should count the number of occurrences of the character 'a' inside the contact name. (Hint: Use the string
	functions REPLACE and LEN). Order the result from rows with the highest occurrences to lowest.
	Execute the written statement and compare the results that you got with the recommended result shwon in the file
	85 - Lab Exercise 4 - Task 4 Result.txt.
*/

SELECT
	contactname,
	LEN(contactname) - LEN(REPLACE(contactname, N'a', '')) AS numberofa
FROM Sales.Customers
ORDER BY numberofa DESC;
GO
---------------------------------------------------------------------
-- LAB 06
--
-- Exercise 3
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a SELECT statement against the Sales.Customers table and retrieve the contactname and city columns.
	Concatenate both columns so that the new column looks like this:
		Allen, Michael (city: Berlin)
	Execut the written statement and compare the results that you got with the recommended result shown in the file
	72 - Lab Exercise 3 - Task 1 Result.txt.
*/

SELECT
	contactname, city,
	CONCAT(contactname, N' (city: ', city, N')') AS contactwithcity
FROM Sales.Customers;
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Copy the T-SQL statement in Task 1 and modify it to extend the calculated column with new information from the region column.
	Treat a NULL in the region column as an empty string for concatenation purposes. When the region is NULL, the modified column
	should look like this:
		Allen, Michael (city: Berlin, region: )
	When the region is not NULL, the modified column should look like this:
		Richardson, Shawn (city: Sao Paulo, region: SP)
	Execute the written statement and compare the results that you got with the recommended result shown in the file 73 - Lab
	Exercise 3 - Task 2 Result.txt.
*/

SELECT
	contactname, city,
	CONCAT(contactname, N' (city: ', city, N', region: ', region, N')') AS fullcontact
FROM Sales.Customers;
GO

/*
---------------------------------------------------------------------
	>> TASK 3

	Write a SELECT statement to retrieve the contactname and contacttitle columns from the Sales.Customers table.
	Return only rows where the first character in the contact name is 'A' through 'G'.
	Execute the written statement and compare the results that you got with the recommended result shown in the file
	74 - Lab Exercise 3 - Task 3 Result.txt.
*/

SELECT contactname, contacttitle
FROM Sales.Customers
WHERE contactname LIKE N'[A-G]%'
ORDER BY contactname;
GO
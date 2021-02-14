---------------------------------------------------------------------
-- LAB 3

-- Exercise 4
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a SELECT statement to display the categoryid and productname columns
	from the Production.Products table.
*/

SELECT categoryid,
	productname
FROM Production.Products;
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Enhance the SELECT statement in Task 1 by adding a CASE expression
	that generates a result column named categoryname.
	The new column should hold the translation of the category ID
	to its respective category name, based on the mapping table supplied earlier.
	Use the value "Other" for any category IDs not found in mapping table.
*/

SELECT categoryid,
	productname,
	CASE categoryid
		WHEN 1 THEN 'Beverages'
		WHEN 2 THEN 'Condiments'
		WHEN 3 THEN 'Confections'
		WHEN 4 THEN 'Dairy Products'
		WHEN 5 THEN 'Grains/Cereals'
		WHEN 6 THEN 'Meat/Poultry'
		WHEN 7 THEN 'Produce'
		WHEN 8 THEN 'Seafood'
		ELSE 'Others'
	END
FROM Production.Products;
GO

/*
---------------------------------------------------------------------
	>> TASK 3

	Modify the SELECT statement in Task 2 by adding a new column named iscampaign.
	This will show the description "Campaign Products" for the categories Beverages,
	Produce, and Seafood and the description "Non-Campaign Products" for all other categories.
*/

SELECT categoryid,
	productname,
	CASE categoryid
		WHEN 1 THEN 'Beverages'
		WHEN 2 THEN 'Condiments'
		WHEN 3 THEN 'Confections'
		WHEN 4 THEN 'Dairy Products'
		WHEN 5 THEN 'Grains/Cereals'
		WHEN 6 THEN 'Meat/Poultry'
		WHEN 7 THEN 'Produce'
		WHEN 8 THEN 'Seafood'
		ELSE 'Others'
	END AS [Category Name],
	CASE categoryid
		WHEN 1 THEN 'Campaign Products'
		WHEN 7 THEN 'Campaign Products'
		WHEN 8 THEN 'Campaign Products'
		ELSE 'Non-Campaign Products'
	END AS [Campaign Products]
FROM Production.Products;
GO
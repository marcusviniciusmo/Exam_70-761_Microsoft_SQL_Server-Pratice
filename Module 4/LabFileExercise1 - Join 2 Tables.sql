---------------------------------------------------------------------
-- LAB 4

-- Exercise 1
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> Task 1

	Write a SELECT statement that will return the productname column from the Production.Products table	(use table alias "P")
	and the categoryname colum from the Production.Categories table (use table alias "C") using an inner join.
	Execute the written statement and compare the results that you got with the desired results show in the file 52 - Lab Exercise 1 -
	Task 1 Result.txt.
	Which column did you specify as a predicate in the ON clause of the join? Why?
	Let us say there is a new row in the Production.Categories table and this new product category does not have any products
	associated with it in the Production.Products table. Would this row be included in the result of the SELECT statement written in Task 1?
	Please explain.
*/

SELECT P.productname, C.categoryname
FROM Production.Products AS P
INNER JOIN Production.Categories AS C
	ON P.categoryid = C.categoryid;
GO

/*
	Answer 1: I specified the categoryid column, because it is foreign key in Production.Products table
	and primary key in Production.Categories table.
	Answre 2: The new row wouldn't included in the result because in Production.Products table the value of
	categoryid will be null.
*/
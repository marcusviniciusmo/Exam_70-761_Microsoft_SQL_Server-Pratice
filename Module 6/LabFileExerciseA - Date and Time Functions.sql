---------------------------------------------------------------------
-- LAB 06
--
-- Exercise 1
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a SELECT statement to return columns that contain:
	- The current date and time. Use the alias currentdatetime.
	- Just the current date. Use the alias currentdate.
	- Just the current time. Use the alias currenttime.
	- Just the current year. Use the alias currentyear.
	- Just the current month number. Use the alias currentmonth.
	- Just the current day of month number. Use the alias currentday.
	- Just the current week number in the year. Use the alias currentweeknumber.
	- The name of the current month based on the currentdatetime column. Use the alias currentmonthname.
	Execute the written statement and compare the results that you got with the desired results shown in the file
	52 - Lab Exercise 1 - Task 1 Result.txt. Your results will be different because of the current date and time value.
	Can you use the alias currentdatetime as the source in the second column calculation (currentdate)? Please explain.
*/

SELECT
	CURRENT_TIMESTAMP					AS currentdatetime,
	CAST(CURRENT_TIMESTAMP AS date)		AS currentdate,
	CAST(CURRENT_TIMESTAMP AS time)		AS currenttime,
	YEAR(CURRENT_TIMESTAMP)				AS currentyear,
	MONTH(CURRENT_TIMESTAMP)			AS currentmonth,
	DAY(CURRENT_TIMESTAMP)				AS currentday,
	DATEPART(WEEK, CURRENT_TIMESTAMP)	AS currentweeknumber,
	DATENAME(MONTH, CURRENT_TIMESTAMP)	AS currentmonthname

/*
	Answer: No, is not possible, because column aliases are not visible to another expression in the same SELECT clause.
	The reason being T-SQL evaluates all expressions that apear in the same logical query processing phase in an all-at-once manner.
*/

/*
---------------------------------------------------------------------
	>> TASK 2

	Write December 11, 2015, as a column with a data type of date. Use the different possibilities inside the T-SQL language
	(Cast, Convert, Specific function, etc.) and use the alias somedate.
*/

SELECT
	DATEFROMPARTS(2015, 12, 11) AS somedate,
	CAST('20151211' as date) AS somedate,
	CONVERT(DATE, '11/12/2015', 101) AS somedate;

/*
---------------------------------------------------------------------
	>> TASK 3

	Write a SELECT statement to return columns that contain:
	- Three months from the current date and time. Use the alias threemonths.
	- Number of days between the current date and the first column (threemonths). Use the alias diffdays.
	- Number of weeks between April 4, 1992, and September 16, 2011. Use the alias diffweeks.
	- First day in the current month based on the current date and time. Use the alias firstday.
	Execute the written statement and compare the results that you got with the desired results shown in the file
	53 - Lab Exercise 1 - Task 3 Result.txt. Some results will be different because of the current date and time value.
*/

SELECT
	DATEADD(MONTH, 3, CURRENT_TIMESTAMP) AS threemonths,
	DATEDIFF(DAY, CURRENT_TIMESTAMP, DATEADD(MONTH, 3, CURRENT_TIMESTAMP)) AS diffdays,
	DATEDIFF(WEEK, '19920404', '20110916') AS diffweekks,
	DATEADD(DAY, 1, EOMONTH(CURRENT_TIMESTAMP, -1)) AS firstday;

/*
---------------------------------------------------------------------
	>> TASK 4

	The IT Department has written a T-SQL statement that creates and populates a table named Sales.Somedates.
	Execute the provided T-SQL statement.
	Write a SELECT statement against the Sales.Somedates table and retrieve the isitdate column. Add a new column named converteddate
	with a new date data type value base on the column isitdate. If the column isitdate cannot be converted to a date data type for a
	specific row, then return a NULL.
	Execute the written statement and compare the results that you got with the desired results shown in the file 54 - Lab Exercise 1 -
	Task 4 Result.txt.
	What is the difference between the SYSDATETIME and CURRENT_TIMESTAMP functions?
	What is a language-neutral format for the DATE type?
*/

SET NOCOUNT ON;

DROP TABLE IF EXISTS Sales.Somedates;

CREATE TABLE Sales.Somedates(
	isitdate VARCHAR(9)
);

INSERT INTO Sales.Somedates(isitdate) VALUES
	('20110101'),
	('20110102'),
	('20110103X'),
	('20110104'),
	('20110105'),
	('20110106'),
	('20110107Y'),
	('20110108');

SET NOCOUNT OFF;

SELECT isitdate
FROM SALES.Somedates;

-- SOLUTION:

SELECT
	isitdate,
	CASE
		WHEN ISDATE(isitdate) = 1
			THEN CONVERT(DATE, isitdate)
		ELSE NULL
	END AS converteddate
FROM Sales.Somedates;
GO

SELECT SYSDATETIME()
SELECT CURRENT_TIMESTAMP

/*
	Answer 1: The SYSDATETIME function get more precision for date and time than the CURRENT_TIMESTAMP function.
	Answer 2: 'YYYY-MM-DD'
*/

/*
---------------------------------------------------------------------
	>> TASK 5

	Copy-paste text about lab from doc file.
	Drop the table
*/

DROP TABLE Sales.Somedates;
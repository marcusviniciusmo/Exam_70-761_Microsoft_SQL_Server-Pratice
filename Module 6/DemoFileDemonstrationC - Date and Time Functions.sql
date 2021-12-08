-- Demonstration C

-- Step 1: Switch the query window to use your copy of the AdventureWorksLT database.

USE AdventureWorksLT;
GO

-- Step 2: Display various current date and time functions.

SELECT
	GETDATE()			AS [GetDate],
	CURRENT_TIMESTAMP	AS [Current_TimeStamp], -- for ANSII SQL compatibility
	GETUTCDATE()		AS [GetUTCDate],
	SYSDATETIME()		AS [SYSDateTime],
	SYSUTCDATETIME()	AS [SYSUTCDateTime],
	SYSDATETIMEOFFSET() AS [SYSDateTimeOffset];

-- Step 3: Display various functions which return a portion of a date or time.

SELECT DATENAME(WEEKDAY, '20150113');
SELECT DAY('20150113') AS [Day], MONTH('20150113') AS [Month], YEAR('20150113') AS [Year];
SELECT DATEPART(WEEKDAY, '20150113');

-- Step 4: Display various functions which return a date or time from parts.

SELECT DATETIMEFROMPARTS(2012, 2, 12, 8, 30, 0, 0) AS Result; -- 7 arguments
SELECT DATETIME2FROMPARTS(2012, 2, 12, 8, 30, 00, 0, 0) AS Result; -- 8 arguments
SELECT DATEFROMPARTS(2012, 2, 12) AS Result; -- 3 arguments
SELECT DATETIMEOFFSETFROMPARTS(2012, 2, 12, 8, 30, 0, 0, -7, 0, 0) AS Result;

-- Step 5: Demonstrate DATEDIFF with this to show difference in precision.

SELECT DATEDIFF(MILLISECOND, GETDATE(), SYSDATETIME());

-- Step 6: Modify datetime with EOMONTH and DATEADD.

SELECT DATEADD(DAY, 2, '20150113');
SELECT EOMONTH('20150113'); -- return the end of the month in which this date occurs
SELECT EOMONTH('20150113', 2); -- return the end of the month two months ahead of this date

-- Step 7: Use ISDATE to check validity of inputs:

SELECT ISDATE('20150113'); -- is valid
SELECT ISDATE('20120230'); -- February doesn't have 30 days.
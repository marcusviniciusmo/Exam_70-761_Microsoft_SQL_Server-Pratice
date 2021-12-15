-- Demonstration B

-- Step 1: Open a neew query window to the TSQL database.

USE TSQL;
GO

-- Step 2: Select and execute the following query to illustrate the CAST function.
-- This will SUCCEED.

SELECT CAST(SYSDATETIME() AS DATE);
GO

-- Step 3: Select and execute the following query to illustrate the CAST function.
-- This will FAIL.

SELECT CAST(SYSDATETIME() AS INT);
GO

-- Step 4a: Select and execute the following query to illustrate the CONVERT function.
-- This will SUCCEED at converting datetime2 to date.

SELECT CONVERT(DATE, SYSDATETIME());
GO

-- Step 4b: Select and execute the following query to illustrate the CONVERT function.
-- This will FAIL at converting datetime2 to int.

SELECT CONVERT(INT, SYSDATETIME());
GO

-- Step 5: Select and execute the following query to illustrate CONVERT with datetime data and a style option.

SELECT CONVERT(datetime, '20120212', 102) AS ANSI_Style;
GO

SELECT CONVERT(CHAR(8), CURRENT_TIMESTAMP, 112) AS ISO_Style;
GO

-- Step 6: Select and execute the following query to illustrate PARSE converting a string date to a US-Style date.

SELECT PARSE('01/02/2012' AS datetime2 USING 'en-US') AS parse_result;
GO

-- Step 7: Select and execute the following query to illustrate PARSE converting a string date to a UK-Style date.

SELECT PARSE('01/02/2012' AS datetime2 USING 'en-GB') AS parse_result;
GO

-- Step 8a: Select and execute the following query to illustrate TRY_PARSE compared to PARSE.
-- This will FAIL.

SELECT PARSE('SQL Server' AS datetime2 USING 'en-US') AS parse_result;
GO

-- Step 8b: Select and execute the following query to illustrate TRY_PARSE compared to PARSE.
-- This will SUCCEED.

SELECT TRY_PARSE('SQL Server' AS datetime2 USING 'en-US') AS try_parse_result;
GO
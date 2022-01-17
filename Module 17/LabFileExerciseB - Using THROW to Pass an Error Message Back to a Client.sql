---------------------------------------------------------------------
-- LAB 17
--
-- Exercise 2
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Re-throw the existing error back to a client.
*/

DECLARE @num VARCHAR(20) = '0';

BEGIN TRY
	PRINT 5. / CAST(@num AS NUMERIC(10, 4));
END TRY
BEGIN CATCH
	EXECUTE dbo.GetErrorInfo;
	THROW;
END CATCH;
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Add an error handling routine.
*/

DECLARE @num VARCHAR(20) = '0';

BEGIN TRY
	PRINT 5. / CAST(@num AS NUMERIC(10, 4));
END TRY
BEGIN CATCH
	EXECUTE dbo.GetErrorInfo;

	IF ERROR_NUMBER() = 8114
		BEGIN
			PRINT 'Handling division by zero.';
		END
	ELSE
		BEGIN
			PRINT 'Throwing original error.';
			THROW;
		END
END CATCH;
GO

/*
---------------------------------------------------------------------
	>> TASK 3

	Add a different error handling routine.
*/

DECLARE @msg AS VARCHAR(2048);

SET @msg = N'You are doing the exercise for Module 17 on ' +
	FORMAT(CURRENT_TIMESTAMP, 'MMMM d, yyyy', 'en-US') +
	N'. It''s not an error but it means that you are near the final module!';

THROW 50001, @msg, 1;

/*
---------------------------------------------------------------------
	>> TASK 4

	Remove the stored procedure.
*/

IF OBJECT_ID('dbo.GetErrorInfo', 'P') IS NOT NULL
	DROP PROCEDURE dbo.GetErrorInfo;
GO
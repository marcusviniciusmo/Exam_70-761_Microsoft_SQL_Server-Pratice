---------------------------------------------------------------------
-- LAB 17
--
-- Exercise 1
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a Basic TRY/CATCH construct.
*/

BEGIN TRY
	SELECT CAST('Some text' AS INT);
END TRY
BEGIN CATCH
	PRINT 'Error';
END CATCH;
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Display an error number and an error message.
*/

DECLARE @num VARCHAR(20) = '0';
BEGIN TRY
	PRINT 5. / CAST(@num AS NUMERIC(10, 4));
END TRY
BEGIN CATCH
	PRINT 'Error number: ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
	PRINT 'Error message: ' + ERROR_MESSAGE();
END CATCH;
GO

/*
---------------------------------------------------------------------
	>> TASK 3

	Add conditional logic to a CATCH block.
*/

DECLARE @num  VARCHAR(20) = 'A';

BEGIN TRY
	PRINT 5. / CAST(@num AS NUMERIC(10, 4));
END TRY
BEGIN CATCH
	IF ERROR_NUMBER() IN (245, 8114)
		BEGIN
			PRINT 'Handling conversion error...';
		END
	ELSE
		BEGIN
			PRINT 'Handling non-conversion error...';
		END;
	PRINT 'Error number: ' + CAST(ERROR_NUMBER() AS VARCHAR(8));
	PRINT 'Error message: ' + ERROR_MESSAGE();
END CATCH;
GO

/*
---------------------------------------------------------------------
	>> TASK 4

	Execute a stored procedure in the CATCH block.
*/

-- Create Procedure.

CREATE PROCEDURE dbo.GetErrorInfo AS
PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
PRINT 'Error Message: ' + ERROR_MESSAGE();
PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR(10));
PRINT 'Error State: ' + CAST(ERROR_STATE() AS VARCHAR(10));
PRINT 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR(10));
PRINT 'Error Proc: ' + COALESCE(ERROR_PROCEDURE(), 'Not within procedure');
GO

-- TRY / CATCH

DECLARE @num VARCHAR(20) = '0';

BEGIN TRY
	PRINT 5. / CAST(@num AS NUMERIC(10, 4));
END TRY
BEGIN CATCH
	EXECUTE dbo.GetErrorInfo;
END CATCH;
GO
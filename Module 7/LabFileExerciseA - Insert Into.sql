---------------------------------------------------------------------
-- LAB 07
--
-- Exercise 1
---------------------------------------------------------------------

USE tempdb;
GO

-- Step 1: Steup exercise environment.

CREATE SCHEMA Hr;
GO

/*
	Note that there is a much more efficient way, as above, of deleting existing objects in SQL Server 2016.
	However one often needs to get meta data information from the Information_Schema so both methods are
	useful to know about. The alternative method is used in the 99 Cleanup script, which can be used at the
	end of this lab or if you want to restar part way through.
*/

IF EXISTS ( SELECT *
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_NAME = 'Employees'
			AND TABLE_SCHEMA = 'Hr'
			AND TABLE_CATALOG = 'AdventureWorks2016')
			DROP TABLE Hr.Employees
GO

SELECT * INTO Hr.Employees FROM TSQL.HR.Employees;

/*
---------------------------------------------------------------------
	>> TASK 1

	Write an INSERT statement to add a record to the Employees table with the following values:
	• Title: Sales Representative
	• Titleofcourtesy: Mr
	• Firstname: Laurence
	• Lastname: Grider
	• Hiredate: 04/04/2016
	• Birthdate: 10/25/1975
	• Address: 1234 1st Ave. S.E.
	• City: Seatle
	• Country: USA
	• Phone: (206)555-0105
*/

INSERT INTO Hr.Employees
	( Title
	, titleofcourtesy
	, Firstname
	, Lastname
	, hiredate
	, birthdate
	, address
	, city
	, country
	, phone)
OUTPUT Inserted.*
VALUES
	( 'Sales Representative'
	, 'Mr'
	, 'Laurence'
	, 'Grider'
	, '20160404'
	, '19751025'
	, '1234 1st Ave. S.E.'
	, 'Seatle'
	, 'USA'
	, '(206)555-0105');
GO

-- Stetp 2: Clean up

DROP TABLE IF EXISTS HR.Employees;
GO

DROP SCHEMA IF EXISTS Hr;
GO
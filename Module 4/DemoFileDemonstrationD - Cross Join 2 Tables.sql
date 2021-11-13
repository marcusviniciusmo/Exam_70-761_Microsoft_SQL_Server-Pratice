-- Demonstration D

-- Step 1: Open a new query window to the TSQL Database.

USE TSQL;
GO

-- Step 2: Join 2 tables.
/*
	Select and execute the following query
	to display all employees with managers
	and the manager's ID and name.
*/

SELECT E.empid, E.lastname AS empname, E.title, E.mgrid, M.lastname AS mgrname
FROM HR.Employees AS E
JOIN HR.Employees AS M
	ON E.mgrid = M.empid;
GO

-- Stetp 3: Join 2 tables.
/*
	Select and execute the following query
	to display all employees
	and the manager's ID and name.
*/

SELECT E.empid, E.lastname AS empname, e.title, e.mgrid, m.lastname as mgrname
FROM HR.Employees AS E
LEFT OUTER JOIN HR.Employees AS M
	ON E.mgrid = M.empid;
GO

-- Step 4: Cross Join 2 tables.
/*
	Select and execute the following query
	to generate all combinations of first and last
	names from the HR.Employees table.
*/

SELECT E1.firstname, E2.lastname
FROM HR.Employees AS E1
CROSS JOIN HR.Employees AS E2;
GO
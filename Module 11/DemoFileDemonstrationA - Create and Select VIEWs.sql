-- Demonstration A

-- Step 1: Open a new query window to the TSQL database.

USE TSQL;
GO

-- Step 2a: Simple Views. Select and execute the following to create a simple view.

CREATE VIEW HR.EmpPhoneList
AS
SELECT empid, lastname, firstname, phone
FROM HR.Employees;
GO

-- Step 2b: Select from the new view.

SELECT empid, lastname, firstname, phone
FROM HR.EmpPhoneList;
GO

-- Step 3a: Complex Views. Create a view using a multi-table join.

CREATE VIEW Sales.OrdersByEmployeeYear
AS
	SELECT
		EMP.empid AS employee,
		YEAR(ORD.orderdate) AS orderyear,
		SUM(OD.qty * OD.unitprice) AS totalsales
	FROM HR.Employees AS EMP
	INNER JOIN Sales.Orders AS ORD
		ON (ORD.empid = EMP.empid)
	INNER JOIN Sales.OrderDetails AS OD
		ON (OD.orderid = ORD.orderid)
	GROUP BY EMP.empid, YEAR(ORD.orderdate);
GO

-- Step 3b: Select from the view.

SELECT employee, orderyear, totalsales
FROM Sales.OrdersByEmployeeYear
ORDER BY employee, orderyear;
GO

-- Step 4: Clean up

DROP VIEW Sales.OrdersByEmployeeYear;
GO

DROP VIEW HR.EmpPhoneList;
GO
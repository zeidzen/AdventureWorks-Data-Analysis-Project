
USE AdventureWorks2022;

SELECT * FROM Person.Person;
SELECT * FROM Person.CountryRegion;
SELECT * FROM Sales.Customer;
SELECT * FROM Sales.SalesTerritory;
SELECT * FROM Sales.SalesOrderDetail;


/* Q1: What are the regional sales in the best performing country?*/

SELECT PCR.Name as RegionName, SUM(SST.SalesYTD) as SalesYTD, SUM(SST.SalesLastYear) as SalesLY
FROM Sales.SalesTerritory AS SST
INNER JOIN Person.CountryRegion AS PCR
ON SST.CountryRegionCode = PCR.CountryRegionCode
GROUP BY PCR.Name
ORDER BY SalesLY DESC;


SELECT SST.Name as TerritoryName, SST.SalesYTD as SalesYTD, SST.SalesLastYear as SalesLY
FROM Sales.SalesTerritory AS SST
INNER JOIN Person.CountryRegion AS PCR
ON SST.CountryRegionCode = PCR.CountryRegionCode
Where SST.CountryRegionCode='US'
ORDER BY SalesLY DESC;


/* Q2: What is the relationship between annual leave taken and bonus?*/

SELECT * FROM Sales.SalesPerson;
SELECT * FROM HumanResources.Employee HRE;

SELECT HRE.BusinessEntityID, 
		HRE.VacationHours, 
		HRE.SickLeaveHours, 
		HRE.VacationHours + HRE.SickLeaveHours as annual_leave,
		Bonus
FROM HumanResources.Employee HRE
INNER JOIN Sales.SalesPerson SSP ON SSP.BusinessEntityID=HRE.BusinessEntityID
ORDER BY HRE.NationalIDNumber;

/* Q3: What is the relationship between Country and Revenue?*/

SELECT 
    PCR.CountryRegionCode AS CountryRegion,
	PCR.Name as RegionName,
    YEAR(SOH.OrderDate) AS OrderYear,
    COUNT(DISTINCT SOH.SalesOrderID) AS NumberOfOrders,
    COUNT(DISTINCT C.CustomerID) AS NumberOfCustomers,
    ROUND(SUM(SSOD.UnitPrice * SSOD.OrderQty), 0) AS TotalRevenue,
	ROUND(SUM(SSOD.UnitPrice * SSOD.OrderQty) / COUNT(DISTINCT SOH.SalesOrderID), 0) AS AverageOrderValue
FROM 
    Sales.SalesOrderHeader AS SOH
INNER JOIN 
    Sales.SalesOrderDetail AS SSOD ON SOH.SalesOrderID = SSOD.SalesOrderID
INNER JOIN 
    Sales.Customer AS C ON SOH.CustomerID = C.CustomerID
INNER JOIN 
    Person.Address AS A ON C.CustomerID = A.AddressID
INNER JOIN 
    Person.StateProvince AS SP ON A.StateProvinceID = SP.StateProvinceID
INNER JOIN 
    Person.CountryRegion AS PCR ON SP.CountryRegionCode = PCR.CountryRegionCode
GROUP BY 
    PCR.CountryRegionCode, PCR.Name, YEAR(SOH.OrderDate)
ORDER BY 
	 OrderYear, TotalRevenue;

/*Q4: What is the relationship between sick leave and Job Title (PersonType)?*/
SELECT * FROM HumanResources.Employee E;
SELECT * FROM HumanResources.Shift S;
SELECT * FROM HumanResources.EmployeeDepartmentHistory;
SELECT * FROM Person.Person;

SELECT E.BusinessEntityID, E.JobTitle, P.PersonType, E.SickLeaveHours, S.Name as ShiftName
FROM 
	HumanResources.Employee AS E
INNER JOIN 
	Person.Person AS P ON E.BusinessEntityID=P.BusinessEntityID
INNER JOIN 
	HumanResources.EmployeeDepartmentHistory AS EDH ON E.BusinessEntityID=EDH.BusinessEntityID
INNER JOIN 
	HumanResources.Shift AS s ON EDH.ShiftID=S.ShiftID
INNER JOIN 
	HumanResources.Department AS D ON EDH.DepartmentID=D.DepartmentID;

/*Q5: What is the relationship between store trading duration and revenue?*/
SELECT * FROM Sales.Store;
SELECT * FROM Sales.SalesOrderHeader;
SELECT * FROM Production.Product;

SELECT * FROM Sales.vStoreWithDemographics ORDER BY YearOpened;

SELECT * FROM Sales.vSalesPersonSalesByFiscalYears;
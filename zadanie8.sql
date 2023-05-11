--Zadanie 8

--1. Wykorzystuj�c wyra�enie CTE zbuduj zapytanie, kt�re znajdzie informacje na temat stawki
--pracownika oraz jego danych, a nast�pnie zapisze je do tabeli tymczasowej
--TempEmployeeInfo. 

WITH TempEmployeeInfo AS
(
	SELECT FirstName, LastName, Suffix, worker.BusinessEntityID,
		   EmailPromotion, AdditionalContactInfo, Demographics,
		   rowguid, Rate
	FROM   AdventureWorks2019.Person.Person AS worker
	JOIN   AdventureWorks2019.HumanResources.EmployeePayHistory AS salary
	ON     salary.BusinessEntityID = worker.BusinessEntityID
)
SELECT * FROM TempEmployeeInfo;

--2. Uzyskaj informacje na temat przychod�w ze sprzeda�y wed�ug firmy i kontaktu (za pomoc�
--CTE i bazy AdventureWorksL).

WITH Zadanie2 AS
(
		SELECT 
		CONCAT
		(
		CompanyName, ' (', FirstName, ' ',  LastName, ') '
	    ) AS CompanyContact, 
		TotalDue AS Revenue
		FROM AdventureWorksLT2019.SalesLT.Customer as customer
		JOIN AdventureWorksLT2019.SalesLT.SalesOrderHeader as sales
		ON   customer.CustomerID = sales.CustomerID
)
SELECT * FROM Zadanie2;

--3. Napisz zapytanie, kt�re zwr�ci warto�� sprzeda�y dla poszczeg�lnych kategorii produkt�w.

WITH Zadanie3 AS 
(
		SELECT  category.Name AS Category, SUM(detail.LineTotal) AS SalesValue
		FROM AdventureWorksLT2019.SalesLT.Product AS product
		JOIN AdventureWorksLT2019.SalesLT.ProductCategory AS category
		ON   product.ProductCategoryID = category.ProductCategoryID
		JOIN AdventureWorksLT2019.SalesLT.SalesOrderDetail AS detail
		ON   product.ProductID = detail.ProductID 
		GROUP BY category.Name
		
)
SELECT * FROM Zadanie3;





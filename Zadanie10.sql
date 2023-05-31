--Zadanie 10
--Mateusz Mitan
USE AdventureWorks2019;
--1.Napisz zapytanie, które wykorzystuje transakcjê (zaczyna j¹), a nastêpnie
--aktualizuje cenê produktu o ProductID równym 680 w tabeli Production.Product
--o 10% i nastêpnie zatwierdza transakcjê.


BEGIN TRANSACTION;
UPDATE Production.Product
SET ListPrice = ListPrice * 1.1
WHERE ProductID = 680;
COMMIT;

SELECT * FROM Production.Product;


--2.Napisz zapytanie, które zaczyna transakcjê, usuwa produkt o ProductID równym
--707 z tabeli Production.Product, ale nastêpnie wycofuje transakcjê.		

BEGIN TRANSACTION;
DELETE FROM Production.Product
WHERE ProductID = 707;
ROLLBACK;

SELECT * FROM Production.Product;		


--3. Napisz zapytanie, które zaczyna transakcjê, dodaje nowy produkt do tabeli
--Production.Product, a nastêpnie zatwierdza transakcjê.

EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all";
INSERT INTO Production.Product(rowguid)
VALUES(NEWID());

--DELETE Production.Product WHERE ProductID = 5;

BEGIN TRANSACTION
SET IDENTITY_INSERT Production.Product ON;
INSERT INTO Production.Product (ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate)
VALUES (5, 'citroen', 'BX-3942', 0, 0, 1100, 800, 2199.99, 2499.99, 2, '2023-05-30 00:00:00.000');
SET IDENTITY_INSERT Production.Product OFF;
COMMIT

SELECT * FROM Production.Product;		

--4.Napisz zapytanie, które zaczyna transakcjê i aktualizuje StandardCost wszystkich
--produktów w tabeli Production.Product o 10%, je¿eli suma wszystkich
--StandardCost po aktualizacji nie przekracza 50000. W przeciwnym razie zapytanie
--powinno wycofaæ transakcjê.
SELECT * FROM Production.Product;		

BEGIN TRANSACTION
DECLARE @suma DECIMAL(10,2);
SELECT @suma = SUM(StandardCost) FROM Production.Product;	
SET @suma = @suma * 1.1;
IF (@suma <= 500000)
BEGIN
	UPDATE Production.Product
	SET StandardCost = StandardCost * 1.1;
	COMMIT TRANSACTION;
	PRINT 'Suma nie przekracza 50000, aktualizacja jest dalej wykonywana';
END
ELSE
BEGIN
	ROLLBACK TRANSACTION;
	PRINT 'Suma przekroczyla 50000, koniec aktualizacji.';
END

SELECT * FROM Production.Product;	

--5.Napisz zapytanie SQL, które zaczyna transakcjê i próbuje dodaæ nowy produkt do
--tabeli Production.Product. Jeœli ProductNumber ju¿ istnieje w tabeli, zapytanie
--powinno wycofaæ transakcjê.

BEGIN TRANSACTION;
IF EXISTS (SELECT 1 FROM Production.Product WHERE ProductNumber = 'XX-1111')
BEGIN
	SET IDENTITY_INSERT Production.Product ON;
	INSERT INTO Production.Product (ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate)
	VALUES (6, 'Myd³o', 'XX-1111', 0, 0, 1200, 900, 3.49, 2.99, 2, '2023-05-30 00:00:00.000');
	SET IDENTITY_INSERT Production.Product OFF;
END
ELSE
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Taki produkt ju¿ istnieje.';
END

SELECT * FROM Production.Product;	

--6. Napisz zapytanie SQL, które zaczyna transakcjê i aktualizuje wartoœæ OrderQty
--dla ka¿dego zamówienia w tabeli Sales.SalesOrderDetail. Je¿eli którykolwiek z
--zamówieñ ma OrderQty równ¹ 0, zapytanie powinno wycofaæ transakcjê.




BEGIN TRANSACTION;
IF EXISTS (SELECT 1 FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
BEGIN 
	ROLLBACK TRANSACTION;
	PRINT 'OrderQty wynosi 0';
END
ELSE 
BEGIN
	UPDATE Sales.SalesOrderDetail 
	SET OrderQty = OrderQty * 1;
    PRINT 'Aktualizacja zosta³a przeprowadzona!';
END;
		
SELECT * FROM Sales.SalesOrderDetail;


--7. Napisz zapytanie SQL, które zaczyna transakcjê i usuwa wszystkie produkty,
--których StandardCost jest wy¿szy ni¿ œredni koszt wszystkich produktów w tabeli
--Production.Product. Je¿eli liczba produktów do usuniêcia przekracza 10,
--zapytanie powinno wycofaæ transakcjê.


BEGIN TRANSACTION;
DECLARE @srednia DECIMAL(18, 2);
SELECT @srednia = AVG(StandardCost) FROM Production.Product;
DELETE FROM Production.Product
WHERE StandardCost > @srednia;
DECLARE @licznik INT;
SELECT @licznik = COUNT(*) FROM Production.Product;
IF @licznik > 10
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Liczba produktów do usuniêcia przekracza 10.';
END
ELSE
BEGIN
    COMMIT TRANSACTION;
    PRINT 'Usuniêto produkty!';
END	

SELECT * FROM Production.Product;	



















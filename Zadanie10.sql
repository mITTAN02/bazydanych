--Zadanie 10
--Mateusz Mitan
USE AdventureWorks2019;
--1.Napisz zapytanie, kt�re wykorzystuje transakcj� (zaczyna j�), a nast�pnie
--aktualizuje cen� produktu o ProductID r�wnym 680 w tabeli Production.Product
--o 10% i nast�pnie zatwierdza transakcj�.


BEGIN TRANSACTION;
UPDATE Production.Product
SET ListPrice = ListPrice * 1.1
WHERE ProductID = 680;
COMMIT;

SELECT * FROM Production.Product;


--2.Napisz zapytanie, kt�re zaczyna transakcj�, usuwa produkt o ProductID r�wnym
--707 z tabeli Production.Product, ale nast�pnie wycofuje transakcj�.		

BEGIN TRANSACTION;
DELETE FROM Production.Product
WHERE ProductID = 707;
ROLLBACK;

SELECT * FROM Production.Product;		


--3. Napisz zapytanie, kt�re zaczyna transakcj�, dodaje nowy produkt do tabeli
--Production.Product, a nast�pnie zatwierdza transakcj�.

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

--4.Napisz zapytanie, kt�re zaczyna transakcj� i aktualizuje StandardCost wszystkich
--produkt�w w tabeli Production.Product o 10%, je�eli suma wszystkich
--StandardCost po aktualizacji nie przekracza 50000. W przeciwnym razie zapytanie
--powinno wycofa� transakcj�.
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

--5.Napisz zapytanie SQL, kt�re zaczyna transakcj� i pr�buje doda� nowy produkt do
--tabeli Production.Product. Je�li ProductNumber ju� istnieje w tabeli, zapytanie
--powinno wycofa� transakcj�.

BEGIN TRANSACTION;
IF EXISTS (SELECT 1 FROM Production.Product WHERE ProductNumber = 'XX-1111')
BEGIN
	SET IDENTITY_INSERT Production.Product ON;
	INSERT INTO Production.Product (ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate)
	VALUES (6, 'Myd�o', 'XX-1111', 0, 0, 1200, 900, 3.49, 2.99, 2, '2023-05-30 00:00:00.000');
	SET IDENTITY_INSERT Production.Product OFF;
END
ELSE
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Taki produkt ju� istnieje.';
END

SELECT * FROM Production.Product;	

--6. Napisz zapytanie SQL, kt�re zaczyna transakcj� i aktualizuje warto�� OrderQty
--dla ka�dego zam�wienia w tabeli Sales.SalesOrderDetail. Je�eli kt�rykolwiek z
--zam�wie� ma OrderQty r�wn� 0, zapytanie powinno wycofa� transakcj�.




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
    PRINT 'Aktualizacja zosta�a przeprowadzona!';
END;
		
SELECT * FROM Sales.SalesOrderDetail;


--7. Napisz zapytanie SQL, kt�re zaczyna transakcj� i usuwa wszystkie produkty,
--kt�rych StandardCost jest wy�szy ni� �redni koszt wszystkich produkt�w w tabeli
--Production.Product. Je�eli liczba produkt�w do usuni�cia przekracza 10,
--zapytanie powinno wycofa� transakcj�.


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
    PRINT 'Liczba produkt�w do usuni�cia przekracza 10.';
END
ELSE
BEGIN
    COMMIT TRANSACTION;
    PRINT 'Usuni�to produkty!';
END	

SELECT * FROM Production.Product;	



















--Zadanie 7b
--Mateusz Mitan
--411168

--1. Napisz procedurê wypisuj¹c¹ do konsoli ci¹g Fibonacciego.

--napisanie funkcji
CREATE FUNCTION dbo.Ciag_Fibonacciego(@n INT)
RETURNS INT
AS 
BEGIN
	DECLARE @wynik INT
	IF @n = 0
		SET @wynik = @n
	ELSE IF @N = 1 
		SET @wynik = @n
	ELSE 
		SET @wynik = dbo.Ciag_Fibonacciego(@n - 1) + dbo.Ciag_Fibonacciego(@n - 2)
	RETURN @wynik
END;

--wywo³anie procedury
CREATE PROCEDURE fiboProcedura
AS
BEGIN
	DECLARE @n INT
	DECLARE @wynik INT
	SET @n = 17
	SET @wynik = dbo.Ciag_Fibonacciego(@n)
	SELECT @wynik
END;

EXEC fiboProcedura;



--2.Napisz trigger DML, który po wprowadzeniu danych do tabeli Persons zmodyfikuje nazwisko tak, aby by³o napisane du¿ymi literami. 
USE AdventureWorks2019;


CREATE TRIGGER Trigger1
ON Person.Person
AFTER INSERT
AS
BEGIN
   UPDATE Person.Person
   SET LastName = UPPER(LastName)
   FROM Person.Person
END
DROP TRIGGER Trigger1;



EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all";

INSERT INTO Person.Person (BusinessEntityID, PersonType, FirstName, MiddleName, LastName) 
VALUES (20790,'EM','Mateusz','Maksymilian','Mitan');

SELECT * FROM Person.Person WHERE BusinessEntityID = 20790;

SELECT * FROM Person.Person;



--3. Przygotuj trigger ‘taxRateMonitoring’, który wyœwietli komunikat o b³êdzie, je¿eli nast¹pi zmiana wartoœci w polu ‘TaxRate’ o wiêcej ni¿ 30%.

CREATE TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate 
AFTER UPDATE
AS
BEGIN
	DECLARE @stareTaxRate DECIMAL(10, 2) --dziesiec cyfr, 2 miejsca po przecinku
    DECLARE @noweTaxRate DECIMAL(10, 2)

    SELECT @stareTaxRate = TaxRate FROM deleted -- przechowuje kopie przed aktualizacja
    SELECT @noweTaxRate = TaxRate FROM inserted -- przechowuje kopie po aktualizacji

    IF ABS((@noweTaxRate - @stareTaxRate) / @stareTaxRate) > 0.3 
    BEGIN
		RAISERROR ('Zwiekszenie podatku przekracza 30 procent.', 16, 1) --blad powazny ale nie krytyczny dla dzialania serwera
        ROLLBACK
	END
END

UPDATE Sales.SalesTaxRate 
SET TaxRate = 23
WHERE SalesTaxRateID = 1;


SELECT * FROM Sales.SalesTaxRate;









































--
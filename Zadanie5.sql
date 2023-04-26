-- ZAD 4
-- Mateusz Mitan
-- nr albumu: 411168

DROP DATABASE firma;
DROP SCHEMA ksiegowosc;

--1. Utworzenie bazy danych "firma".
CREATE DATABASE firma;

--2. Dodanie schematu o nazwie "rozliczenia".

CREATE SCHEMA ksiegowosc;

--4. Dodanie tabel i wykonanie na nich dzia�a�.

CREATE TABLE ksiegowosc.pracownicy (
	id_pracownika VARCHAR (4) PRIMARY KEY,
	imie NVARCHAR(30) NOT NULL,
	nazwisko NVARCHAR(50) NOT NULL,
	adres NVARCHAR(150) NOT NULL,
	telefon VARCHAR(15) NOT NULL,
);

-- Komentarz do tabeli "Pracownicy"

EXEC sys.sp_addextendedproperty
@name = N'Opis tabeli "pracownicy"',
@value = N'Tabela zawieraj�ca informacje dotycz�ce pracownik�w',
@level0type = N'SCHEMA',
@level0name = 'ksiegowosc',
@level1type = N'TABLE',
@level1name = 'pracownicy';


CREATE TABLE ksiegowosc.godziny (

	id_godziny VARCHAR(5) PRIMARY KEY,
	data DATE NOT NULL,
	liczba_godzin INT NOT NULL,
	id_pracownika Varchar(4) NOT NULL,

);

-- Komentarz do tabeli "Godziny"

EXEC sys.sp_addextendedproperty
@name = N'Opis tabeli "godziny"',
@value = N'Tabela zawieraj�ca liczb� godzin pracy',
@level0type = N'SCHEMA',
@level0name = 'ksiegowosc',
@level1type = N'TABLE',
@level1name = 'godziny';


ALTER TABLE ksiegowosc.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);

CREATE TABLE ksiegowosc.premia(

	id_premii CHAR(4) PRIMARY KEY,
	rodzaj NVARCHAR(50) NULL,
	kwota SMALLMONEY

);

-- Komentarz do tabeli "Premie"

EXEC sys.sp_addextendedproperty
@name = N'Opis tabeli "premie"',
@value = N'Tabela zawieraj�ca informacje dotycz�ce premii',
@level0type = N'SCHEMA',
@level0name = 'ksiegowosc',
@level1type = N'TABLE',
@level1name = 'premia';


CREATE TABLE ksiegowosc.pensja (

	id_pensji CHAR(4) PRIMARY KEY,
	stanowisko NVARCHAR(70) NOT NULL,
	kwota FLOAT NOT NULL,

);

--Komentarz do tabeli "Pensje"

EXEC sys.sp_addextendedproperty
@name = N'Opis tabeli "pensje"',
@value = N'Tabela zawieraj�ca informacje dotycz�ce pensji',
@level0type = N'SCHEMA',
@level0name = 'ksiegowosc',
@level1type = N'TABLE',
@level1name = 'pensja';

CREATE TABLE ksiegowosc.wynagrodzenie (

	id_wynagrodzenia CHAR(5) PRIMARY KEY, 
	data DATE NOT NULL,
	id_pracownika VARCHAR(4),
	id_godziny VARCHAR(5),
	id_pensji CHAR(4), 
	id_premii CHAR(4),

);
-- Komentarz do tabeli "Wynagrodzenie"

EXEC sys.sp_addextendedproperty
@name = N'Opis tabeli "wynagrodzenia"',
@value = N'Tabela zaieraj�ca informacje dotycz�ce wynagrodzenia',
@level0type = N'SCHEMA',
@level0name = 'ksiegowosc',
@level1type = N'TABLE',
@level1name = 'wynagrodzenie';


ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny);
ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji);
ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii);

--5. Wype�nienie tabel 10 rekordami. 

-- pracownicy

INSERT INTO ksiegowosc.pracownicy values('1001', 'Adam', 'Nowak', 'ul. Ksi���t Pomorskich 5, 01-001 Warszawa', '+48123456789');
INSERT INTO ksiegowosc.pracownicy values('1002', 'Anna', 'Kowalska', 'ul. Mickiewicza 10, 30-001 Krak�w', '+48505566778');
INSERT INTO ksiegowosc.pracownicy values('1003', 'Marcin', 'Wi�niewski', 'ul. Konopnickiej 15, 90-001 ��d�', '+48605604321');
INSERT INTO ksiegowosc.pracownicy values('1004', 'Marta', 'W�jcik', 'ul. Pi�sudskiego 20, 50-001 Wroc�aw', '+48703321234');
INSERT INTO ksiegowosc.pracownicy values('1005', 'Piotr', 'Kwiatkowski', 'ul. Mickiewicza 11, 30-002 Krak�w', '+48501005050');
INSERT INTO ksiegowosc.pracownicy values('1006', 'Agata', 'Zielonka', 'ul. Sienkiewicza 25, 70-003 Szczecin', '+48607894321');
INSERT INTO ksiegowosc.pracownicy values('1007', 'Jakub', 'Szyma�ski', 'ul. Ko�ciuszki 30, 80-004 Gda�sk', '+48706660001');
INSERT INTO ksiegowosc.pracownicy values('1008', 'Katarzyna', 'D�browska', 'ul. Nowowiejska 35, 20-005 Lublin', '+48607090909');
INSERT INTO ksiegowosc.pracownicy values('1009', 'Tomasz', 'Lewandowski', 'ul. Grunwaldzka 40, 90-006 ��d�', '+48505855855');
INSERT INTO ksiegowosc.pracownicy values('1010', 'Monika', 'Kaczmarek', 'ul. Sobieskiego 45, 60-007 Pozna�', '+48603330001');

-- godziny

INSERT INTO ksiegowosc.godziny values('00101','2023-04-01', 120, '1001');
INSERT INTO ksiegowosc.godziny values('00102','2023-04-02', 150, '1002');
INSERT INTO ksiegowosc.godziny values('00103','2023-04-03', 170, '1003');
INSERT INTO ksiegowosc.godziny values('00104','2023-04-04', 165, '1004');
INSERT INTO ksiegowosc.godziny values('00105','2023-04-05', 150, '1005');
INSERT INTO ksiegowosc.godziny values('00106','2023-04-06', 130, '1006');
INSERT INTO ksiegowosc.godziny values('00107','2023-04-07', 190, '1007');
INSERT INTO ksiegowosc.godziny values('00108','2023-04-08', 160, '1008');
INSERT INTO ksiegowosc.godziny values('00109','2023-04-09', 180, '1009');
INSERT INTO ksiegowosc.godziny values('00110','2023-04-10', 180, '1010');

-- premia

INSERT INTO ksiegowosc.premia values('001A', 'Premia �wi�teczna', 200);
INSERT INTO ksiegowosc.premia values('002B', 'Premia za wyniki', 300);
INSERT INTO ksiegowosc.premia values('003C', 'Premia za d�ugoletni� prac�', 400);
INSERT INTO ksiegowosc.premia values('004D', 'brak', NULL);
INSERT INTO ksiegowosc.premia values('005E', 'Premia za jako��', 250);
INSERT INTO ksiegowosc.premia values('006F', 'brak', NULL);
INSERT INTO ksiegowosc.premia values('007G', 'Premia �wi�teczna', 400);
INSERT INTO ksiegowosc.premia values('008H', 'Premia na koniec roku', 500);
INSERT INTO ksiegowosc.premia values('009I', 'Premia uznaniowa', 450);
INSERT INTO ksiegowosc.premia values('010J', 'brak', NULL);

--pensje

INSERT INTO ksiegowosc.pensja values('0001', 'Dyrektor', 10000);
INSERT INTO ksiegowosc.pensja values('0002', 'Nauczyciel', 4000);
INSERT INTO ksiegowosc.pensja values('0003', 'Nauczyciel', 4500);
INSERT INTO ksiegowosc.pensja values('0004', 'Nauczyciel', 3500);
INSERT INTO ksiegowosc.pensja values('0005', 'Sekretarz', 4000);
INSERT INTO ksiegowosc.pensja values('0006', 'Piel�gniarz', 3500);
INSERT INTO ksiegowosc.pensja values('0007', 'Nauczyciel', 3500);
INSERT INTO ksiegowosc.pensja values('0008', 'Nauczyciel', 4000);
INSERT INTO ksiegowosc.pensja values('0009', 'Sprz�tacz', 2500);
INSERT INTO ksiegowosc.pensja values('0010', 'Sprz�tacz', 1900);

--wynagrodzenia

INSERT INTO ksiegowosc.wynagrodzenie values('00001', '2023-04-01', '1001', '00101', '0001', '001A');
INSERT INTO ksiegowosc.wynagrodzenie values('00002', '2023-04-08', '1002', '00102', '0002', '002B');
INSERT INTO ksiegowosc.wynagrodzenie values('00003', '2023-04-15', '1003', '00103', '0003', '003C');
INSERT INTO ksiegowosc.wynagrodzenie values('00004', '2023-04-22', '1004', '00104', '0004', '004D');
INSERT INTO ksiegowosc.wynagrodzenie values('00005', '2023-04-29', '1005', '00105', '0005', '005E');
INSERT INTO ksiegowosc.wynagrodzenie values('00006', '2023-05-06', '1006', '00106', '0006', '006F');
INSERT INTO ksiegowosc.wynagrodzenie values('00007', '2023-05-13', '1007', '00107', '0007', '007G');
INSERT INTO ksiegowosc.wynagrodzenie values('00008', '2023-05-20', '1008', '00108', '0008', '008H');
INSERT INTO ksiegowosc.wynagrodzenie values('00009', '2023-05-27', '1009', '00109', '0009', '009I');
INSERT INTO ksiegowosc.wynagrodzenie values('00010', '2023-06-03', '1010', '00110', '0010', '010J');

-- 6. Wykonanie polece�:

--a)  Wy�wietl tylko id pracownika oraz jego nazwisko.
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

--b) Wy�wietl id pracownik�w, kt�rych p�aca jest wi�ksza ni� 1000.

SELECT pracownicy.id_pracownika FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie
ON pracownicy.id_pracownika=wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja
ON wynagrodzenie.id_pensji=pensja.id_pensji
WHERE kwota > 1000;

--c) Wy�wietl id pracownik�w nieposiadaj�cych premii, kt�rych p�aca jest wi�ksza ni� 2000. 

SELECT pracownicy.id_pracownika FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie
ON pracownicy.id_pracownika=wynagrodzenie.id_pracownika
JOIN ksiegowosc.premia
ON wynagrodzenie.id_premii=premia.id_premii
JOIN ksiegowosc.pensja
ON wynagrodzenie.id_pensji=pensja.id_pensji
WHERE premia.kwota IS NULL AND pensja.kwota > 2000;

--d) Wy�wietl pracownik�w, kt�rych pierwsza litera imienia zaczyna si� na liter� �J�. 

SELECT * FROM ksiegowosc.pracownicy WHERE imie LIKE 'J%';

--e) Wy�wietl pracownik�w, kt�rych nazwisko zawiera liter� �n� oraz imi� ko�czy si� na liter� �a�.

SELECT * FROM ksiegowosc.pracownicy WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';

--f) Wy�wietl imi� i nazwisko pracownik�w oraz liczb� ich nadgodzin, przyjmuj�c, i� standardowy czas pracy to 160 h miesi�cznie. 

SELECT pracownicy.imie, pracownicy.nazwisko, godziny.liczba_godzin FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie
ON pracownicy.id_pracownika=wynagrodzenie.id_pracownika
JOIN ksiegowosc.godziny
ON wynagrodzenie.id_godziny=godziny.id_godziny
WHERE liczba_godzin>160;

--g)  Wy�wietl imi� i nazwisko pracownik�w, kt�rych pensja zawiera si� w przedziale 1500 � 3000 PLN.

SELECT pracownicy.imie, pracownicy.nazwisko, pensja.kwota FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie
ON pracownicy.id_pracownika=wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja
ON wynagrodzenie.id_pensji=pensja.id_pensji
WHERE pensja.kwota BETWEEN 1500 AND 3000;

--h) Wy�wietl imi� i nazwisko pracownik�w, kt�rzy pracowali w nadgodzinach i nie otrzymali premii.

SELECT pracownicy.imie, pracownicy.nazwisko, godziny.liczba_godzin, premia.kwota FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie
ON pracownicy.id_pracownika=wynagrodzenie.id_pracownika
JOIN ksiegowosc.godziny
ON wynagrodzenie.id_godziny=godziny.id_godziny
JOIN ksiegowosc.premia
ON wynagrodzenie.id_premii=premia.id_premii
WHERE liczba_godzin>160 AND kwota IS NULL;

--i) Uszereguj pracownik�w wed�ug pensji.

SELECT pracownicy.nazwisko, pensja.kwota FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie
ON pracownicy.id_pracownika=wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja
ON wynagrodzenie.id_pensji=pensja.id_pensji
ORDER BY pensja.kwota DESC;

--j) Uszereguj pracownik�w wed�ug pensji i premii malej�co.

SELECT pracownicy.nazwisko, pensja.kwota, premia.kwota FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie
ON pracownicy.id_pracownika=wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja
ON wynagrodzenie.id_pensji=pensja.id_pensji
JOIN ksiegowosc.premia
ON wynagrodzenie.id_premii=premia.id_premii
ORDER BY pensja.kwota DESC;

--k) Zlicz i pogrupuj pracownik�w wed�ug pola �stanowisko�.

SELECT pensja.stanowisko, COUNT(pensja.stanowisko) FROM ksiegowosc.pensja
GROUP BY stanowisko;

--l) Policz �redni�, minimaln� i maksymaln� p�ac� dla stanowiska �Nauczyciel'.

SELECT AVG(pensja.kwota) AS srednia, MIN(pensja.kwota) AS minimalna, MAX(pensja.kwota) AS maksymalna FROM ksiegowosc.pensja
WHERE stanowisko = 'Nauczyciel';

--m) Policz sum� wszystkich wynagrodze�.

SELECT (SUM(pensja.kwota)+SUM(premia.kwota)) FROM ksiegowosc.premia
JOIN ksiegowosc.wynagrodzenie
ON premia.id_premii=wynagrodzenie.id_premii
JOIN ksiegowosc.pensja 
ON wynagrodzenie.id_pensji=pensja.id_pensji;

--n) Policz sum� wynagrodze� w ramach danego stanowiska.

SELECT pensja.stanowisko, (SUM(pensja.kwota)+SUM(premia.kwota)) FROM ksiegowosc.premia
JOIN ksiegowosc.wynagrodzenie
ON premia.id_premii=wynagrodzenie.id_premii
JOIN ksiegowosc.pensja 
ON wynagrodzenie.id_pensji=pensja.id_pensji
GROUP BY pensja.stanowisko;

--o) Wyznacz liczb� premii przyznanych dla pracownik�w danego stanowiska.

SELECT pensja.stanowisko, COUNT(premia.id_premii) FROM ksiegowosc.premia
JOIN ksiegowosc.wynagrodzenie
ON premia.id_premii = wynagrodzenie.id_premii
JOIN ksiegowosc.pensja 
ON wynagrodzenie.id_pensji = pensja.id_pensji
WHERE premia.kwota IS NOT NULL
GROUP BY pensja.stanowisko;

--p) Usu� wszystkich pracownik�w maj�cych pensj� mniejsz� ni� 1200 z�.

DELETE FROM ksiegowosc.pracownicy 
WHERE id_pracownika IN (
SELECT id_pracownika FROM ksiegowosc.wynagrodzenie 
JOIN ksiegowosc.pensja 
ON wynagrodzenie.id_pensji = pensja.id_pensji 
WHERE kwota < 1200
);







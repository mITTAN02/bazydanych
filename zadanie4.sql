-- ZAD 4
-- Mateusz Mitan
-- nr albumu: 411168

DROP DATABASE firma;
DROP SCHEMA rozliczenia;

--1. Utworzenie bazy danych "firma".
CREATE DATABASE firma;

--2. Dodanie schematu o nazwie "rozliczenia".

CREATE SCHEMA rozliczenia;

--3. Dodanie tabel i wykonanie na nich dzia³añ.

CREATE TABLE rozliczenia.pracownicy (
	id_pracownika VARCHAR (4) PRIMARY KEY,
	imie NVARCHAR(30) NOT NULL,
	nazwisko NVARCHAR(50) NOT NULL,
	adres NVARCHAR(150) NOT NULL,
	telefon VARCHAR(15) NOT NULL,
);

CREATE TABLE rozliczenia.godziny (

	id_godziny VARCHAR(5) PRIMARY KEY,
	data DATE NOT NULL,
	liczba_godzin INT NOT NULL,
	id_pracownika Varchar(4) NOT NULL,

);

ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

CREATE TABLE rozliczenia.premie(

	id_premii CHAR(4) PRIMARY KEY,
	rodzaj NVARCHAR(50) NULL,
	kwota SMALLMONEY NOT NULL,

);

CREATE TABLE rozliczenia.pensje (

	id_pensji CHAR(4) PRIMARY KEY,
	stanowisko NVARCHAR(70) NOT NULL,
	kwota FLOAT NOT NULL,
	id_premii CHAR(4) NOT NULL,

);



ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);

--4. Wype³nienie tabel 10 rekordami. 
-- pracownicy

INSERT INTO rozliczenia.pracownicy values('1001', 'Adam', 'Nowak', 'ul. Ksi¹¿¹t Pomorskich 5, 01-001 Warszawa', '+48123456789');
INSERT INTO rozliczenia.pracownicy values('1002', 'Anna', 'Kowalska', 'ul. Mickiewicza 10, 30-001 Kraków', '+48505566778');
INSERT INTO rozliczenia.pracownicy values('1003', 'Marcin', 'Wiœniewski', 'ul. Konopnickiej 15, 90-001 £ódŸ', '+48605604321');
INSERT INTO rozliczenia.pracownicy values('1004', 'Marta', 'Wójcik', 'ul. Pi³sudskiego 20, 50-001 Wroc³aw', '+48703321234');
INSERT INTO rozliczenia.pracownicy values('1005', 'Piotr', 'Kwiatkowski', 'ul. Mickiewicza 11, 30-002 Kraków', '+48501005050');
INSERT INTO rozliczenia.pracownicy values('1006', 'Agata', 'Zieliñska', 'ul. Sienkiewicza 25, 70-003 Szczecin', '+48607894321');
INSERT INTO rozliczenia.pracownicy values('1007', 'Jakub', 'Szymañski', 'ul. Koœciuszki 30, 80-004 Gdañsk', '+48706660001');
INSERT INTO rozliczenia.pracownicy values('1008', 'Katarzyna', 'D¹browska', 'ul. Nowowiejska 35, 20-005 Lublin', '+48607090909');
INSERT INTO rozliczenia.pracownicy values('1009', 'Tomasz', 'Lewandowski', 'ul. Grunwaldzka 40, 90-006 £ódŸ', '+48505855855');
INSERT INTO rozliczenia.pracownicy values('1010', 'Monika', 'Kaczmarek', 'ul. Sobieskiego 45, 60-007 Poznañ', '+48603330001');

-- godziny

INSERT INTO rozliczenia.godziny values('00101','2023-04-01', 8, '1001');
INSERT INTO rozliczenia.godziny values('00102','2023-04-02', 6, '1002');
INSERT INTO rozliczenia.godziny values('00103','2023-04-03', 8, '1003');
INSERT INTO rozliczenia.godziny values('00104','2023-04-04', 7, '1004');
INSERT INTO rozliczenia.godziny values('00105','2023-04-05', 9, '1005');
INSERT INTO rozliczenia.godziny values('00106','2023-04-06', 8, '1006');
INSERT INTO rozliczenia.godziny values('00107','2023-04-07', 8, '1007');
INSERT INTO rozliczenia.godziny values('00108','2023-04-08', 5, '1008');
INSERT INTO rozliczenia.godziny values('00109','2023-04-09', 9, '1009');
INSERT INTO rozliczenia.godziny values('00110','2023-04-10', 7, '1010');

-- premia

INSERT INTO rozliczenia.premie values('001A', 'Premia œwi¹teczna', 2000);
INSERT INTO rozliczenia.premie values('002B', 'Premia za wyniki', 3000);
INSERT INTO rozliczenia.premie values('003C', 'Premia za d³ugoletni¹ pracê', 4000);
INSERT INTO rozliczenia.premie values('004D', 'Premia motywacyjna', 5000);
INSERT INTO rozliczenia.premie values('005E', 'Premia za jakoœæ', 2500);
INSERT INTO rozliczenia.premie values('006F', 'Premia za osi¹gniêcia', 3500);
INSERT INTO rozliczenia.premie values('007G', 'Premia za dobre wyniki sprzeda¿y', 4000);
INSERT INTO rozliczenia.premie values('008H', 'Premia na koniec roku', 5000);
INSERT INTO rozliczenia.premie values('009I', 'Premia uznaniowa', 4500);
INSERT INTO rozliczenia.premie values('010J', 'Premia za czas spêdzony w pracy', 2000);

--pensje

INSERT INTO rozliczenia.pensje values('001', 'Kierownik', 10000, '001A');
INSERT INTO rozliczenia.pensje values('002', 'Specjalista ds. marketingu', 8000, '002B');
INSERT INTO rozliczenia.pensje values('003', 'Asystent', 4500, '003C');
INSERT INTO rozliczenia.pensje values('004', 'Analityk danych', 9000, '004D');
INSERT INTO rozliczenia.pensje values('005', 'Ksiêgowy', 6500, '005E');
INSERT INTO rozliczenia.pensje values('006', 'Programista', 8500, '006F');
INSERT INTO rozliczenia.pensje values('007', 'Handlowiec', 7500, '007G');
INSERT INTO rozliczenia.pensje values('008', 'Pracownik produkcji', 5000, '008H');
INSERT INTO rozliczenia.pensje values('009', 'Dyrektor sprzeda¿y', 12000, '009I');
INSERT INTO rozliczenia.pensje values('010', 'Kierowca', 4000, '010J');

--5. Wyœwietlenie nazwisk pracowników i ich adresy.

SELECT nazwisko, adres FROM rozliczenia.pracownicy;

--6. Przekonwertowanie daty w tabeli "godziny".

--SET LANGUAGE 'Polish';
SELECT DATEPART ( WEEKDAY, data ) as 'dzieñ', DATEPART( MONTH, data ) as 'miesi¹c' FROM rozliczenia.godziny;

--7. Zmiana atrybutu kwoty w tabeli "pensje".

EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';
ALTER TABLE rozliczenia.pensje
ADD kwota_netto AS (pensje.kwota_brutto * 0.77);
SELECT * FROM rozliczenia.pensje;
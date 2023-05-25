CREATE DATABASE geochron;
CREATE SCHEMA tabstrat;

--1. Stworzenie tabel danych jednostek

CREATE TABLE tabstrat.eon (
    id_eon INT PRIMARY KEY,
    nazwa_eon VARCHAR (30) NOT NULL
);

CREATE TABLE tabstrat.era (
    id_era INT PRIMARY KEY,
    id_eon INT NOT NULL,
    nazwa_era VARCHAR(30) NOT NULL
);

CREATE TABLE tabstrat.okres (
    id_okres INT PRIMARY KEY,
    id_era INT NOT NULL,
    nazwa_okres VARCHAR(30) NOT NULL
);

CREATE TABLE tabstrat.epoka (
    id_epoka INT PRIMARY KEY,
    id_okres INT NOT NULL,
    nazwa_epoka VARCHAR(30) NOT NULL
);

CREATE TABLE tabstrat.pietro (
    id_pietro INT PRIMARY KEY,
    id_epoka  INT NOT NULL,
    nazwa_pietro VARCHAR(30) NOT NULL
);

--2. Tworzenie połączeń między tabelami

ALTER TABLE tabstrat.era ADD FOREIGN KEY (id_eon) REFERENCES tabstrat.eon(id_eon);
ALTER TABLE tabstrat.okres ADD FOREIGN KEY (id_era) REFERENCES tabstrat.era(id_era);
ALTER TABLE tabstrat.epoka ADD FOREIGN KEY (id_okres) REFERENCES tabstrat.okres(id_okres);
ALTER TABLE tabstrat.pietro ADD FOREIGN KEY (id_epoka) REFERENCES tabstrat.epoka(id_epoka);

--3. Uzupełnianie tabel danymi

--a) Eon

INSERT INTO tabstrat.eon VALUES(1, 'Fanerozoik');

--b) Era

INSERT INTO tabstrat.era VALUES(1, 1, 'Paleozoik');
INSERT INTO tabstrat.era VALUES(2, 1, 'Mezozoik');
INSERT INTO tabstrat.era VALUES(3, 1, 'Kenozoik');

--c) Okres

INSERT INTO tabstrat.okres VALUES('1', '1', 'Dewon');
INSERT INTO tabstrat.okres VALUES('2', '1', 'Karbon');
INSERT INTO tabstrat.okres VALUES('3', '1', 'Perm');
INSERT INTO tabstrat.okres VALUES('4', '2', 'Trias');
INSERT INTO tabstrat.okres VALUES('5', '2', 'Jura');
INSERT INTO tabstrat.okres VALUES('6', '2', 'Kreda');
INSERT INTO tabstrat.okres VALUES('7', '3', 'Paleogen');
INSERT INTO tabstrat.okres VALUES('8', '3', 'Neogen');
INSERT INTO tabstrat.okres VALUES('9', '3', 'Czwartorzęd');

--d) Epoka

INSERT INTO tabstrat.epoka VALUES('1', '1', 'Dolny');
INSERT INTO tabstrat.epoka VALUES('2', '1', 'Środkowy');
INSERT INTO tabstrat.epoka VALUES('3', '1', 'Górny');
INSERT INTO tabstrat.epoka VALUES('4', '2', 'Dolny');
INSERT INTO tabstrat.epoka VALUES('5', '2', 'Górny');
INSERT INTO tabstrat.epoka VALUES('6', '3', 'Dolny');
INSERT INTO tabstrat.epoka VALUES('7', '3', 'Górny');
INSERT INTO tabstrat.epoka VALUES('8', '4', 'Dolna');
INSERT INTO tabstrat.epoka VALUES('9', '4', 'Środkowa');
INSERT INTO tabstrat.epoka VALUES('10', '4', 'Górna');
INSERT INTO tabstrat.epoka VALUES('11', '5', 'Dolna');
INSERT INTO tabstrat.epoka VALUES('12', '5', 'Środkowa');
INSERT INTO tabstrat.epoka VALUES('13', '5', 'Górna');
INSERT INTO tabstrat.epoka VALUES('14', '6', 'Dolny');
INSERT INTO tabstrat.epoka VALUES('15', '6', 'Górny');
INSERT INTO tabstrat.epoka VALUES('16', '7', 'Paleocen');
INSERT INTO tabstrat.epoka VALUES('17', '7', 'Eocen');
INSERT INTO tabstrat.epoka VALUES('18', '7', 'Oligocen');
INSERT INTO tabstrat.epoka VALUES('19', '8', 'Mliocen');
INSERT INTO tabstrat.epoka VALUES('20', '8', 'Pliocen');
INSERT INTO tabstrat.epoka VALUES('21', '9', 'Plejstocen');
INSERT INTO tabstrat.epoka VALUES('22', '9', 'Halocen');
-- e) Piętro

INSERT INTO tabstrat.pietro VALUES('1', '1', 'Lochkow');
INSERT INTO tabstrat.pietro VALUES('2', '1', 'Prag');
INSERT INTO tabstrat.pietro VALUES('3', '1', 'Ems');
INSERT INTO tabstrat.pietro VALUES('4', '2', 'Eifel');
INSERT INTO tabstrat.pietro VALUES('5', '2', 'Żywet');
INSERT INTO tabstrat.pietro VALUES('6', '3', 'Fran');
INSERT INTO tabstrat.pietro VALUES('7', '3', 'Famen');
INSERT INTO tabstrat.pietro VALUES('8', '4', 'Turnej');
INSERT INTO tabstrat.pietro VALUES('9', '4', 'Wizen');
INSERT INTO tabstrat.pietro VALUES('10', '4', 'Serpuchow');
INSERT INTO tabstrat.pietro VALUES('11', '5', 'Baszkir');
INSERT INTO tabstrat.pietro VALUES('12', '5', 'Moskow');
INSERT INTO tabstrat.pietro VALUES('13', '5', 'Kasimow');
INSERT INTO tabstrat.pietro VALUES('14', '5', 'Gżel');
INSERT INTO tabstrat.pietro VALUES('15', '6', 'Assel');
INSERT INTO tabstrat.pietro VALUES('16', '6', 'Sakmar');
INSERT INTO tabstrat.pietro VALUES('17', '6', 'Artinsk');
INSERT INTO tabstrat.pietro VALUES('18', '6', 'Kungur');
INSERT INTO tabstrat.pietro VALUES('19', '7', 'Wucziaping');
INSERT INTO tabstrat.pietro VALUES('20', '7', 'Czangsing');
INSERT INTO tabstrat.pietro VALUES('21', '8', 'Ind');
INSERT INTO tabstrat.pietro VALUES('22', '8', 'Olenek');
INSERT INTO tabstrat.pietro VALUES('23', '9', 'Anizyk');
INSERT INTO tabstrat.pietro VALUES('24', '9', 'Ladyn');
INSERT INTO tabstrat.pietro VALUES('25', '10', 'Karnik');
INSERT INTO tabstrat.pietro VALUES('26', '10', 'Noryk');
INSERT INTO tabstrat.pietro VALUES('27', '10', 'Retyk');
INSERT INTO tabstrat.pietro VALUES('28', '11', 'Hettang');
INSERT INTO tabstrat.pietro VALUES('29', '11', 'Synemur');
INSERT INTO tabstrat.pietro VALUES('30', '11', 'Pliensbach');
INSERT INTO tabstrat.pietro VALUES('31', '11', 'Toark');
INSERT INTO tabstrat.pietro VALUES('32', '12', 'Aalen');
INSERT INTO tabstrat.pietro VALUES('33', '12', 'Bajos');
INSERT INTO tabstrat.pietro VALUES('34', '12', 'Baton');
INSERT INTO tabstrat.pietro VALUES('35', '12', 'Kelowej');
INSERT INTO tabstrat.pietro VALUES('36', '13', 'Oksford');
INSERT INTO tabstrat.pietro VALUES('37', '13', 'Kimeryd');
INSERT INTO tabstrat.pietro VALUES('38', '13', 'Tyton');
INSERT INTO tabstrat.pietro VALUES('39', '14', 'Berrias');
INSERT INTO tabstrat.pietro VALUES('40', '14', 'Walanżyn');
INSERT INTO tabstrat.pietro VALUES('41', '14', 'Hoteryw');
INSERT INTO tabstrat.pietro VALUES('42', '14', 'Barrem');
INSERT INTO tabstrat.pietro VALUES('43', '14', 'Apt');
INSERT INTO tabstrat.pietro VALUES('44', '14', 'Alb');
INSERT INTO tabstrat.pietro VALUES('45', '15', 'Cenoman');
INSERT INTO tabstrat.pietro VALUES('46', '15', 'Turon');
INSERT INTO tabstrat.pietro VALUES('47', '15', 'Koniak');
INSERT INTO tabstrat.pietro VALUES('48', '15', 'Santon');
INSERT INTO tabstrat.pietro VALUES('49', '15', 'Kampan');
INSERT INTO tabstrat.pietro VALUES('50', '15', 'Mastrycht');
INSERT INTO tabstrat.pietro VALUES('51', '16', 'Dan');
INSERT INTO tabstrat.pietro VALUES('52', '16', 'Zeland');
INSERT INTO tabstrat.pietro VALUES('53', '16', 'Tanet');
INSERT INTO tabstrat.pietro VALUES('54', '17', 'Iprez');
INSERT INTO tabstrat.pietro VALUES('55', '17', 'Lutet');
INSERT INTO tabstrat.pietro VALUES('56', '17', 'Barton');
INSERT INTO tabstrat.pietro VALUES('57', '17', 'Priabon');
INSERT INTO tabstrat.pietro VALUES('58', '18', 'Rupel');
INSERT INTO tabstrat.pietro VALUES('59', '18', 'Szat');
INSERT INTO tabstrat.pietro VALUES('60', '19', 'Akwitan');
INSERT INTO tabstrat.pietro VALUES('61', '19', 'Burdygał');
INSERT INTO tabstrat.pietro VALUES('62', '19', 'Lang');
INSERT INTO tabstrat.pietro VALUES('63', '19', 'Serrawal');
INSERT INTO tabstrat.pietro VALUES('64', '19', 'Torton');
INSERT INTO tabstrat.pietro VALUES('65', '19', 'Messyn');
INSERT INTO tabstrat.pietro VALUES('66', '20', 'Zankl');
INSERT INTO tabstrat.pietro VALUES('67', '20', 'Piacent');
INSERT INTO tabstrat.pietro VALUES('68', '21', 'Gelas');
INSERT INTO tabstrat.pietro VALUES('69', '21', 'Kalabr');
INSERT INTO tabstrat.pietro VALUES('70', '21', 'Chiban');
INSERT INTO tabstrat.pietro VALUES('71', '21', 'Późny');
INSERT INTO tabstrat.pietro VALUES('72', '22', 'Grenland');
INSERT INTO tabstrat.pietro VALUES('73', '22', 'Northgrip');
INSERT INTO tabstrat.pietro VALUES('74', '22', 'Megalaj');

--4.Utworzenie zdenormalizowanej tabeli

SELECT tabstrat.pietro.id_pietro,
       tabstrat.pietro.nazwa_pietro,
       tabstrat.epoka.id_epoka,
       tabstrat.epoka.nazwa_epoka,
       tabstrat.okres.id_okres,
       tabstrat.okres.nazwa_okres,
       tabstrat.era.id_era,
       tabstrat.era.nazwa_era,
       tabstrat.eon.id_eon,
       tabstrat.eon.nazwa_eon
INTO tabstrat.tabela_glowna FROM tabstrat.pietro
JOIN tabstrat.epoka ON tabstrat.epoka.id_epoka = tabstrat.pietro.id_epoka
JOIN tabstrat.okres ON tabstrat.okres.id_okres = tabstrat.epoka.id_okres
JOIN tabstrat.era ON tabstrat.era.id_era = tabstrat.okres.id_era
JOIN tabstrat.eon ON tabstrat.eon.id_eon = tabstrat.era.id_eon;

ALTER TABLE tabstrat.tabela_glowna ADD PRIMARY KEY (id_pietro);

--5. Utworzenie tabel zawierające syntetyczne dane - liczby od 0 do 999999

CREATE TABLE tabstrat.dziesiec (
    liczbaD INT NOT NULL PRIMARY KEY
);
INSERT INTO tabstrat.dziesiec VALUES(0);
INSERT INTO tabstrat.dziesiec VALUES(1);
INSERT INTO tabstrat.dziesiec VALUES(2);
INSERT INTO tabstrat.dziesiec VALUES(3);
INSERT INTO tabstrat.dziesiec VALUES(4);
INSERT INTO tabstrat.dziesiec VALUES(5);
INSERT INTO tabstrat.dziesiec VALUES(6);
INSERT INTO tabstrat.dziesiec VALUES(7);
INSERT INTO tabstrat.dziesiec VALUES(8);
INSERT INTO tabstrat.dziesiec VALUES(9);

SELECT a1.liczbaD+10*a2.liczbaD+100*a3.liczbaD+1000*a4.liczbaD+10000*a5.liczbaD+100000*a6.liczbaD AS liczbaM
INTO tabstrat.milion
FROM tabstrat.dziesiec a1, tabstrat.dziesiec a2, tabstrat.dziesiec a3, tabstrat.dziesiec a4, tabstrat.dziesiec a5, tabstrat.dziesiec a6;

SELECT * FROM tabstrat.milion
ORDER BY tabstrat.milion.liczbaM;


--6.) Utworzenie indeksów

CREATE INDEX INDEX_id_eon ON tabstrat.eon(id_eon);
CREATE INDEX INDEX_id_era ON tabstrat.era(id_era);
CREATE INDEX INDEX_id_okres ON tabstrat.okres(id_okres);
CREATE INDEX INDEX_id_epoka ON tabstrat.epoka(id_epoka);
CREATE INDEX INDEX_id_pietro ON tabstrat.pietro(id_pietro);
CREATE INDEX INDEX_liczbaD ON tabstrat.dziesiec(liczbaD);
CREATE INDEX INDEX_liczbaM ON tabstrat.milion(liczbaM);
CREATE INDEX INDEX_id_pietroTG ON tabstrat.tabela_glowna(id_pietro);

--7.) Aktywowanie zapytań

--Zapytanie pierwsze

SELECT COUNT(*) FROM tabstrat.milion
INNER JOIN tabstrat.tabela_glowna
ON (mod(milion.liczbaM,68)=(tabela_glowna.id_pietro));

--Zapytanie drugie

SELECT COUNT(*) FROM tabstrat.milion INNER JOIN tabstrat.pietro ON
(mod(milion.liczbaM,68)=tabstrat.pietro.id_pietro) NATURAL JOIN tabstrat.epoka NATURAL JOIN
tabstrat.okres NATURAL JOIN tabstrat.era NATURAL JOIN tabstrat.eon;

--Zapytanie trzecie

SELECT COUNT(*) FROM tabstrat.milion WHERE mod(milion.liczbaM,68)=
(SELECT id_pietro FROM tabstrat.tabela_glowna WHERE mod(milion.liczbaM,68)=(id_pietro));

--Zapytanie czwarte

SELECT COUNT(*) FROM tabstrat.milion WHERE mod(milion.liczbaM,68) IN
(SELECT tabstrat.pietro.id_pietro FROM tabstrat.pietro NATURAL JOIN tabstrat.epoka NATURAL JOIN
tabstrat.okres NATURAL JOIN tabstrat.era NATURAL JOIN tabstrat.eon);
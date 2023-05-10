--Zad 6b

--a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj¹c do niego kierunkowy dla Polski w nawiasie (+48)

ALTER TABLE ksiegowosc.pracownicy
ALTER COLUMN telefon varchar(25)
UPDATE ksiegowosc.pracownicy 
SET telefon = CONCAT('+48', telefon)
SELECT telefon FROM ksiegowosc.pracownicy;

--b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony by³ myœlnikami wg wzoru: '555-222-333'
SELECT telefon FROM ksiegowosc.pracownicy;
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT( SUBSTRING(telefon, 1, 3), ' ',
					  SUBSTRING(telefon, 3, 3), '-',
					  SUBSTRING(telefon, 6, 3), '-',
					  SUBSTRING(telefon, 9, 3))
SELECT telefon FROM ksiegowosc.pracownicy;

--c) Wyœwietl dane pracownika, którego nazwisko jest najd³u¿sze, u¿ywaj¹c du¿ych liter

SELECT UPPER(id_pracownika) AS id, UPPER(nazwisko) AS nazwisko, UPPER(imie) AS imie, UPPER(adres) AS adres, UPPER(telefon) AS telefon
FROM ksiegowosc.pracownicy
WHERE LEN(nazwisko) = (SELECT MAX(LEN(nazwisko)) FROM ksiegowosc.pracownicy);

--d) Wyœwietl dane pracowników i ich pensje zakodowane przy pomocy algorytmu md5


SELECT HASHBYTES('MD5', pracownicy.id_pracownika) AS id,
	   HASHBYTES('MD5', nazwisko) AS nazwisko,
	   HASHBYTES('MD5', imie) AS imie,
	   HASHBYTES('MD5', adres) AS adres, 
	   HASHBYTES('MD5', telefon) AS telefon,
	   HASHBYTES('MD5', CAST(kwota AS VARCHAR(30))) AS kwota
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie
ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja
ON wynagrodzenie.id_pensji = pensja.id_pensji;

--e) Wyœwietl pracowników, ich pensje oraz premie. Wykorzystaj z³¹czenie lewostronne

SELECT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko, pensja.kwota, premia.kwota FROM ksiegowosc.pracownicy
LEFT OUTER JOIN ksiegowosc.wynagrodzenie
ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
LEFT OUTER JOIN ksiegowosc.pensja
ON wynagrodzenie.id_pensji = pensja.id_pensji
LEFT OUTER JOIN ksiegowosc.premia
ON wynagrodzenie.id_premii = premia.id_premii;

--f) Wygeneruj raport (zapytanie), które zwróci w wyniki treœæ wg szablonu.

SELECT CONCAT
('Pracownik', ' ', pracownicy.imie, ' ', pracownicy.nazwisko, ', w dniu ',
DATEPART(day, godziny.data), '.', '0', DATEPART(month, godziny.data), '.', DATEPART(year, godziny.data),
' otrzyma³ pensjê ca³kowit¹ na kwotê ', (pensja.kwota+premia.kwota+ 
CASE 
	WHEN godziny.liczba_godzin <= 160 THEN 0
	ELSE (godziny.liczba_godzin - 160)*20
END),
', gdzie wynagrodzenie zasadnicze wynosi³o: ',pensja.kwota,
', premia: ',
CASE 
	WHEN premia.kwota = 0 THEN 0
	ELSE premia.kwota 
END, 
', nadgodziny: ',
CASE
	WHEN godziny.liczba_godzin <= 160 THEN 0
	ELSE (godziny.liczba_godzin - 160)*20
END
)

FROM ksiegowosc.pracownicy 
JOIN ksiegowosc.wynagrodzenie 
ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.godziny
ON wynagrodzenie.id_godziny = godziny.id_godziny
JOIN ksiegowosc.pensja
ON wynagrodzenie.id_pensji = pensja.id_pensji
JOIN ksiegowosc.premia 
ON wynagrodzenie.id_premii = premia.id_premii;
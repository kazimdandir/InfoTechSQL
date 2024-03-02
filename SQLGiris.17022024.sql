--DML (DATA MANUPILATION LANGUAGE)
	--SELECT (SE�MEK)
	--INSERT (EKLEME)
	--UPDATE (G�NCELLEME)
	--DELETE (S�LME)

--InfoTechDB'yi databasesini �a��r�r
USE InfoTechDB 


--SELECT

--Musteriler tablosunun t�m kolonlar� getirir
SELECT * FROM Musteriler 

--Musteriler tablosundaki sehir='Bursa' ve cinsiyet='Erkek' olan kolonlar� getirir
SELECT ad,soyad,sehir FROM Musteriler WHERE sehir = 'Bursa' AND cinsiyet = 'Erkek'

--Musteriler tablosundaki sehir='Bursa' ya da cinsiyet='Erkek' olan kolonlar� getirir
SELECT ad,soyad,sehir FROM Musteriler WHERE sehir = 'Bursa' OR cinsiyet = 'Erkek'

--ALIAS (kolon isimlendirme)
SELECT ad AS ADI, 
soyad AS SOYADI, 
sehir AS DOGUMYER� 
FROM Musteriler

--ALIAS (kolon isimlendirme (AS yazmadan ama okunakl�rl��� azalt�r))
SELECT ad ADI, 
soyad SOYADI, 
sehir [DOGUM YER�] --k��eli parantaze alarak bo�luklu isimlendirebiliriz
FROM musteriler --sql b�y�k k���k harf duyarl�d�r 

--Puan� 50den b�y�k erkek m��teriler
SELECT * FROM Musteriler WHERE puan > 50 AND cinsiyet = 'ERKEK' --'' i�erisinde de b�y�k k���k harf duyarl�d�r

--Bursa ve Ankara'da ya�ayanlar
SELECT * FROM Musteriler WHERE sehir = 'Bursa' OR sehir = 'Ankara'
SELECT * FROM Musteriler WHERE sehir IN ('Bursa','Ankara') --IN ile Farkl� yaz�m� 

--Puan� 50-100 aras� olanlar
SELECT * FROM Musteriler
WHERE puan > 50 AND puan < 100
--YA DA 
SELECT * FROM Musteriler
WHERE puan BETWEEN 50 AND 100

--Geliri 20000-30000 aras� olan ve puan� 50'den b�y�k olan ad, soyad, gelir, puan, cinsiyet
SELECT ad AS ADI, soyad AS SOYADI, gelir AS MAA�, puan AS PUANI, cinsiyet AS C�NS�YET�
FROM Musteriler
WHERE gelir BETWEEN 20000 AND 30000 
AND puan > 50

--��erisinde Al ge�en isimler
SELECT * FROM Musteriler WHERE ad LIKE '%Al%'

--Al ile ba�layan isimler
SELECT * FROM Musteriler WHERE ad LIKE 'Al%'

--Al ile biten isimler
SELECT * FROM Musteriler WHERE ad LIKE '%Al'

--A ba�layan isimler
SELECT * FROM Musteriler WHERE ad LIKE 'A%'

--6 karakterli isimleri getir
SELECT * FROM Musteriler WHERE ad LIKE '______'

--�lk harfi T, 6. harfi R olan isimleri getir
SELECT * FROM Musteriler WHERE ad LIKE 'T____r'

--Soyad� Z ile biten, maa�� 10000 ile 50000 aras� olan, kad�n m��teriler
SELECT * FROM Musteriler
WHERE soyad LIKE '%z'
AND gelir BETWEEN 10000 AND 90000
AND cinsiyet = 'Kadin' 

--puan� b�y�kten k����e s�rala
SELECT * FROM Musteriler
ORDER BY puan DESC

--adlar� k���kten b�y��e s�rala a-z
SELECT * FROM Musteriler
ORDER BY ad ASC --(ASC yazmasakta olur default)


--INSERT

INSERT INTO Musteriler(musteriNo, ad, soyad, dTarih, sehir, cinsiyet, puan, meslek, gelir)
VALUES (4,'Osman', 'Y�ld�z', '01-01-2000', 'Kars', 'Erkek', 55, 'Muhasebeci', 17002)

SELECT * FROM Musteriler


--UPDATE

--musteriNo 1 olan�n puan�n� 99 yap
--UPDATE Musteriler SET puan=99 --herkesin puan�n� 99 yapar 
UPDATE Musteriler SET puan=99 WHERE musteriNo = 1 

SELECT * FROM Musteriler

--�ehri bursa olanlar� burdur yap ve puan�n� 55 yap
UPDATE Musteriler SET sehir='Burdur', puan=55 
WHERE sehir='Bursa'

SELECT * FROM Musteriler

--Maa�� 15000-30000 olanlar� 40000 yap
UPDATE Musteriler SET gelir = 40000 
WHERE gelir BETWEEN 15000 AND 30000

SELECT * FROM Musteriler


--DELETE 

--M��teri numaras� 4 olan� sil
--DELETE FROM Musteriler --Hepsini siler
DELETE FROM Musteriler
WHERE musteriNo = 4

--Tekrar ekleyelim
INSERT INTO Musteriler(musteriNo, ad, soyad, dTarih, sehir, cinsiyet, puan, meslek, gelir)
VALUES (4,'Osman', 'Y�ld�z', '01-01-2000', 'Kars', 'Erkek', 55, 'Muhasebeci', 17002)

SELECT * FROM Musteriler

SELECT TOP 2 * FROM Musteriler --En �stteki 2 kayd� getirir

--en y�ksek maa� alan� getir
SELECT TOP 1 * FROM Musteriler
ORDER BY gelir DESC

--ilk %60 kayd� getir
SELECT TOP 60 PERCENT * FROM Musteriler


--HAZIR FONKS�YONLAR (Aggregate Functions)

--SUM
SELECT SUM(gelir) FROM Musteriler

--MAX
SELECT MAX(gelir) FROM Musteriler

--MIN
SELECT MIN(gelir) FROM Musteriler

--AVG
SELECT AVG(gelir) FROM Musteriler

--Geliri ortalama gelirden b�y�k olan erkek m��teriler
SELECT * FROM Musteriler 
WHERE gelir > (SELECT AVG(gelir) FROM Musteriler)
AND cinsiyet = 'Erkek'

SELECT * FROM Musteriler 
WHERE gelir > (SELECT AVG(gelir) FROM Musteriler WHERE cinsiyet = 'Erkek')

--isim soyisim getir ve b�y�k harfle getir
SELECT UPPER(ad) AS �S�M,
UPPER(soyad) AS SOY�S�M 
FROM Musteriler

--Cinsiyet say�s�n� getir
SELECT cinsiyet,COUNT(cinsiyet) 
FROM Musteriler 
GROUP BY cinsiyet

--�ehir say�s�
SELECT sehir, COUNT(sehir) AS say�
FROM Musteriler
GROUP BY sehir
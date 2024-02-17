--DML (DATA MANUPILATION LANGUAGE)
	--SELECT (SEÇMEK)
	--INSERT (EKLEME)
	--UPDATE (GÜNCELLEME)
	--DELETE (SÝLME)

--InfoTechDB'yi databasesini çaðýrýr
USE InfoTechDB 


--SELECT

--Musteriler tablosunun tüm kolonlarý getirir
SELECT * FROM Musteriler 

--Musteriler tablosundaki sehir='Bursa' ve cinsiyet='Erkek' olan kolonlarý getirir
SELECT ad,soyad,sehir FROM Musteriler WHERE sehir = 'Bursa' AND cinsiyet = 'Erkek'

--Musteriler tablosundaki sehir='Bursa' ya da cinsiyet='Erkek' olan kolonlarý getirir
SELECT ad,soyad,sehir FROM Musteriler WHERE sehir = 'Bursa' OR cinsiyet = 'Erkek'

--ALIAS (kolon isimlendirme)
SELECT ad AS ADI, 
soyad AS SOYADI, 
sehir AS DOGUMYERÝ 
FROM Musteriler

--ALIAS (kolon isimlendirme (AS yazmadan ama okunaklýrlýðý azaltýr))
SELECT ad ADI, 
soyad SOYADI, 
sehir [DOGUM YERÝ] --köþeli parantaze alarak boþluklu isimlendirebiliriz
FROM musteriler --sql büyük küçük harf duyarlýdýr 

--Puaný 50den büyük erkek müþteriler
SELECT * FROM Musteriler WHERE puan > 50 AND cinsiyet = 'ERKEK' --'' içerisinde de büyük küçük harf duyarlýdýr

--Bursa ve Ankara'da yaþayanlar
SELECT * FROM Musteriler WHERE sehir = 'Bursa' OR sehir = 'Ankara'
SELECT * FROM Musteriler WHERE sehir IN ('Bursa','Ankara') --IN ile Farklý yazýmý 

--Puaný 50-100 arasý olanlar
SELECT * FROM Musteriler
WHERE puan > 50 AND puan < 100
--YA DA 
SELECT * FROM Musteriler
WHERE puan BETWEEN 50 AND 100

--Geliri 20000-30000 arasý olan ve puaný 50'den büyük olan ad, soyad, gelir, puan, cinsiyet
SELECT ad AS ADI, soyad AS SOYADI, gelir AS MAAÞ, puan AS PUANI, cinsiyet AS CÝNSÝYETÝ
FROM Musteriler
WHERE gelir BETWEEN 20000 AND 30000 
AND puan > 50

--Ýçerisinde Al geçen isimler
SELECT * FROM Musteriler WHERE ad LIKE '%Al%'

--Al ile baþlayan isimler
SELECT * FROM Musteriler WHERE ad LIKE 'Al%'

--Al ile biten isimler
SELECT * FROM Musteriler WHERE ad LIKE '%Al'

--A baþlayan isimler
SELECT * FROM Musteriler WHERE ad LIKE 'A%'

--6 karakterli isimleri getir
SELECT * FROM Musteriler WHERE ad LIKE '______'

--Ýlk harfi T, 6. harfi R olan isimleri getir
SELECT * FROM Musteriler WHERE ad LIKE 'T____r'

--Soyadý Z ile biten, maaþý 10000 ile 50000 arasý olan, kadýn müþteriler
SELECT * FROM Musteriler
WHERE soyad LIKE '%z'
AND gelir BETWEEN 10000 AND 90000
AND cinsiyet = 'Kadin' 

--puaný büyükten küçüðe sýrala
SELECT * FROM Musteriler
ORDER BY puan DESC

--adlarý küçükten büyüðe sýrala a-z
SELECT * FROM Musteriler
ORDER BY ad ASC --(ASC yazmasakta olur default)


--INSERT

INSERT INTO Musteriler(musteriNo, ad, soyad, dTarih, sehir, cinsiyet, puan, meslek, gelir)
VALUES (4,'Osman', 'Yýldýz', '01-01-2000', 'Kars', 'Erkek', 55, 'Muhasebeci', 17002)

SELECT * FROM Musteriler


--UPDATE

--musteriNo 1 olanýn puanýný 99 yap
--UPDATE Musteriler SET puan=99 --herkesin puanýný 99 yapar 
UPDATE Musteriler SET puan=99 WHERE musteriNo = 1 

SELECT * FROM Musteriler

--Þehri bursa olanlarý burdur yap ve puanýný 55 yap
UPDATE Musteriler SET sehir='Burdur', puan=55 
WHERE sehir='Bursa'

SELECT * FROM Musteriler

--Maaþý 15000-30000 olanlarý 40000 yap
UPDATE Musteriler SET gelir = 40000 
WHERE gelir BETWEEN 15000 AND 30000

SELECT * FROM Musteriler


--DELETE 

--Müþteri numarasý 4 olaný sil
--DELETE FROM Musteriler --Hepsini siler
DELETE FROM Musteriler
WHERE musteriNo = 4

--Tekrar ekleyelim
INSERT INTO Musteriler(musteriNo, ad, soyad, dTarih, sehir, cinsiyet, puan, meslek, gelir)
VALUES (4,'Osman', 'Yýldýz', '01-01-2000', 'Kars', 'Erkek', 55, 'Muhasebeci', 17002)

SELECT * FROM Musteriler

SELECT TOP 2 * FROM Musteriler --En üstteki 2 kaydý getirir

--en yüksek maaþ alaný getir
SELECT TOP 1 * FROM Musteriler
ORDER BY gelir DESC

--ilk %60 kaydý getir
SELECT TOP 60 PERCENT * FROM Musteriler


--HAZIR FONKSÝYONLAR (Aggregate Functions)

--SUM
SELECT SUM(gelir) FROM Musteriler

--MAX
SELECT MAX(gelir) FROM Musteriler

--MIN
SELECT MIN(gelir) FROM Musteriler

--AVG
SELECT AVG(gelir) FROM Musteriler

--Geliri ortalama gelirden büyük olan erkek müþteriler
SELECT * FROM Musteriler 
WHERE gelir > (SELECT AVG(gelir) FROM Musteriler)
AND cinsiyet = 'Erkek'

SELECT * FROM Musteriler 
WHERE gelir > (SELECT AVG(gelir) FROM Musteriler WHERE cinsiyet = 'Erkek')

--isim soyisim getir ve büyük harfle getir
SELECT UPPER(ad) AS ÝSÝM,
UPPER(soyad) AS SOYÝSÝM 
FROM Musteriler

--Cinsiyet sayýsýný getir
SELECT cinsiyet,COUNT(cinsiyet) 
FROM Musteriler 
GROUP BY cinsiyet

--Þehir sayýsý
SELECT sehir, COUNT(sehir) AS sayý
FROM Musteriler
GROUP BY sehir
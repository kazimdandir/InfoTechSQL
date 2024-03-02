SELECT * FROM tblDepartman
SELECT * FROM tblMaas
SELECT * FROM tblPersonel

--soru1: e-postasý verilen kiþinin þifresini göster
SELECT SIFRE 
FROM tblPersonel
WHERE EPOSTA='ayse.yilmaz@example.com'

--soru2: soyadýnda soy geçen personelleri listele
SELECT * 
FROM tblPersonel
WHERE SOYADI LIKE '%can%'

--soru3: Telefon numarasý 0212 ile baþlayan bütün numaralarý 0216 olarak deðiþtiriniz.
UPDATE tblPersonel 
SET TELEFON=REPLACE(TELEFON, '0212','0216') 
WHERE TELEFON LIKE '0212%'

UPDATE tblPersonel 
SET TELEFON='0212' + SUBSTRING(TELEFON,5,15) 
WHERE TELEFON LIKE '0216%'

--soru4: Departman tablosuna ”Pazarlama” departmanýný ekleyiniz
INSERT INTO tblDepartman(DEPARTMAN)
VALUES ('Pazarlama')

--soru5: TCKimlik Numarasý ”12345678901” olan kiþinin Adýný ve Soyadýný “Ali Can” olarak deðiþtiriniz.
UPDATE tblPersonel 
SET ADI='Ali', SOYADI='Can' 
WHERE TCKIMLIKNO='12345678901'

--soru6: TC Kimlik Numarasý verilen bir personelin Ýki tarih arasýnda(örneðin 01.01.2017-31.12.2017) aldýðý toplam maaþý listeleyiniz.
SELECT p.ADI, p.SOYADI, SUM(m.MAAS) AS ToplamMaaþ
FROM tblPersonel p, tblMaas m
WHERE p.personelID = m.personalID AND p.TCKIMLIKNO = '12345678901'
AND m.TARIH BETWEEN '01-01-1990' AND '01-01-2024'
GROUP BY p.ADI, p.SOYADI
--JOIN ile
SELECT p.ADI,p.SOYADI,SUM(m.MAAS) AS ToplamMaaþ
FROM tblPersonel AS p
INNER JOIN tblMaas AS m
ON p.personelID=m.personalID
WHERE p.TCKIMLIKNO='12345678901'
AND m.TARIH BETWEEN '01-01-1990' AND '01-01-2024'
GROUP BY p.ADI, p.SOYADI

--soru7: Personelin Adýný, Soyadýný, Departmanýný ve Maaþýný listeleyiniz.
SELECT P.ADI, P.SOYADI, D.DEPARTMAN, M.MAAS
FROM tblPersonel AS P, tblDepartman AS D, tblMaas AS M
WHERE P.departmanID = D.departmanID
AND P.personelID = M.personalID
--JOIN ile
SELECT p.ADI, p.SOYADI, d.DEPARTMAN, m.MAAS
FROM tblPersonel AS p
INNER JOIN tblDepartman AS d
ON P.departmanID = d.departmanID
INNER JOIN tblMaas AS m
ON p.personelID=m.personalID

--soru8: Departmanlarý toplam maaþlarýna göre büyükten küçüðe listeleyiniz.
SELECT D.DEPARTMAN,SUM(M.MAAS) AS [DEPARTMAN TOPLAM MAAÞLARI]
FROM tblDepartman AS D, tblMaas AS M, tblPersonel AS P
WHERE P.departmanID = D.departmanID
AND P.personelID = M.personalID
GROUP BY D.DEPARTMAN 
ORDER BY SUM(M.MAAS)
--JOIN ile
SELECT d.DEPARTMAN,SUM(m.MAAS) AS [DEPARTMAN TOPLAM MAAÞLARI]
FROM tblPersonel AS p
INNER JOIN tblDepartman AS d 
ON p.departmanID=d.departmanID
INNER JOIN tblMaas AS m
ON p.personelID=m.personalID
GROUP BY d.DEPARTMAN
ORDER BY 2 --2 Kolonun numarasý

--soru9: Her departmanda kaç kiþi çalýþtýðýný DEPARTMAN, ÇALIÞAN SAYISI þeklinde listeleyiniz.
SELECT D.DEPARTMAN, COUNT(P.personelID) AS [ÇALIÞAN SAYISI]
FROM tblDepartman AS D, tblPersonel AS P
WHERE P.departmanID = D.departmanID
GROUP BY D.DEPARTMAN
--JOIN ile
SELECT d.DEPARTMAN, COUNT(p.personelID) AS [ÇALIÞAN SAYISI]
FROM tblDepartman AS d
INNER JOIN tblPersonel AS p
ON d.departmanID=p.departmanID
GROUP BY d.DEPARTMAN


--------------------------EKSTRA SORULAR--------------------------

--Personel tablosundaki tüm personellerin isimlerini ve soyisimlerini listeleyiniz.
SELECT ADI,SOYADI FROM tblPersonel

--Maaþý en yüksek olan personelin adýný, soyadýný ve maaþýný bulunuz.
SELECT p.ADI, p.SOYADI, m.MAAS AS EnYuksekMaas 
FROM tblPersonel AS p, tblMaas AS m
WHERE p.personelID=m.personalID
AND m.MAAS=(SELECT MAX(MAAS) FROM tblMaas)

--Maaþý belirli bir tutarýn üzerinde olan personelleri listeleyiniz.
SELECT p.ADI, p.SOYADI, m.MAAS
FROM tblPersonel AS p, tblMaas AS m
WHERE p.personelID = m.personalID
AND m.MAAS > 40000
ORDER BY m.MAAS 

--Personel tablosundaki tüm departmanlarý listeleyiniz.
SELECT DISTINCT d.DEPARTMAN
FROM tblPersonel AS p, tblDepartman AS d
WHERE p.departmanID = d.departmanID


--Belirli bir departmanda çalýþan personelleri listeleyiniz.
SELECT p.ADI, p.SOYADI, d.DEPARTMAN
FROM tblPersonel AS p, tblDepartman AS d
WHERE p.departmanID = d.departmanID
AND DEPARTMAN='Finans'

--Ýsimleri "Ahmet" ile baþlayan personelleri listeleyiniz.
SELECT *
FROM tblPersonel
WHERE ADI LIKE '%Ahmet'

--Telefon numarasý olmayan personelleri listeleyiniz.
SELECT *
FROM tblPersonel
WHERE TELEFON IS NULL

--Ýsimlerini, soyisimlerini ve e-posta adreslerini içeren bir rapor oluþturunuz.
SELECT ADI, SOYADI, EPOSTA 
FROM tblPersonel

--Departman baþýna çalýþan personel sayýsýný bulunuz.
SELECT  d.DEPARTMAN, COUNT(d.DEPARTMAN) AS [Çalýþan Sayýsý]
FROM tblPersonel AS p, tblDepartman AS d
WHERE p.departmanID = d.departmanID
GROUP BY d.DEPARTMAN

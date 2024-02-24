SELECT * FROM tblDepartman
SELECT * FROM tblMaas
SELECT * FROM tblPersonel

--soru1: e-postas� verilen ki�inin �ifresini g�ster
SELECT SIFRE 
FROM tblPersonel
WHERE EPOSTA='ayse.yilmaz@example.com'

--soru2: soyad�nda soy ge�en personelleri listele
SELECT * 
FROM tblPersonel
WHERE SOYADI LIKE '%can%'

--soru3: Telefon numaras� 0212 ile ba�layan b�t�n numaralar� 0216 olarak de�i�tiriniz.
UPDATE tblPersonel 
SET TELEFON=REPLACE(TELEFON, '0212','0216') 
WHERE TELEFON LIKE '0212%'

UPDATE tblPersonel 
SET TELEFON='0212' + SUBSTRING(TELEFON,5,15) 
WHERE TELEFON LIKE '0216%'

--soru4: Departman tablosuna �Pazarlama� departman�n� ekleyiniz
INSERT INTO tblDepartman(DEPARTMAN)
VALUES ('Pazarlama')

--soru5: TCKimlik Numaras� �12345678901� olan ki�inin Ad�n� ve Soyad�n� �Ali Can� olarak de�i�tiriniz.
UPDATE tblPersonel 
SET ADI='Ali', SOYADI='Can' 
WHERE TCKIMLIKNO='12345678901'

--soru6: TC Kimlik Numaras� verilen bir personelin �ki tarih aras�nda(�rne�in 01.01.2017-31.12.2017) ald��� toplam maa�� listeleyiniz.
SELECT p.ADI, p.SOYADI, SUM(m.MAAS) AS ToplamMaa�
FROM tblPersonel p, tblMaas m
WHERE p.personelID = m.personalID AND p.TCKIMLIKNO = '12345678901'
AND m.TARIH BETWEEN '01-01-1990' AND '01-01-2024'
GROUP BY p.ADI, p.SOYADI
--JOIN ile
SELECT p.ADI,p.SOYADI,SUM(m.MAAS) AS ToplamMaa�
FROM tblPersonel AS p
INNER JOIN tblMaas AS m
ON p.personelID=m.personalID
WHERE p.TCKIMLIKNO='12345678901'
AND m.TARIH BETWEEN '01-01-1990' AND '01-01-2024'
GROUP BY p.ADI, p.SOYADI

--soru7: Personelin Ad�n�, Soyad�n�, Departman�n� ve Maa��n� listeleyiniz.
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

--soru8: Departmanlar� toplam maa�lar�na g�re b�y�kten k����e listeleyiniz.
SELECT D.DEPARTMAN,SUM(M.MAAS) AS [DEPARTMAN TOPLAM MAA�LARI]
FROM tblDepartman AS D, tblMaas AS M, tblPersonel AS P
WHERE P.departmanID = D.departmanID
AND P.personelID = M.personalID
GROUP BY D.DEPARTMAN 
ORDER BY SUM(M.MAAS)
--JOIN ile
SELECT d.DEPARTMAN,SUM(m.MAAS) AS [DEPARTMAN TOPLAM MAA�LARI]
FROM tblPersonel AS p
INNER JOIN tblDepartman AS d 
ON p.departmanID=d.departmanID
INNER JOIN tblMaas AS m
ON p.personelID=m.personalID
GROUP BY d.DEPARTMAN
ORDER BY 2 --2 Kolonun numaras�

--soru9: Her departmanda ka� ki�i �al��t���n� DEPARTMAN, �ALI�AN SAYISI �eklinde listeleyiniz.
SELECT D.DEPARTMAN, COUNT(P.personelID) AS [�ALI�AN SAYISI]
FROM tblDepartman AS D, tblPersonel AS P
WHERE P.departmanID = D.departmanID
GROUP BY D.DEPARTMAN
--JOIN ile
SELECT d.DEPARTMAN, COUNT(p.personelID) AS [�ALI�AN SAYISI]
FROM tblDepartman AS d
INNER JOIN tblPersonel AS p
ON d.departmanID=p.departmanID
GROUP BY d.DEPARTMAN


--------------------------EKSTRA SORULAR--------------------------

--Personel tablosundaki t�m personellerin isimlerini ve soyisimlerini listeleyiniz.
SELECT ADI,SOYADI FROM tblPersonel

--Maa�� en y�ksek olan personelin ad�n�, soyad�n� ve maa��n� bulunuz.
SELECT p.ADI, p.SOYADI, m.MAAS AS EnYuksekMaas 
FROM tblPersonel AS p, tblMaas AS m
WHERE p.personelID=m.personalID
AND m.MAAS=(SELECT MAX(MAAS) FROM tblMaas)

--Maa�� belirli bir tutar�n �zerinde olan personelleri listeleyiniz.
SELECT p.ADI, p.SOYADI, m.MAAS
FROM tblPersonel AS p, tblMaas AS m
WHERE p.personelID = m.personalID
AND m.MAAS > 40000
ORDER BY m.MAAS 

--Personel tablosundaki t�m departmanlar� listeleyiniz.
SELECT DISTINCT d.DEPARTMAN
FROM tblPersonel AS p, tblDepartman AS d
WHERE p.departmanID = d.departmanID


--Belirli bir departmanda �al��an personelleri listeleyiniz.
SELECT p.ADI, p.SOYADI, d.DEPARTMAN
FROM tblPersonel AS p, tblDepartman AS d
WHERE p.departmanID = d.departmanID
AND DEPARTMAN='Finans'

--�simleri "Ahmet" ile ba�layan personelleri listeleyiniz.
SELECT *
FROM tblPersonel
WHERE ADI LIKE '%Ahmet'

--Telefon numaras� olmayan personelleri listeleyiniz.
SELECT *
FROM tblPersonel
WHERE TELEFON IS NULL

--�simlerini, soyisimlerini ve e-posta adreslerini i�eren bir rapor olu�turunuz.
SELECT ADI, SOYADI, EPOSTA 
FROM tblPersonel

--Departman ba��na �al��an personel say�s�n� bulunuz.
SELECT  d.DEPARTMAN, COUNT(d.DEPARTMAN) AS [�al��an Say�s�]
FROM tblPersonel AS p, tblDepartman AS d
WHERE p.departmanID = d.departmanID
GROUP BY d.DEPARTMAN

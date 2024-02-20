SELECT * FROM tblDepartman
SELECT * FROM tblMaas
SELECT * FROM tblPersonel

--soru1: e-postasý verilen kiþinin þifresini göster
SELECT SIFRE FROM tblPersonel
WHERE EPOSTA='ayse.yilmaz@example.com'

--soru2: soyadýnda soy geçen personelleri listele
SELECT * FROM tblPersonel
WHERE SOYADI LIKE '%can%'

--soru3: Telefon numarasý 0212 ile baþlayan bütün numaralarý 0216 olarak deðiþtiriniz.
UPDATE tblPersonel SET TELEFON=REPLACE(TELEFON, '0212','0216')

--soru4: Departman tablosuna ”Pazarlama” departmanýný ekleyiniz
INSERT INTO tblDepartman(DEPARTMAN)
VALUES ('Pazarlama')

--soru5: TCKimlik Numarasý ”12345678901” olan kiþinin Adýný ve Soyadýný “Ali Can” olarak deðiþtiriniz.UPDATE tblPersonel SET ADI='Ali', SOYADI='Can' WHERE TCKIMLIKNO='12345678901'

--soru6: TC Kimlik Numarasý verilen bir personelin Ýki tarih arasýnda(örneðin 01.01.2017-31.12.2017) aldýðý toplam maaþý listeleyiniz.
SELECT p.ADI, p.SOYADI, SUM(m.MAAS) AS ToplamMaaþ
FROM tblPersonel p, tblMaas m
WHERE p.personelID = m.personalID AND p.TCKIMLIKNO = '12345678901'
AND m.TARIH BETWEEN '01-01-1990' AND '01-01-2024'
GROUP BY p.ADI, p.SOYADI

--soru7: Personelin Adýný, Soyadýný, Departmanýný ve Maaþýný listeleyiniz.
SELECT P.ADI, P.SOYADI, D.DEPARTMAN, M.MAAS
FROM tblPersonel AS P, tblDepartman AS D, tblMaas AS M
WHERE P.departmanID = D.departmanID
AND P.personelID = M.personalID
ORDER BY P.personelID

--soru8: Departmanlarý toplam maaþlarýna göre büyükten küçüðe listeleyiniz.
SELECT D.DEPARTMAN,SUM(M.MAAS) AS [DEPARTMAN TOPLAM MAAÞLARI]
FROM tblDepartman AS D, tblMaas AS M, tblPersonel AS P
WHERE P.departmanID = D.departmanID
AND P.personelID = M.personalID
GROUP BY D.DEPARTMAN 
ORDER BY SUM(M.MAAS)

--soru9: Her departmanda kaç kiþi çalýþtýðýný DEPARTMAN, ÇALIÞAN SAYISI þeklinde listeleyiniz.
SELECT D.DEPARTMAN, COUNT(P.personelID) AS [ÇALIÞAN SAYISI]
FROM tblDepartman AS D, tblPersonel AS P
WHERE P.departmanID = D.departmanID
GROUP BY D.DEPARTMAN

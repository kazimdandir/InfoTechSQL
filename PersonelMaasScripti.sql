SELECT * FROM tblDepartman
SELECT * FROM tblMaas
SELECT * FROM tblPersonel

--soru1: e-postas� verilen ki�inin �ifresini g�ster
SELECT SIFRE FROM tblPersonel
WHERE EPOSTA='ayse.yilmaz@example.com'

--soru2: soyad�nda soy ge�en personelleri listele
SELECT * FROM tblPersonel
WHERE SOYADI LIKE '%soy%'
SELECT * FROM tblDepartman
SELECT * FROM tblMaas
SELECT * FROM tblPersonel

--soru1: e-postasý verilen kiþinin þifresini göster
SELECT SIFRE FROM tblPersonel
WHERE EPOSTA='ayse.yilmaz@example.com'

--soru2: soyadýnda soy geçen personelleri listele
SELECT * FROM tblPersonel
WHERE SOYADI LIKE '%soy%'
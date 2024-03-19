--TRIGGERS - TETÝKLEYÝCÝLER
USE Kutuphane

CREATE TRIGGER TRG_Listele ON Ogrenci
--FOR || AFTER || INSTEAD OF
AFTER INSERT -- insert yapýldýktan sonra çalýþacak anlamýna gelir
AS 
BEGIN
	SELECT * FROM Ogrenci 
END

INSERT INTO Ogrenci(ograd, ogrsoyad, cinsiyet, dtarih, sinif, puan)
VALUES ('Colin', 'Kazým', 'Erkek', '1994-04-06', '3d', 78)

DISABLE TRIGGER TRG_Listele ON Ogrenci -- Triggeri pasif eder
ENABLE TRIGGER TRG_Listele ON Ogrenci -- Triggeri aktif eder
ALTER TABLE Ogrenci ENABLE TRIGGER TRG_Listele -- Aktif eder

--Tüm triggerleri aktif ya da pasif yapmak istersek
DISABLE TRIGGER ALL ON Ogrenci -- Triggerleri pasif eder
ENABLE TRIGGER ALL ON Ogrenci -- Triggerleri aktif eder
ALTER TABLE Ogrenci ENABLE TRIGGER ALL -- Tüm triggerleri aktif eder


--ROLLBACK TRANSACTION : Trigger iþlemini iptal eder
--RAISERROR : Ýptal nedenini mesaj verdirir

--10a sýnýfýna sadece cinsiyeti kadýn olanlar kaydedilebilsin, erkekler kaydedilemesin
CREATE TRIGGER TRG_Cinsiyet ON Ogrenci
FOR INSERT --Ekleme sýrasýnda
AS
IF(EXISTS(SELECT * FROM inserted WHERE sinif = '10A' AND cinsiyet = 'Erkek'))
BEGIN
	RAISERROR('10 A sýnýfýna erkek öðrenci kaydedilemez', 1, 0)
	ROLLBACK TRANSACTION
END

INSERT INTO Ogrenci(ograd, ogrsoyad, cinsiyet, dtarih, sinif, puan)
VALUES ('Colin', 'Kazým', 'Erkek', '1994-04-06', '10A', 78)

INSERT INTO Ogrenci(ograd, ogrsoyad, cinsiyet, dtarih, sinif, puan)
VALUES ('Ayþe', 'Fatma', 'Kadýn', '1994-04-06', '10A', 78)

--10A kýz öðrenciler silinemesin
CREATE TRIGGER TRG_KadinSilinemez ON Ogrenci
AFTER DELETE
AS
IF(EXISTS(SELECT * FROM deleted WHERE sinif = '10A' AND cinsiyet = 'Kadýn'))
BEGIN
	RAISERROR('10 A sýnýfýndan kadýn öðrenci silinemez', 1, 0)
	ROLLBACK TRANSACTION
END

DELETE FROM Ogrenci WHERE cinsiyet = 'Kadýn' AND sinif = '10A'

--Silinen öðrenciler ayrý bir mezun tablosuna kaydedilsin
CREATE TABLE Mezun
(
OgrAd NVARCHAR(30),
OgrSoyad NVARCHAR(30)
)

CREATE TRIGGER TRG_SilineniMezunaEkle ON Ogrenci
AFTER DELETE 
AS
BEGIN 
	INSERT INTO Mezun
	SELECT ograd, ogrsoyad FROM deleted
END

DELETE FROM Ogrenci WHERE ogrno = 7

SELECT * FROM Mezun


--Tür tablosundan hiçbir tür silinemesin
CREATE TRIGGER TRG_TurSilinemez ON Tur
INSTEAD OF DELETE --Silme iþlemi yerine
AS
BEGIN
	RAISERROR('Tür silinemez', 1, 0)
	ROLLBACK TRANSACTION
END

DELETE FROM Tur


--Ogrenci tablosuna silindi isminde bir alan ekleyiniz. Ogrenci silinmesin silindi alanýnýn deðeri 1 olsun
ALTER TABLE Ogrenci ADD IsDeleted BIT NULL
DISABLE TRIGGER ALL ON Ogrenci

CREATE TRIGGER TRG_IsDeleted ON Ogrenci
INSTEAD OF DELETE 
AS
BEGIN
	UPDATE Ogrenci SET IsDeleted = 1 WHERE ogrno IN (SELECT ogrno FROM deleted)
END

DELETE FROM Ogrenci WHERE ogrno IN (6, 5, 4, 3)

--Tür tablosuna gTarih adýnda bir alan ekleyin tür tablosunda güncelleme yapýldýðýnda gTarih alanýna güncelleme tarihini kaydediniz
ALTER TABLE Tur ADD gTarih DATETIME

CREATE TRIGGER TRG_TarihGuncelle ON Tur
AFTER UPDATE
AS
BEGIN
	UPDATE Tur SET gTarih = GETDATE() WHERE turno IN (SELECT turno FROM deleted)
END

UPDATE Tur SET turadi = 'KomediTest' WHERE turadi = 'Komedi'

--ÖDEVLER

--500 sayfadan daha az roman türünde kitap eklenemesin
INSERT INTO Tur(turadi, gTarih)
VALUES ('Roman', GETDATE())

CREATE TRIGGER TRG_RomanSayfaSiniri ON Kitap
FOR INSERT
AS
IF (EXISTS(SELECT * FROM Kitap WHERE turno = 4 AND sayfasayisi < 500))
BEGIN
	RAISERROR('500 sayfadan az roman türünde kitap eklenemez.', 1, 0)
	ROLLBACK TRANSACTION
END

INSERT INTO Kitap(kitapadi, yazarno, turno, sayfasayisi, puan)
VALUES ('Son Kuþlar', 1, 4, 144, 85)

--Kitap tablosu güncellenirken eski sayfa sayýsý yeni sayfa sayýsýndan fazla olmak zorunda(sayfalarý yýrtýlmamýþ olacak)
CREATE TRIGGER TRG_YeniSayfaSayisi ON Kitap
AFTER UPDATE
AS 
BEGIN
    IF EXISTS(SELECT * FROM inserted i INNER JOIN deleted d ON i.kitapno = d.kitapno WHERE i.sayfasayisi <= d.sayfasayisi)
    BEGIN
        RAISERROR('Yeni sayfa sayýsý eskisinden büyük olmalýdýr.', 1, 0)
        ROLLBACK TRANSACTION
    END
END

UPDATE Kitap SET sayfasayisi = 599 WHERE kitapno=1 --Þu an 600 olduðunu varsayarak hata verir
UPDATE Kitap SET sayfasayisi = 602 WHERE kitapno=1 --Þu an 600 olduðunu varsayarak hata vermez

--Öðrenci notlarýný tutan bir tablo olsun.
--not1 -0 ile 100 arasý
--not2
--not3
--ortalama
ALTER TABLE Ogrenci ADD not1 TINYINT, 
						not2 TINYINT,
						not3 TINYINT,
						ortalama DECIMAL

CREATE TRIGGER TRG_OrtalamaHesapla ON Ogrenci
AFTER INSERT, UPDATE
AS
BEGIN
    IF (EXISTS(SELECT * FROM inserted WHERE not1 NOT BETWEEN 0 AND 100
                                      OR not2 NOT BETWEEN 0 AND 100
                                      OR not3 NOT BETWEEN 0 AND 100))
    BEGIN
        RAISERROR('Not aralýklarý 0-100 arasý olmalýdýr', 1, 0)
        ROLLBACK TRANSACTION
    END
    ELSE
    BEGIN
		UPDATE o
		SET ortalama = (i.not1 + i.not2 + i.not3) / 3
		FROM Ogrenci AS o
		INNER JOIN inserted AS i ON o.ogrno = i.ogrno
    END
END

INSERT INTO Ogrenci(ograd, ogrsoyad, cinsiyet, dtarih, sinif, not1, not2, not3)
VALUES ('Fatih', 'Ertürk', 'Erkek', GETDATE()-10, '3d', 110, 50, 30) --Hata verir çünkü 0-100 arasý olmayan not var

INSERT INTO Ogrenci(ograd, ogrsoyad, cinsiyet, dtarih, sinif, not1, not2, not3)
VALUES ('Fatih', 'Ertürk', 'Erkek', GETDATE()-10, '3d', 90, 50, 30) --Hata vermez

--DISABLE TRIGGER ALL ON Ogrenci
--ENABLE TRIGGER TRG_OrtalamaHesapla ON Ogrenci

--Proje E-Ticaret Veritabaný Oluþturma
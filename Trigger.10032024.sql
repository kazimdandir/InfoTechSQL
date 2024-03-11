--TRIGGERS - TET�KLEY�C�LER
USE Kutuphane

CREATE TRIGGER TRG_Listele ON Ogrenci
--FOR || AFTER || INSTEAD OF
AFTER INSERT -- insert yap�ld�ktan sonra �al��acak anlam�na gelir
AS 
BEGIN
	SELECT * FROM Ogrenci 
END

INSERT INTO Ogrenci(ograd, ogrsoyad, cinsiyet, dtarih, sinif, puan)
VALUES ('Colin', 'Kaz�m', 'Erkek', '1994-04-06', '3d', 78)

DISABLE TRIGGER TRG_Listele ON Ogrenci -- Triggeri pasif eder
ENABLE TRIGGER TRG_Listele ON Ogrenci -- Triggeri aktif eder
ALTER TABLE Ogrenci ENABLE TRIGGER TRG_Listele -- Aktif eder

--T�m triggerleri aktif ya da pasif yapmak istersek
DISABLE TRIGGER ALL ON Ogrenci -- Triggerleri pasif eder
ENABLE TRIGGER ALL ON Ogrenci -- Triggerleri aktif eder
ALTER TABLE Ogrenci ENABLE TRIGGER ALL -- T�m triggerleri aktif eder


--ROLLBACK TRANSACTION : Trigger i�lemini iptal eder
--RAISERROR : �ptal nedenini mesaj verdirir

--10a s�n�f�na sadece cinsiyeti kad�n olanlar kaydedilebilsin, erkekler kaydedilemesin
CREATE TRIGGER TRG_Cinsiyet ON Ogrenci
FOR INSERT --Ekleme s�ras�nda
AS
IF(EXISTS(SELECT * FROM inserted WHERE sinif = '10A' AND cinsiyet = 'Erkek'))
BEGIN
	RAISERROR('10 A s�n�f�na erkek ��renci kaydedilemez', 1, 0)
	ROLLBACK TRANSACTION
END

INSERT INTO Ogrenci(ograd, ogrsoyad, cinsiyet, dtarih, sinif, puan)
VALUES ('Colin', 'Kaz�m', 'Erkek', '1994-04-06', '10A', 78)

INSERT INTO Ogrenci(ograd, ogrsoyad, cinsiyet, dtarih, sinif, puan)
VALUES ('Ay�e', 'Fatma', 'Kad�n', '1994-04-06', '10A', 78)

--10A k�z ��renciler silinemesin
CREATE TRIGGER TRG_KadinSilinemez ON Ogrenci
AFTER DELETE
AS
IF(EXISTS(SELECT * FROM deleted WHERE sinif = '10A' AND cinsiyet = 'Kad�n'))
BEGIN
	RAISERROR('10 A s�n�f�ndan kad�n ��renci silinemez', 1, 0)
	ROLLBACK TRANSACTION
END

DELETE FROM Ogrenci WHERE cinsiyet = 'Kad�n' AND sinif = '10A'

--Silinen ��renciler ayr� bir mezun tablosuna kaydedilsin
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


--T�r tablosundan hi�bir t�r silinemesin
CREATE TRIGGER TRG_TurSilinemez ON Tur
INSTEAD OF DELETE --Silme i�lemi yerine
AS
BEGIN
	RAISERROR('T�r silinemez', 1, 0)
	ROLLBACK TRANSACTION
END

DELETE FROM Tur


--Ogrenci tablosuna silindi isminde bir alan ekleyiniz. Ogrenci silinmesin silindi alan�n�n de�eri 1 olsun
ALTER TABLE Ogrenci ADD IsDeleted BIT NULL
DISABLE TRIGGER ALL ON Ogrenci

CREATE TRIGGER TRG_IsDeleted ON Ogrenci
INSTEAD OF DELETE 
AS
BEGIN
	UPDATE Ogrenci SET IsDeleted = 1 WHERE ogrno IN (SELECT ogrno FROM deleted)
END

DELETE FROM Ogrenci WHERE ogrno IN (6, 5, 4, 3)

--T�r tablosuna gTarih ad�nda bir alan ekleyin t�r tablosunda g�ncelleme yap�ld���nda gTarih alan�na g�ncelleme tarihini kaydediniz
ALTER TABLE Tur ADD gTarih DATETIME

CREATE TRIGGER TRG_TarihGuncelle ON Tur
AFTER UPDATE
AS
BEGIN
	UPDATE Tur SET gTarih = GETDATE() WHERE turno IN (SELECT turno FROM deleted)
END

UPDATE Tur SET turadi = 'KomediTest' WHERE turadi = 'Komedi'

--�DEVLER

--500 sayfadan daha az roman t�r�nde kitap eklenemesin



--Kitap tablosu g�ncellenirken eski sayfa say�s� yeni sayfa say�s�ndan fazla olmak zorunda(sayfalar� y�rt�lmam�� olacak)



--��renci notlar�n� tutan bir tablo olsun.
--not1 -0 ile 100 aras�
--not2
--not3
--ortalama


--Proje E-Ticaret Veritaban� Olu�turma
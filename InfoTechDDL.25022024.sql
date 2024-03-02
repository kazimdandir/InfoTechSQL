--DDL DATA DEFINITON LANG. 

--CREATE
--DROP
--ALTER
--SELECT INTO
--DELETE
--TRUNCATE

CREATE DATABASE InfoDDLDb
--Silmek için DROP DATABASE InfoDDLDb
--Deðiþtirmek için ALTER DATABASE InfoDDLDb

USE InfoDDLDb

CREATE TABLE Personel
(
ID INT NOT NULL PRIMARY KEY,
AdiSoyadi VARCHAR(30),
Sehir VARCHAR(35)
)
GO
CREATE TABLE Persons
(
ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50),
Age TINYINT
)

DROP TABLE Persons --Tablo tamamen gitti
TRUNCATE TABLE Persons --Ýçerisindeki verileri temizler
DELETE FROM Persons --Verileri temizler ama kalan ID'den devam eder

SELECT * INTO PersYedek FROM Persons --Persons tablosunu PersYedek tablosuna yedekler/klonlar

ALTER TABLE Personel ADD Yas TINYINT --Yeni kolon ekler
ALTER TABLE Personel DROP COLUMN Yas --Kolon siler
ALTER TABLE Personel ALTER COLUMN AdiSoyadi VARCHAR(100) --Kolonun özelliðini deðiþtirir
EXEC sp_rename 'dbo.Personel.AdiSoyadi', 'AdSoyad', 'COLUMN'; --Kolon adý deðiþtirir


--Bire Çok Ýliþki 
--One to Many
CREATE TABLE Kategori
(
id INT PRIMARY KEY IDENTITY(1,1),
KatAdi VARCHAR(50),
KatAciklama VARCHAR(MAX)
)
GO
CREATE TABLE Urunler
(
UrunId INT IDENTITY(100,5) PRIMARY KEY,
UrunAd VARCHAR(50),
UrunAciklama VARCHAR(MAX),
UrunBirimFiyat MONEY, 
UrunStokAdet TINYINT,
KatRefID INT FOREIGN KEY REFERENCES Kategori(id)
)
--alternatif yazýmý
CREATE TABLE Kategori
(
id INT PRIMARY KEY IDENTITY(1,1),
KatAdi VARCHAR(50),
KatAciklama VARCHAR(MAX)
)
GO
CREATE TABLE Urunler
(
UrunId INT IDENTITY(100,5) PRIMARY KEY,
UrunAd VARCHAR(50),
UrunAciklama VARCHAR(MAX),
UrunBirimFiyat MONEY, 
UrunStokAdet TINYINT,
KatRefID INT
)
GO
ALTER TABLE Urunler WITH CHECK ADD CONSTRAINT FK_Urunler_Kategori FOREIGN KEY(KatRefID)
REFERENCES Kategori(id)



--Ders
--Ogrenci

--Çoka Çok Ýliþki 
--Many to Many
CREATE TABLE Ders
(
DersID INT IDENTITY PRIMARY KEY,
DersAdi NVARCHAR(50),
)
GO
CREATE TABLE Ogrenci
(
OgrenciID INT IDENTITY PRIMARY KEY,
OgrenciAdi NVARCHAR(50)
)
GO 
CREATE TABLE DersOgrenci
(
ID INT IDENTITY PRIMARY KEY,
DersID INT FOREIGN KEY REFERENCES Ders(DersID),
OgrenciID INT FOREIGN KEY REFERENCES Ogrenci(OgrenciID)
)

--INSERT INTO Ders(DersAdi)
--VALUES ('Matematik')
--INSERT INTO Ogrenci(OgrenciAdi)
--VALUES ('Yusuf')
--INSERT INTO DersOgrenci (DersID,OgrenciID)
--VALUES (1,1)


--Çoka çok iliþki örneði
CREATE TABLE Muhendisler
(
PersonelID INT IDENTITY PRIMARY KEY,
Bolum NVARCHAR(50),
Ad NVARCHAR(50),
Soyad NVARCHAR(50),
Brans NVARCHAR(50)
)
GO
CREATE TABLE Projeler
(
ProjeID INT IDENTITY PRIMARY KEY,
ProjeAdi NVARCHAR(50),
ProjeTanimi NVARCHAR(50),
Baslangic DATE,
Bitis DATE
)
GO
CREATE TABLE MuhendisProje
(
ID INT IDENTITY PRIMARY KEY,
PersonelID INT FOREIGN KEY REFERENCES Muhendisler(PersonelID),
ProjeID INT FOREIGN KEY REFERENCES Projeler(ProjeID)
)


--Birebir iliþki 
--One to One
CREATE TABLE Muayeneler
(
MuayeneNo INT IDENTITY PRIMARY KEY,
HastaNo INT,
DoktorNo INT,
Tarih DATE
)
GO
CREATE TABLE MuayeneDetay
(
MuayeneNo INT IDENTITY PRIMARY KEY,
Karar VARCHAR(MAX)
FOREIGN KEY (MuayeneNo) REFERENCES Muayeneler(MuayeneNo)
)
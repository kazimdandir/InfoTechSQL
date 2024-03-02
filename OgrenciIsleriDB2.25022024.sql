CREATE DATABASE OgrenciIsleriDB2
GO
USE OgrenciIsleriDB2
GO
CREATE TABLE tblOgrenciIsleri
(
PersonelNo INT IDENTITY PRIMARY KEY,
PersonelAd VARCHAR(50),
PersonelSoyad VARCHAR(50)
)
GO
CREATE TABLE tblBolumBilgileri
(
BolumNo INT IDENTITY PRIMARY KEY,
BolumAdi NVARCHAR(50)
)
GO
CREATE TABLE tblBolumDersleri
(
DersKodu INT IDENTITY PRIMARY KEY,
DersAd� VARCHAR(50),
BolumNo INT FOREIGN KEY REFERENCES tblBolumBilgileri(BolumNo)
)
GO 
CREATE TABLE tblPersonel_Ders
(
PersonelNo INT FOREIGN KEY REFERENCES tblBolumDersleri(DersKodu),
DersKodu INT FOREIGN KEY REFERENCES tblBolumDersleri(DersKodu)
)
GO
CREATE TABLE tblOgrenciBilgileri
(
OgrenciNo INT IDENTITY PRIMARY KEY,
OgrAd VARCHAR(50),
OgrSoyad VARCHAR(50),
DogumTarihi DATETIME,
Cinsiyet VARCHAR(5),
EPosta NVARCHAR(50)
)
GO
CREATE TABLE tblOgrenci_Ders
(
OgrNo INT FOREIGN KEY REFERENCES tblOgrenciBilgileri(OgrenciNo),
DersNo INT FOREIGN KEY REFERENCES tblBolumDersleri(DersKodu),
Vize INT,
Final INT,
Durumu NVARCHAR(MAX)
)
GO
CREATE TABLE tblOgrenci_Devam
(
OgrNo INT FOREIGN KEY REFERENCES tblOgrenciBilgileri(OgrenciNo),
Devamsizlik INT
)


--INSERTS
INSERT INTO tblOgrenciIsleri(PersonelAd,PersonelSoyad)
VALUES ('Ali', 'Veli'),
       ('Murat', 'Ayd�n'),
	   ('Enes', 'Yolda'), 
	   ('Ebru', 'Kenarl�'),
	   ('Buse', 'T�rk')
 
INSERT INTO tblBolumBilgileri (BolumAdi)
VALUES ('Havac�l�k Y�netimi'),
       ('Gastronomi'),
	   ('Psikoloji'),
	   ('Bankac�l�k'),
	   ('Mimarl�k')
 
INSERT INTO tblBolumDersleri(DersAd�,BolumNo) 
VALUES --Havac�l�k Y�netimi
	   ('Ramp Hizmetleri', 1), ('Tehlikeli Maddeler', 1), ('Havac�l�k �ngilizcesi', 1), ('Havac�l�k ��letme Prensipleri', 1), ('Havayolu ��letmecili�i', 1), ('Havaalan� Y�netimi',1), ('Hava Ta��mac�l���	  	 Ekonomisi',1), ('Havac�l�k G�venli�i ve Emniyeti',1),
	   --Gastronomi
	   ('Temel Mutfak Teknikleri', 2), ('G�da G�venli�i ve Hijyen', 2), ('Gastronomik Tarih ve K�lt�r', 2), ('Beslenme Bilimi', 2), ('Yemek Sanatlar� ve Sunumu', 2), ('Mutfak Y�netimi ve ��letme', 2) , ('Gastronomik �novasyon', 2), ('Gastronomik Geziler ve Deneyimler', 2),
	   --Psikoloji
	   ('Genel Psikoloji', 3), ('Geli�imsel Psikoloji', 3), ('Sosyal Psikoloji', 3), ('Klinik Psikoloji', 3), ('N�ropsikoloji', 3), ('��renme ve Haf�za', 3), ('Alg� ve Dikkat', 3), ('Sa�l�k Psikolojisi', 3), ('�� ve �rg�t   Psikolojisi', 3), ('Davran��sal N�robilim', 3),
	   --Bankac�l�k
	   ('Bankac�l��a Giri�', 4), ('Finansal Pazarlar ve Kurumlar', 4), ('Risk Y�netimi', 4), ('Banka Operasyonlar�', 4), ('Banka Y�netimi', 4), ('Kredi Analizi ve De�erleme', 4), ('Finansal D�zenleme ve Denetim', 4),	('Bankac�l�k ve Teknoloji' ,4), ('Uluslararas� Bankac�l�k', 4),
	   --Mimarl�k
	   ('Temel Tasar�m', 5), ('Mimari Tarih ve Teorisi', 5), ('Mimari Tasar�m St�dyosu', 5), ('Yap� Bilgisi ve Malzemeleri', 5), ('Mimarl�k St�dyosu', 5), ('Mimarl�k �izim ve Sunum Teknikleri', 5), ('Kentsel Tasar�m ve Planlama', 5), ('�evresel ve S�rd�r�lebilir Tasar�m', 5), ('Mimarl�k ve Toplum', 5)   
 
INSERT INTO tblPersonel_Ders(PersonelNo, DersKodu)
VALUES --Personel1: Ali Veli
       (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8),
       --Personel2: Murat Ayd�n
       (2, 9), (2, 10), (2, 11), (2, 12), (2, 13), (2, 14), (2, 15), (2, 16),
       --Personel3: Enes Yolda�
       (3, 17), (3, 18), (3, 19), (3, 20), (3, 21), (3, 22), (3, 23), (3, 24), (3, 25), (3, 26),
       --Personel4: Ebru Kenarl�
       (4, 27), (4, 28), (4, 29), (4, 30), (4, 31), (4, 32), (4, 33), (4, 34), (4, 35),
       --Personel5: Buse T�rk
       (5, 36), (5, 37), (5, 38), (5, 39), (5, 40), (5, 41), (5, 42), (5, 43), (5, 44)
 
INSERT INTO tblOgrenciBilgileri(OgrAd,OgrSoyad,DogumTarihi,Cinsiyet,EPosta)
VALUES ('Ay�e', 'Kara', 15-03-1997, 'Kad�n', 'aysekara@mail.com'),
	   ('Mehmet', 'Demir', 22-07-199, 'Erkek', 'mehmetdemir@mail.com'),
	   ('Zeynep', 'Y�lmaz', 10-11-1998, 'Kad�n', 'zeynepyilmaz@mail.com'),
	   ('Ahmet', '�ahin', 05-09-1994, 'Erkek', 'ahmetsahin@mail.com'),
	   ('Elif', 'Ko�', 20-04-1996, 'Kad�n', 'elifkoc@mail.com'),
	   ('Can', 'Ergin', 03-12-1997, 'Erkek', 'canergin@mail.com'),
	   ('Aylin', 'Kurt', 17-08-1995, 'Kad�n', 'aylinkurt@mail.com'),
	   ('�mer', 'Y�ld�r�m', 08-06-1996, 'Erkek', 'omeryildirim@mail.com'),
	   ('Melis', '�en', 25-02-1998, 'Kad�n', 'melissen@mail.com')
 
CREATE TRIGGER HesaplaOrtalama
ON tblOgrenci_Ders
AFTER INSERT, UPDATE
AS
BEGIN
  UPDATE tblOgrenci_Ders
  SET Durumu = CASE WHEN Vize IS NOT NULL AND Final IS NOT NULL THEN CASE WHEN ROUND(((Vize * 0.4) + (Final * 0.6)), 0) >= 50 THEN 'Ge�ti (' + CAST(ROUND(((Vize * 0.4) + (Final * 0.6)), 0) AS VARCHAR(5)) + ')' ELSE 'Kald� (' + CAST(ROUND(((Vize * 0.4) + (Final * 0.6)), 0) AS VARCHAR(5)) + ')' END ELSE NULL END
END

INSERT INTO tblOgrenci_Ders(OgrNo,DersNo,Vize,Final,Durumu)
VALUES (1, 1, 50, 20, NULL),
	   (1, 10, 70, 40, NULL),
	   (2, 4, 60, 46, NULL),
	   (2, 7, 35, 78, NULL),
	   (3, 15, 49, 79, NULL),
	   (3, 6, 41, 81, NULL),
	   (4, 22, 12, 78, NULL),
	   (4, 9, 56, 92, NULL),
	   (5, 41, 50, 60, NULL),
	   (5, 4, 70, 40, NULL),
	   (6, 19, 60, 46, NULL),
	   (6, 27, 27, 78, NULL),
	   (7, 21, 49, 79, NULL),
	   (7, 35, 41, 81, NULL),
	   (8, 11, 35, 42, NULL),
	   (8, 25, 56, 92, NULL),
	   (9, 14, 50, 60, NULL),
	   (9, 33, 49, 25, NULL) 
 
INSERT INTO tblOgrenci_Devam(OgrNo, Devamsizlik)
VALUES (1, 8), (2, 17), (3, 3), (4, 12), (5, 19), (6, 16), (7, 10), (8, 15), (9, 4)


--SELECTS
SELECT * FROM tblBolumBilgileri
SELECT * FROM tblBolumDersleri
SELECT * FROM tblOgrenci_Ders
SELECT * FROM tblOgrenci_Devam
SELECT * FROM tblOgrenciBilgileri
SELECT * FROM tblOgrenciIsleri
SELECT * FROM tblPersonel_Ders


--SORGU �RNEKLER�
--1)T�m dersler aras�nda kalanlar ��rencileri getir (Ad-soyad-durum-b�l�m ad�,ders ad�)
SELECT ob.OgrAd + ' ' + ob.OgrSoyad AS OgrenciAdiSoyadi,
	   bb.BolumAdi,
	   bd.DersAd�,
	   od.Durumu
FROM tblOgrenciBilgileri AS ob
	JOIN tblOgrenci_Ders AS od ON ob.OgrenciNo=od.OgrNo
	JOIN tblBolumDersleri AS bd ON od.DersNo=bd.DersKodu
	JOIN tblBolumBilgileri AS bb ON bd.BolumNo=bb.BolumNo
WHERE od.Durumu LIKE '%Kald�%'
ORDER BY od.Durumu 

--2)tblBolumDersleri tablosundaki DersAd� kolon ad�n� DersAdi olarak de�i�tir
EXEC sp_rename 'dbo.tblBolumDersleri.DersAd�', 'DersAdi',�'COLUMN'; 

--3)Hangi b�l�mde ka� ders var listele
SELECT bb.BolumAdi AS [B�l�m Ad�],
	COUNT(bd.DersAdi) AS [Ders Say�s�]
FROM tblBolumBilgileri AS bb
	JOIN tblBolumDersleri AS bd ON bb.BolumNo=bd.BolumNo
GROUP BY bb.BolumAdi
ORDER BY COUNT(bd.DersAdi) DESC


--4)tblOgrenciIsleri tablosundaki soyad� Yolda olan personelin soyad�n� Yolda� d�zelt
UPDATE tblOgrenciIsleri SET PersonelSoyad='Yolda�' WHERE PersonelNo=3

--5)Havac�l�k Y�netimi b�l�m�ndeki ��rencileri listele
SELECT ob.OgrAd + ' ' + ob.OgrSoyad AS [��renci Ad� ve Soyad�],
	bb.BolumAdi AS [B�l�m Ad�],
	bd.DersKodu AS [Ders Kodu],
	bd.DersAdi AS [Ders Ad�]
FROM tblOgrenciBilgileri AS ob
	JOIN tblOgrenci_Ders AS od ON ob.OgrenciNo=od.OgrNo
	JOIN tblBolumDersleri AS bd ON od.DersNo=bd.DersKodu
	JOIN tblBolumBilgileri AS bb ON bd.BolumNo=bb.BolumNo
WHERE bb.BolumNo=1
ORDER BY bd.DersKodu
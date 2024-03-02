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
DersAdý VARCHAR(50),
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
       ('Murat', 'Aydýn'),
	   ('Enes', 'Yolda'), 
	   ('Ebru', 'Kenarlý'),
	   ('Buse', 'Türk')
 
INSERT INTO tblBolumBilgileri (BolumAdi)
VALUES ('Havacýlýk Yönetimi'),
       ('Gastronomi'),
	   ('Psikoloji'),
	   ('Bankacýlýk'),
	   ('Mimarlýk')
 
INSERT INTO tblBolumDersleri(DersAdý,BolumNo) 
VALUES --Havacýlýk Yönetimi
	   ('Ramp Hizmetleri', 1), ('Tehlikeli Maddeler', 1), ('Havacýlýk Ýngilizcesi', 1), ('Havacýlýk Ýþletme Prensipleri', 1), ('Havayolu Ýþletmeciliði', 1), ('Havaalaný Yönetimi',1), ('Hava Taþýmacýlýðý	  	 Ekonomisi',1), ('Havacýlýk Güvenliði ve Emniyeti',1),
	   --Gastronomi
	   ('Temel Mutfak Teknikleri', 2), ('Gýda Güvenliði ve Hijyen', 2), ('Gastronomik Tarih ve Kültür', 2), ('Beslenme Bilimi', 2), ('Yemek Sanatlarý ve Sunumu', 2), ('Mutfak Yönetimi ve Ýþletme', 2) , ('Gastronomik Ýnovasyon', 2), ('Gastronomik Geziler ve Deneyimler', 2),
	   --Psikoloji
	   ('Genel Psikoloji', 3), ('Geliþimsel Psikoloji', 3), ('Sosyal Psikoloji', 3), ('Klinik Psikoloji', 3), ('Nöropsikoloji', 3), ('Öðrenme ve Hafýza', 3), ('Algý ve Dikkat', 3), ('Saðlýk Psikolojisi', 3), ('Ýþ ve Örgüt   Psikolojisi', 3), ('Davranýþsal Nörobilim', 3),
	   --Bankacýlýk
	   ('Bankacýlýða Giriþ', 4), ('Finansal Pazarlar ve Kurumlar', 4), ('Risk Yönetimi', 4), ('Banka Operasyonlarý', 4), ('Banka Yönetimi', 4), ('Kredi Analizi ve Deðerleme', 4), ('Finansal Düzenleme ve Denetim', 4),	('Bankacýlýk ve Teknoloji' ,4), ('Uluslararasý Bankacýlýk', 4),
	   --Mimarlýk
	   ('Temel Tasarým', 5), ('Mimari Tarih ve Teorisi', 5), ('Mimari Tasarým Stüdyosu', 5), ('Yapý Bilgisi ve Malzemeleri', 5), ('Mimarlýk Stüdyosu', 5), ('Mimarlýk Çizim ve Sunum Teknikleri', 5), ('Kentsel Tasarým ve Planlama', 5), ('Çevresel ve Sürdürülebilir Tasarým', 5), ('Mimarlýk ve Toplum', 5)   
 
INSERT INTO tblPersonel_Ders(PersonelNo, DersKodu)
VALUES --Personel1: Ali Veli
       (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8),
       --Personel2: Murat Aydýn
       (2, 9), (2, 10), (2, 11), (2, 12), (2, 13), (2, 14), (2, 15), (2, 16),
       --Personel3: Enes Yoldaþ
       (3, 17), (3, 18), (3, 19), (3, 20), (3, 21), (3, 22), (3, 23), (3, 24), (3, 25), (3, 26),
       --Personel4: Ebru Kenarlý
       (4, 27), (4, 28), (4, 29), (4, 30), (4, 31), (4, 32), (4, 33), (4, 34), (4, 35),
       --Personel5: Buse Türk
       (5, 36), (5, 37), (5, 38), (5, 39), (5, 40), (5, 41), (5, 42), (5, 43), (5, 44)
 
INSERT INTO tblOgrenciBilgileri(OgrAd,OgrSoyad,DogumTarihi,Cinsiyet,EPosta)
VALUES ('Ayþe', 'Kara', 15-03-1997, 'Kadýn', 'aysekara@mail.com'),
	   ('Mehmet', 'Demir', 22-07-199, 'Erkek', 'mehmetdemir@mail.com'),
	   ('Zeynep', 'Yýlmaz', 10-11-1998, 'Kadýn', 'zeynepyilmaz@mail.com'),
	   ('Ahmet', 'Þahin', 05-09-1994, 'Erkek', 'ahmetsahin@mail.com'),
	   ('Elif', 'Koç', 20-04-1996, 'Kadýn', 'elifkoc@mail.com'),
	   ('Can', 'Ergin', 03-12-1997, 'Erkek', 'canergin@mail.com'),
	   ('Aylin', 'Kurt', 17-08-1995, 'Kadýn', 'aylinkurt@mail.com'),
	   ('Ömer', 'Yýldýrým', 08-06-1996, 'Erkek', 'omeryildirim@mail.com'),
	   ('Melis', 'Þen', 25-02-1998, 'Kadýn', 'melissen@mail.com')
 
CREATE TRIGGER HesaplaOrtalama
ON tblOgrenci_Ders
AFTER INSERT, UPDATE
AS
BEGIN
  UPDATE tblOgrenci_Ders
  SET Durumu = CASE WHEN Vize IS NOT NULL AND Final IS NOT NULL THEN CASE WHEN ROUND(((Vize * 0.4) + (Final * 0.6)), 0) >= 50 THEN 'Geçti (' + CAST(ROUND(((Vize * 0.4) + (Final * 0.6)), 0) AS VARCHAR(5)) + ')' ELSE 'Kaldý (' + CAST(ROUND(((Vize * 0.4) + (Final * 0.6)), 0) AS VARCHAR(5)) + ')' END ELSE NULL END
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


--SORGU ÖRNEKLERÝ
--1)Tüm dersler arasýnda kalanlar öðrencileri getir (Ad-soyad-durum-bölüm adý,ders adý)
SELECT ob.OgrAd + ' ' + ob.OgrSoyad AS OgrenciAdiSoyadi,
	   bb.BolumAdi,
	   bd.DersAdý,
	   od.Durumu
FROM tblOgrenciBilgileri AS ob
	JOIN tblOgrenci_Ders AS od ON ob.OgrenciNo=od.OgrNo
	JOIN tblBolumDersleri AS bd ON od.DersNo=bd.DersKodu
	JOIN tblBolumBilgileri AS bb ON bd.BolumNo=bb.BolumNo
WHERE od.Durumu LIKE '%Kaldý%'
ORDER BY od.Durumu 

--2)tblBolumDersleri tablosundaki DersAdý kolon adýný DersAdi olarak deðiþtir
EXEC sp_rename 'dbo.tblBolumDersleri.DersAdý', 'DersAdi', 'COLUMN'; 

--3)Hangi bölümde kaç ders var listele
SELECT bb.BolumAdi AS [Bölüm Adý],
	COUNT(bd.DersAdi) AS [Ders Sayýsý]
FROM tblBolumBilgileri AS bb
	JOIN tblBolumDersleri AS bd ON bb.BolumNo=bd.BolumNo
GROUP BY bb.BolumAdi
ORDER BY COUNT(bd.DersAdi) DESC


--4)tblOgrenciIsleri tablosundaki soyadý Yolda olan personelin soyadýný Yoldaþ düzelt
UPDATE tblOgrenciIsleri SET PersonelSoyad='Yoldaþ' WHERE PersonelNo=3

--5)Havacýlýk Yönetimi bölümündeki öðrencileri listele
SELECT ob.OgrAd + ' ' + ob.OgrSoyad AS [Öðrenci Adý ve Soyadý],
	bb.BolumAdi AS [Bölüm Adý],
	bd.DersKodu AS [Ders Kodu],
	bd.DersAdi AS [Ders Adý]
FROM tblOgrenciBilgileri AS ob
	JOIN tblOgrenci_Ders AS od ON ob.OgrenciNo=od.OgrNo
	JOIN tblBolumDersleri AS bd ON od.DersNo=bd.DersKodu
	JOIN tblBolumBilgileri AS bb ON bd.BolumNo=bb.BolumNo
WHERE bb.BolumNo=1
ORDER BY bd.DersKodu
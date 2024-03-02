CREATE DATABASE SirketDB
GO

USE SirketDB
GO

--CREATE TABLES
CREATE TABLE il
(
il_no INT IDENTITY PRIMARY KEY,
il_ad VARCHAR(30) NOT NULL
)
GO
CREATE TABLE ilce
(
ilce_no INT IDENTITY PRIMARY KEY,
ilce_Ad VARCHAR(30),
il_no INT FOREIGN KEY REFERENCES il(il_no)
)
GO
CREATE TABLE unvan
(
unvan_no INT IDENTITY PRIMARY KEY,
unvan_ad VARCHAR(30) NOT NULL
)
GO
CREATE TABLE birim
(
birim_no INT IDENTITY PRIMARY KEY,
birim_ad VARCHAR(30) NOT NULL
)
GO
CREATE TABLE personel
(
personel_no INT IDENTITY PRIMARY KEY,
ad VARCHAR(30) NOT NULL,
soyad VARCHAR(30) NOT NULL,
cinsiyet VARCHAR(5),
dogum_tarihi DATE,
dogum_yeri INT FOREIGN KEY REFERENCES ilce(ilce_no),
baslama_tarihi DATE,
birim_no INT FOREIGN KEY REFERENCES birim(birim_no),
unvan_no INT FOREIGN KEY REFERENCES unvan(unvan_no),
calisma_saati INT,
maas MONEY NOT NULL,
prim MONEY
)
GO
CREATE TABLE cocuk
(
cocuk_no INT IDENTITY PRIMARY KEY,
ad VARCHAR(30) NOT NULL,
soyad VARCHAR(30) NOT NULL,
cinsiyet VARCHAR(5),
dogum_tarihi DATE,
dogum_yeri INT FOREIGN KEY REFERENCES ilce(ilce_no),
personel_no INT FOREIGN KEY REFERENCES personel(personel_no)
)
GO 
CREATE TABLE proje
(
proje_no INT IDENTITY PRIMARY KEY,
proje_ad VARCHAR(50) NOT NULL,
baslama_tarihi DATE,
planlanan_bitis_tarihi DATE
)
GO 
CREATE TABLE gorevlendirme
(
gorevlendirme_no INT IDENTITY PRIMARY KEY,
proje_no INT FOREIGN KEY REFERENCES proje(proje_no),
personel_no INT FOREIGN KEY REFERENCES personel(personel_no)
)
GO

--INSERTS
INSERT INTO il (il_ad)
VALUES ('Adana'), ('Ankara'), ('Ýstanbul'), ('Ýzmir'), ('Bursa'), ('Antalya'), ('Eskiþehir'), ('Trabzon'), ('Diyarbakýr'), ('Konya')
GO
INSERT INTO ilce(ilce_Ad, il_no)
VALUES ('Seyhan', 1), ('Yüreðir', 1), ('Sarýçam', 1), ('Çukurova', 1), ('Karaisalý', 1),
	('Çankaya', 2), ('Keçiören', 2), ('Yenimahalle', 2), ('Mamak', 2), ('Etimesgut', 2),
	('Beyoðlu', 3), ('Kadýköy', 3), ('Beþiktaþ', 3), ('Üsküdar', 3), ('Þiþli', 3),
	('Konak', 4), ('Karþýyaka', 4), ('Bornova', 4), ('Buca', 4), ('Çiðli', 4),
	('Osmangazi', 5), ('Nilüfer', 5), ('Yýldýrým', 5), ('Gürsu', 5), ('Mudanya', 5),
	('Muratpaþa', 6), ('Kepez', 6), ('Konyaaltý', 6), ('Lara', 6), ('Aksu', 6),
	('Odunpazarý', 7), ('Tepebaþý', 7), ('Çankaya', 7), ('Yunus Emre', 7), ('Seyitgazi', 7),
	('Ortahisar', 8), ('Akçaabat', 8), ('Araklý', 8), ('Yomra', 8), ('Maçka', 8),
	('Baðlar', 9), ('Kayapýnar', 9), ('Yeniþehir', 9), ('Sur', 9), ('Kayapýnar', 9),
	('Meram', 10), ('Selçuklu', 10), ('Karatay', 10), ('Ereðli', 10), ('Akþehir', 10)
GO
INSERT INTO unvan(unvan_ad)
VALUES ('Müdür'), ('Mühendis'), ('Asistan'), ('Uzman'), ('Analist'), ('Koordinatör'), ('Danýþman'), ('Yönetici'), ('Teknisyen'), ('Avukat')
GO	
INSERT INTO birim(birim_ad)
VALUES ('Ýnsan Kaynaklarý'), ('Pazarlama'), ('Satýþ'), ('Finans'), ('Bilgi Teknolojileri'), ('Üretim'), ('Ar-Ge'), ('Halkla Ýliþkiler'), ('Lojistik'), ('Müþteri Hizmetleri')
GO	
INSERT INTO personel(ad, soyad, cinsiyet, dogum_tarihi, dogum_yeri, baslama_tarihi, birim_no, unvan_no, calisma_saati, maas, prim)
VALUES ('Ali','Veli', 'Erkek', '2001-12-19', 1, '2022-08-15', 1, 3, 9, 30000, NULL),
	('Mehmet','Akþen', 'Erkek', '1994-01-11', 15, '2020-04-02', 3, 4,9, 35000, NULL),
	('Ebru','Yerli', 'Kadýn', '1996-07-19', 24, '2021-05-12', 10, 8, 9, 45000, 7000),
	('Emre','Türk', 'Erkek', '1991-06-12', 33, '2018-04-01', 5, 6, 9, 110000, 12000),
	('Buse','Yardým', 'Kadýn', '1994-05-12', 47, '2023-07-09', 6, 2, 9, 70000, 7500) 
GO
INSERT INTO cocuk(ad, soyad, cinsiyet, dogum_tarihi, dogum_yeri, personel_no)
VALUES ('Poyraz', 'Yýldýrým', 'Erkek', '2001-12-19', 4, 1),
	('Azra', 'Soydaþ', 'Kadýn', '2011-12-21', 12, 3),
	('Zeynep', 'Aksu', 'Kadýn', '2012-01-14', 16, 4),
	('Uraz', 'Þen', 'Erkek', '2010-09-25', 28, 2),
	('Ayþe', 'Sönmez', 'Kadýn', '2009-11-07', 21, 5),
	('Melek', 'Þen', 'Kadýn', '2013-07-13', 32, 1),
	('Demir Alp', 'Altun', 'Erkek', '2012-08-16', 41, 4),
	('Ece', 'Ayman', 'Kadýn', '2010-06-04', 2, 3),
	('Berkay', 'Narin', 'Erkek', '2013-02-23', 10, 2),
	('Melis', 'Koç', 'Kadýn', '2011-03-04', 18, 5)
GO
INSERT INTO proje(proje_ad, baslama_tarihi, planlanan_bitis_tarihi)
VALUES ('Kariyer Yolculuðu Haritasý', '2022-09-15','2023-04-15'),
	('Dijital Dönüþüm Stratejileri', '2021-11-19', '2022-12-31'),
	('Satýþ Yönetimi Ýzleme ve Analiz Sistemi', '2023-12-31', '2024-02-29'),
	('Gelecek Ýçin Yatýrým', '2023-01-01', '2023-12-31'),
	('Kodlama Köprüsü', '2022-03-11', '2022-03-11'),
	('Akýllý Fabrika', '2022-05-02', '2023-01-01'),
	('Ýnovasyon Laboratuvarý', '2019-12-01', '2022-01-31'),
	('Dijital Marka Ýmajý', '2023-04-30', '2023-08-01'),
	('Akýllý Tedarik Zinciri', '2024-01-29', '2024-02-28'),
	('Mükemmeliyet Merkezi', '2020-12-28', '2021-04-15')
GO
INSERT INTO gorevlendirme(proje_no, personel_no)
VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 1), (7, 2), (8, 3), (9, 4), (10, 5)
GO

--SELECTS
SELECT * FROM il
SELECT * FROM ilce
SELECT * FROM unvan
SELECT * FROM birim
SELECT * FROM personel
SELECT * FROM cocuk
SELECT * FROM proje
SELECT * FROM gorevlendirme

--SORGULAR
--1) Personel Bilgilerini Listeleme Sorgusu
SELECT ad, soyad, cinsiyet, dogum_tarihi, 
	il.il_ad AS dogum_yeri, 
	b.birim_ad AS birim, 
	u.unvan_ad AS unvan
FROM personel AS p
	JOIN ilce ON p.dogum_yeri=ilce.ilce_no
	JOIN il ON ilce.il_no=il.il_no
	JOIN birim AS b ON p.birim_no=b.birim_no
	JOIN unvan AS u ON u.unvan_no=p.unvan_no
ORDER BY ad, soyad

--2) Proje Bilgileri ve Ýlgili Personel Sayýsý
SELECT p.proje_ad,
	p.baslama_tarihi, 
	p.planlanan_bitis_tarihi, 
	COUNT(g.personel_no) AS personel_sayisi
FROM proje AS p
	LEFT JOIN gorevlendirme AS g ON p.proje_no=g.proje_no
GROUP BY p.proje_ad, p.baslama_tarihi, p.planlanan_bitis_tarihi
ORDER BY p.proje_ad

--3) Belirli Bir Birimde Çalýþan Personel Listesi
SELECT ad, 
	soyad, 
	cinsiyet, 
	dogum_tarihi, 
	il.il_ad + '(' + ilce.ilce_Ad + ')' AS dogum_yeri, 
	u.unvan_ad AS unvan 
FROM personel AS p
	JOIN ilce ON p.dogum_yeri=ilce.ilce_no
	JOIN il ON il.il_no=ilce.il_no
	JOIN unvan AS u ON p.unvan_no=u.unvan_no
	JOIN birim AS brm ON p.birim_no=brm.birim_no
WHERE brm.birim_ad='Ýnsan Kaynaklarý'

--4) Prim Almayan Personellerin Listesi (Bilgileri ile birlikte)
SELECT ad, 
	soyad, 
	cinsiyet, 
	dogum_tarihi, 
	il.il_ad + '(' + ilce.ilce_Ad + ')' AS dogum_yeri, 
	brm.birim_ad AS birim, 
	u.unvan_ad AS unvan
FROM personel AS p 
	JOIN ilce ON p.dogum_yeri=ilce.ilce_no
	JOIN il ON il.il_no=ilce.il_no
	JOIN birim AS brm ON p.birim_no=brm.birim_no
	JOIN unvan AS u ON p.unvan_no=u.unvan_no
WHERE prim IS NULL
ORDER BY dogum_tarihi

--5) Personellerin yaþlarýný hesapla(ad-soyad,yaþ,birim)
SELECT ad,
	soyad,
	brm.birim_ad,
	DATEDIFF(YEAR, dogum_tarihi, GETDATE()) AS yas
FROM personel AS p
	JOIN birim AS brm ON p.birim_no=brm.birim_no
ORDER BY yas DESC


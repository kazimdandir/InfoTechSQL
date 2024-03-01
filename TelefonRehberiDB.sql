CREATE DATABASE TelefonRehberiDB
GO

USE TelefonRehberiDB
GO

--CREATE TABLES
CREATE TABLE TIller 
(
il_no INT IDENTITY PRIMARY KEY,
il VARCHAR(30) NOT NULL
)
GO

CREATE TABLE TIlceler
(
ilce_no INT IDENTITY PRIMARY KEY,
il_no INT FOREIGN KEY REFERENCES TIller(il_no),
ilce VARCHAR(30)
)
GO

CREATE TABLE TVDaireleri
(
vd_id INT IDENTITY PRIMARY KEY,
vd_il INT FOREIGN KEY REFERENCES TIller(il_no),
vd_kod INT NOT NULL,
vd_ad VARCHAR(MAX)
)
GO

CREATE TABLE TKisiler
(
kimlik INT IDENTITY PRIMARY KEY,
Adi VARCHAR(30),
Soyadi VARCHAR(30),
tc_no VARCHAR(11) NOT NULL,
Sirket NVARCHAR(MAX),
Unvan VARCHAR(50),
Adres NVARCHAR(MAX),
ilce INT FOREIGN KEY REFERENCES TIlceler(ilce_no),
il INT FOREIGN KEY REFERENCES TIller(il_no),
PostaKodu INT,
Bolge VARCHAR(50),
ulke VARCHAR(30),
Eposta NVARCHAR(50),
notlar NVARCHAR(MAX),
VergiDairesi INT FOREIGN KEY REFERENCES TVDaireleri(vd_id),
VergiNumarasi VARCHAR(10),
resim IMAGE,
kisimi BIT
)
GO

CREATE TABLE TTelefonTip
(
t_tip_id INT IDENTITY PRIMARY KEY,
ttip VARCHAR(20)
)
GO

CREATE TABLE TTelefon
(
t_id INT IDENTITY PRIMARY KEY,
t_tip INT FOREIGN KEY REFERENCES TTelefonTip(t_tip_id),
tel VARCHAR(9),
dahili VARCHAR(4),
rehber_adi INT FOREIGN KEY REFERENCES TKisiler(kimlik) 
)
GO

--INSERTS
INSERT INTO TIller(il)
VALUES ('Adana'), ('Ankara'), ('Ýstanbul'), ('Ýzmir'), ('Bursa'), ('Antalya'), ('Eskiþehir'), ('Trabzon'), ('Diyarbakýr'), ('Konya')
GO

INSERT INTO TIlceler(ilce, il_no)
VALUES ('Seyhan', 1), ('Yüreðir', 1), ('Sarýçam', 1), ('Çukurova', 1), ('Karaisalý', 1), -- 1-5
	('Çankaya', 2), ('Keçiören', 2), ('Yenimahalle', 2), ('Mamak', 2), ('Etimesgut', 2), -- 6-10
	('Beyoðlu', 3), ('Kadýköy', 3), ('Beþiktaþ', 3), ('Üsküdar', 3), ('Þiþli', 3), -- 11-15
	('Konak', 4), ('Karþýyaka', 4), ('Bornova', 4), ('Buca', 4), ('Çiðli', 4), -- 16-20
	('Osmangazi', 5), ('Nilüfer', 5), ('Yýldýrým', 5), ('Gürsu', 5), ('Mudanya', 5), -- 21-25
	('Muratpaþa', 6), ('Kepez', 6), ('Konyaaltý', 6), ('Lara', 6), ('Aksu', 6), -- 26-30
	('Odunpazarý', 7), ('Tepebaþý', 7), ('Çankaya', 7), ('Yunus Emre', 7), ('Seyitgazi', 7), -- 31-35
	('Ortahisar', 8), ('Akçaabat', 8), ('Araklý', 8), ('Yomra', 8), ('Maçka', 8), -- 36-40
	('Baðlar', 9), ('Kayapýnar', 9), ('Yeniþehir', 9), ('Sur', 9), ('Kayapýnar', 9), -- 41-45
	('Meram', 10), ('Selçuklu', 10), ('Karatay', 10), ('Ereðli', 10), ('Akþehir', 10) -- 46-50
GO

INSERT INTO TVDaireleri(vd_il, vd_kod, vd_ad)
VALUES (1, 3372176, 'Seyhan Vergi Dairesi Baþkanlýðý'),
	(2, 5743198, 'Çankaya Vergi Dairesi Baþkanlýðý'),
	(3, 15895841, 'Þiþli Vergi Dairesi Baþkanlýðý'),
	(4, 4394139, 'Konak Vergi Dairesi Baþkanlýðý'),
	(5, 3202834, 'Osmangazi Vergi Dairesi Baþkanlýðý'),
	(6, 2632031, 'Muratpaþa Vergi Dairesi Baþkanlýðý'),
	(7, 880355, 'Odunpazarý Vergi Dairesi Baþkanlýðý'),
	(8, 783721, 'Ortahisar Vergi Dairesi Baþkanlýðý'),
	(9, 1789534, 'Kayapýnar Vergi Dairesi Baþkanlýðý'),
	(10, 2233234, 'Meram Vergi Dairesi Baþkanlýðý')
GO

INSERT INTO TKisiler(Adi, Soyadi, tc_no, Sirket, Unvan, Adres, ilce, il, PostaKodu, Bolge, ulke, Eposta, notlar, VergiDairesi, VergiNumarasi, resim, kisimi)
VALUES ('Ali', 'Veli', 78945612345, 'Ekol Yazýlým', 'Full Stack Developer', 'Gökkuyu Mahallesi, 216. Sk. No:14', 4, 1, 01170, 'Akdeniz', 'Türkiye', 'ali.veli@mail.com', 'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...', 1, 0774824520, 'D:\Infotech_Academy\InfoTechSQLDersi\SirketDB_image_developer.jpeg', 1),
	('Mehmet', 'Akþen', 30291876504, 'Bilimsel Enerji Çözümleri', 'Pazarlama Müdürü', 'Dikmen Mahallesi, 100. Yýl Bulvarý No:10/A', 6, 2, 06530, 'Ýç Anadolu', 'Türkiye', 'mehmet.aksen@mail.com', NULL, 2, 4115702411, 'D:\Infotech_Academy\InfoTechSQLDersi\SirketDB_image_marketingManager.jpg', 1),
	('Ebru', 'Yerli', 92837465109, 'Ufuk Lojistik', 'Lojistik Direktörü', 'Hacýveyiszade Mahallesi, 56. Sk. No:5/B', 47, 10, 42030, 'Ýç Anadolu', 'Türkiye', 'ebru.yerli@mail.com', 'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...', 10, 2348228232, NULL, 1),
	('Buse', 'Yardým', 56102938746, 'Meltem Medya', 'Reklam Koordinatörü', 'Karþýyaka Mahallesi, Atatürk Caddesi No:101', 17, 4, 35600, 'Ege', 'Türkiye', 'buse.yardim@mail.com', NULL, 4, 8514112398, NULL, 1)
GO

INSERT INTO TTelefonTip(ttip)
VALUES ('Sabit Hat'), ('Mobil Hat')
GO

INSERT INTO TTelefon(t_tip, tel, dahili, rehber_adi)
VALUES (1, '123 45 67', '0322', 1),
	(2, '234 56 78', '0542', 2),
	(2, '345 67 89', '0552', 3),
	(1, '345 67 89', '0232', 4)
GO

--SORGULAR
--1) Tüm kiþi bilgilerini getir
SELECT k.kimlik,
	k.Adi,
	k.Soyadi,
	k.tc_no, 
	k.Sirket,
	k.Unvan,
	k.Adres,
	ilc.ilce AS ilce,
	i.il AS il,
	k.PostaKodu,
	k.Eposta,
	vd.vd_ad AS VergiDairesi,
	k.VergiNumarasi,
	t.dahili + ' ' + t.tel AS telefon
FROM TKisiler AS k
	INNER JOIN TIller AS i ON k.il=i.il_no
	INNER JOIN TIlceler AS ilc ON i.il_no=ilc.il_no 
		AND k.ilce=ilc.ilce_no
	INNER JOIN TVDaireleri AS vd ON k.VergiDairesi=vd.vd_id
	INNER JOIN TTelefon AS t ON k.kisimi=t.rehber_adi
GROUP BY k.kimlik,
	k.Adi, 
	k.Soyadi, 
	k.tc_no,
	k.Sirket,
	k.Unvan,
	k.Adres,
	ilc.ilce,
	i.il,
	k.PostaKodu,
	k.Eposta,
	vd.vd_ad,
	k.VergiNumarasi,
	t.dahili,
	t.tel
ORDER BY k.Adi, k.Soyadi

--2) "Ege" bölgesinde yaþayan ve "Reklam" sektöründe çalýþan kiþilerin adlarýný, soyadlarýný, illerini, ilçelerini ve telefon numaralarýný listeleyin.
SELECT k.Adi,
	k.Soyadi,
	i.il,
	ilc.ilce,
	t.dahili + ' ' + t.tel AS telefon
FROM TKisiler AS k 
	INNER JOIN TTelefon AS t ON k.kimlik=t.rehber_adi
	INNER JOIN TIlceler AS ilc ON k.ilce=ilc.ilce_no
	INNER JOIN TIller AS i ON ilc.il_no=i.il_no
WHERE k.Bolge='Ege'
	AND k.Sirket LIKE '%Medya%'
GROUP BY k.Adi,
	k.Soyadi,
	i.il,
	ilc.ilce,
	t.dahili,
	t.tel

--3) "Ýzmir" ilinde yaþayan ve "Vergi Dairesi" adý "Konak Vergi Dairesi Baþkanlýðý" olan kiþilerin adýný, soyadýný, þirketini, vergi dairesi adýný ve vergi numarasýný listeleyin.
SELECT k.Adi,
	k.Soyadi,
	k.Sirket,
	vd.vd_ad AS VergiDairesi,
	k.VergiNumarasi
FROM TKisiler AS k
	INNER JOIN TIller AS i ON k.il=i.il_no
	INNER JOIN TVDaireleri AS vd ON k.VergiDairesi=vd.vd_id
WHERE i.il='Ýzmir' 
	AND vd.vd_ad='Konak Vergi Dairesi Baþkanlýðý'

--4) "Ankara" ilinde yaþayan ve "Mobil Hat" telefon numarasý olan kiþilerin illerini, telefon numaralarýný, posta kodlarýný ve e-posta adreslerini listeleyin. Ek olarak kaç kiþi olduðunu bulun
SELECT k.Adi,
	k.Soyadi, 
	i.il,
	t.dahili + ' ' + t.tel AS tel,
	k.PostaKodu,
	k.Eposta,
	COUNT(k.Adi) AS KisiSayisi
FROM TKisiler AS k
	INNER JOIN TIller AS i ON k.il=i.il_no
	INNER JOIN TTelefon AS t ON k.kimlik=t.rehber_adi
WHERE i.il_no=2 
	AND t.t_tip=2
GROUP BY k.Adi,
	k.Soyadi,
	i.il, 
	t.dahili,
	t.tel,
	k.PostaKodu,
	k.Eposta

--5) "Adana" ilinde yaþayan ve "Ekol Yazýlým" þirketinde çalýþan kiþilerin adlarýný, soyadlarýný ve unvanlarýný listeleyin.
SELECT k.Adi,
	k.Soyadi,
	k.Unvan
FROM TKisiler AS k
	INNER JOIN TIller AS i ON k.il=i.il_no
WHERE i.il='Adana'
	AND k.Sirket='Ekol Yazýlým'
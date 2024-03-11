CREATE DATABASE DersProgramiDB
GO

USE DersProgramiDB
GO

--TABLES
CREATE TABLE Ogretmen
(
OgretmenID INT IDENTITY PRIMARY KEY,
OgretmenAdi NVARCHAR(30),
OgretmenSoyadi NVARCHAR(30)
)
GO

CREATE TABLE Gun
(
GunID INT IDENTITY PRIMARY KEY,
GunAdi NCHAR(9)
)
GO

CREATE TABLE Ders
(
DersID INT IDENTITY PRIMARY KEY,
DersAdi NVARCHAR(50),
HaftalikDersSaati TINYINT
)
GO

CREATE TABLE Sinif
(
SinifID NCHAR(4) NOT NULL,
DersID INT FOREIGN KEY REFERENCES Ders(DersID),
OgretmenID INT FOREIGN KEY REFERENCES Ogretmen(OgretmenID),
GunID INT FOREIGN KEY REFERENCES Gun(GunID)
)
GO

CREATE TABLE Ogrenci
(
OgrenciID INT IDENTITY PRIMARY KEY,
OgrenciAdi NVARCHAR(30),
OgrenciSoyadi NVARCHAR(30),
SinifID NCHAR(4),
)
GO

--INSERTS
INSERT INTO Ogretmen(OgretmenAdi, OgretmenSoyadi)
VALUES ('Ayşe', 'Yılmaz')
	,('Mehmet', 'Kaya')
	,('Fatma', 'Şahin')
	,('Ali', 'Çelik')
	,('Zeynep', 'Demir')
	,('Mustafa', 'Arslan')
	,('Esra', 'Öztürk')
	,('Ahmet', 'Yıldırım')
	,('Sema', 'Aksoy')
	,('Emre', 'Erdoğan')
	,('Ceyda', 'Yılmazer')
	,('Serkan', 'Taşkın')
	,('Şeyma', 'Koçyiğit')
	,('Zeynep', 'Yıldırım')
	,('Mustafa', 'Aydın')
	,('Esra', 'Özdemir')
	,('Emre', 'Çelik')
	,('Selin', 'Arslan')
	,('Burak', 'Öztürk')
	,('Seda', 'Kurtuluş')
	,('Can', 'Kocaman')
	,('Ebru', 'Erdoğdu')
	,('Onur', 'Şahin')
	,('Elif', 'Karagöz')
	,('Berk', 'Köse')
	,('Deniz', 'Korkmaz')
	,('Aslı', 'Aksoy')
	,('Tolga', 'Çetin')
	,('İrem', 'Yıldız')
	,('Cem', 'Bulut')
GO

INSERT INTO Gun(GunAdi)
VALUES ('Pazartesi'), ('Salı'), ('Çarşamba'), ('Perşembe'), ('Cuma')
GO

INSERT INTO Ders(DersAdi, HaftalikDersSaati)
VALUES ('Türk Dili ve Edebiyatı', 5)  
	,('Din Kültürü ve Ahlak Bilgisi', 2) 
	,('Tarih', 2) 
	,('Coğrafya', 2) 
	,('Matematik', 6) 
	,('Fizik', 2) 
	,('Kimya', 2) 
	,('Biyoloji', 5) 
	,('Birinci Yabancı Dil', 4) 
	,('İkinci Yabancı Dil', 2)
	,('Beden Eğitimi ve Spor', 2)
	,('Görsel Sanatlar/Müzik', 2)
	,('Sağlık Bilgisi ve Trafik Kültürü', 1)
	,('Kulüp ve Etkinlik', 6)
GO

INSERT INTO Sinif(SinifID, DersID, OgretmenID, GunID)
VALUES 
--9A
	--Pazartesi
	('9A', 1, 1, 1), ('9A', 1, 1, 1), ('9A', 5, 9, 1),('9A', 5, 9, 1), ('9A', 14, 26, 1), ('9A', 9, 18, 1), ('9A', 9, 18, 1), ('9A', 2, 6, 1),
	--Salı
	('9A', 3, 7, 2), ('9A', 3, 7, 2), ('9A', 6, 15, 2), ('9A', 6, 15, 2), ('9A', 10, 18, 2), ('9A', 10, 18, 2), ('9A', 14, 26, 2), ('9A', 13, 25, 2),
	--Çarşamba
	('9A', 5, 9, 3), ('9A', 5, 9, 3), ('9A', 12, 24, 3),('9A', 12, 24, 3), ('9A', 4, 8, 3), ('9A', 4, 8, 3), ('9A', 2, 6, 3), ('9A', 14, 26, 3),
	--Perşembe
	('9A', 1, 1, 4), ('9A', 1, 1, 4), ('9A', 7, 16, 4),('9A', 7, 16, 4), ('9A', 14, 26, 4), ('9A', 14, 26, 4), ('9A', 11, 23, 4), ('9A', 11, 23, 4),
	--Cuma
	('9A', 5, 14, 5), ('9A', 5, 14, 5), ('9A', 14, 26, 5),('9A', 8, 17, 5), ('9A', 8, 17, 5), ('9A', 1, 1, 5), ('9A', 9, 18, 5), ('9A', 9, 18, 5),
--9B
	--Pazartesi
	('9B', 5, 9, 1), ('9B', 5, 9, 1), ('9B', 3, 7, 1),('9B', 3, 7, 1), ('9B', 12, 24, 1), ('9B', 12, 24, 1), ('9B', 13, 25, 1), ('9B', 14, 26, 1),
	--Salı
	('9B', 7, 16, 2), ('9B', 7, 16, 2), ('9B', 1, 1, 2),('9B', 1, 1, 2), ('9B', 2, 6, 2), ('9B', 2, 6, 2), ('9B', 9, 18, 2), ('9B', 9, 18, 2),
	--Çarşamba
	('9B', 4, 8, 3), ('9B', 4, 8, 3), ('9B', 5, 9, 3),('9B', 5, 9, 3), ('9B', 11, 23, 3), ('9B', 11, 23, 3), ('9B', 14, 27, 3), ('9B', 14, 27, 3),
	--Perşembe
	('9B', 8, 17, 4), ('9B', 8, 17, 4), ('9B', 1, 1, 4), ('9B', 14, 26, 4), ('9B', 1, 4, 4), ('9B', 1, 4, 4), ('9B', 9, 18, 4), ('9B', 9, 18, 4),
	--Cuma
	('9B', 5, 13, 5), ('9B', 5, 13, 5), ('9B', 10, 18, 5),('9B', 10, 18, 5), ('9B', 6, 15, 5), ('9B', 6, 15, 5), ('9B', 14, 26, 5), ('9B', 14, 26, 5),
--9C
	--Pazartesi
	('9C', 9, 18, 1), ('9C', 9, 18, 1), ('9C', 5, 10, 1),('9C', 5, 10, 1), ('9C', 1, 1, 1), ('9C', 1, 1, 1), ('9C', 14, 27, 1), ('9C', 13, 25, 1),
	--Salı
	('9C', 5, 9, 2), ('9C', 5, 9, 2), ('9C', 14, 26, 2),('9C', 14, 26, 2), ('9C', 6, 15, 2), ('9C', 6, 15, 2), ('9C', 3, 7, 2), ('9C', 3, 7, 2),
	--Çarşamba
	('9C', 1, 5, 3), ('9C', 1, 5, 3), ('9C', 7, 16, 3),('9C', 7, 16, 3), ('9C', 12, 24, 3), ('9C', 14, 28, 3), ('9C', 11, 23, 3), ('9C', 11, 23, 3), 
	--Perşembe
	('9C', 9, 18, 4), ('9C', 9, 18, 4), ('9C', 8, 17, 4),('9C', 8, 17, 4), ('9C', 12, 24, 4), ('9C', 4, 8, 4), ('9C', 4, 8, 4), ('9C', 14, 26, 4),
	--Cuma
	('9C', 10, 19, 5), ('9C', 10, 19, 5), ('9C', 5, 9, 5),('9C', 5, 9, 5), ('9C', 14, 26, 5), ('9C', 2, 6, 5), ('9C', 2, 6, 5), ('9C', 1, 2, 5),
--10A
	--Pazartesi
	('10A', 13, 25, 1), ('10A', 10, 19, 1), ('10A', 5, 11, 1),('10A', 5, 11, 1), ('10A', 2, 6, 1), ('10A', 6, 15, 1), ('10A', 6, 15, 1), ('10A', 1, 2, 1),
	--Salı
	('10A', 5, 10, 2), ('10A', 5, 10, 2), ('10A', 1, 2, 2),('10A', 1, 2, 2), ('10A', 10, 19, 2), ('10A', 8, 17, 2), ('10A', 8, 17, 2), ('10A', 9, 19, 2),
	--Çarşamba
	('10A', 12, 24, 3), ('10A', 12, 24, 3), ('10A', 14, 26, 3),('10A', 14, 26, 3), ('10A', 1, 2, 3), ('10A', 7, 16, 3), ('10A', 7, 16, 3), ('10A', 9, 18, 3),
	--Perşembe
	('10A', 11, 23, 4), ('10A', 11, 23, 4), ('10A', 5, 9, 4),('10A', 5, 9, 4), ('10A', 1, 5, 4), ('10A', 3, 7, 4), ('10A', 3, 7, 4), ('10A', 14, 27, 4),
	--Cuma
	('10A', 14, 26, 5), ('10A', 14, 26, 5), ('10A', 4, 8, 5),('10A', 4, 8, 5), ('10A', 2, 6, 5), ('10A', 9, 19, 5), ('10A', 9, 19, 5), ('10A', 14, 27, 5),
--10B
	--Pazartesi
	('10B', 9, 20, 1), ('10B', 5, 10, 1), ('10B', 6, 15, 1),('10B', 6, 15, 1), ('10B', 1, 3, 1), ('10B', 2, 6, 1), ('10B', 2, 6, 1), ('10B', 9, 19, 1),
	--Salı
	('10B', 5, 11, 2), ('10B', 12, 24, 2), ('10B', 12, 24, 2),('10B', 3, 7, 2), ('10B', 3, 7, 2), ('10B', 1, 4, 2), ('10B', 1, 4, 2), ('10B', 14, 27, 2),
	--Çarşamba
	('10B', 14, 27, 3), ('10B', 5, 10, 3), ('10B', 4, 8, 3),('10B', 4, 8, 3), ('10B', 14, 29, 3), ('10B', 14, 29, 3), ('10B', 10, 19, 3), ('10B', 10, 19, 3),
	--Perşembe
	('10B', 5, 14, 4), ('10B', 5, 14, 4), ('10B', 11, 23, 4),('10B', 1, 1, 4), ('10B', 1, 1, 4), ('10B', 11, 23, 4), ('10B', 9, 19, 4), ('10B', 9, 19, 4),
	--Cuma
	('10B', 5, 12, 5), ('10B', 14, 27, 5), ('10B', 14, 27, 5),('10B', 7, 16, 5), ('10B', 7, 16, 5), ('10B', 8, 17, 5), ('10B', 8, 17, 5), ('10B', 13, 25, 5),
--10C
	--Pazartesi
	('10C', 5, 11, 1), ('10C', 1, 5, 1), ('10C', 8, 17, 1),('10C', 8, 16, 1), ('10C', 14, 27, 1), ('10C', 14, 27, 1), ('10C', 9, 20, 1), ('10C', 9, 20, 1),
	--Salı
	('10C', 5, 12, 2), ('10C', 11, 23, 2), ('10C', 2, 6, 2),('10C', 11, 23, 2), ('10C', 14, 27, 2), ('10C', 1, 1, 2), ('10C', 6, 15, 2), ('10C', 6, 15, 2),
	--Çarşamba
	('10C', 5, 11, 3), ('10C', 5, 11, 3), ('10C', 1, 1, 3),('10C', 3, 7, 3), ('10C', 14, 27, 3), ('10C', 14, 27, 3), ('10C', 10, 20, 3), ('10C', 10, 20, 3),
	--Perşembe
	('10C', 5, 13, 4), ('10C', 1, 2, 4), ('10C', 14, 28, 4),('10C', 4, 8, 4), ('10C', 4, 8, 4), ('10C', 12, 24, 4), ('10C', 12, 24, 4), ('10C', 2, 6, 4),
	--Cuma
	('10C', 7, 16, 5), ('10C', 7, 16, 5), ('10C', 5, 10, 5),('10C', 9, 20, 5), ('10C', 9, 20, 5), ('10C', 3, 7, 5), ('10C', 13, 25, 5), ('10C', 1, 3, 5),
--11A
	--Pazartesi
	('11A', 2, 6, 1), ('11A', 2, 6, 1), ('11A', 5, 12, 1),('11A', 5, 12, 1), ('11A', 14, 28, 1), ('11A', 14, 28, 1), ('11A', 4, 8, 1), ('11A', 4, 8, 1),
	--Salı
	('11A', 5, 13, 2), ('11A', 5, 13, 2), ('11A', 1, 3, 2),('11A', 1, 3, 2), ('11A', 7, 16, 2), ('11A', 12, 24, 2), ('11A', 12, 24, 2), ('11A', 9, 20, 2),
	--Çarşamba
	('11A', 14, 25, 3), ('11A', 14, 25, 3), ('11A', 5, 10, 3),('11A', 5, 10, 3), ('11A', 1, 3, 3), ('11A', 1, 3, 3), ('11A', 6, 15, 3), ('11A', 6, 15, 3),
	--Perşembe
	('11A', 14, 29, 4), ('11A', 14, 29, 4), ('11A', 13, 25, 4),('11A', 11, 23, 4), ('11A', 11, 23, 4), ('11A', 7, 16, 4), ('11A', 9, 20, 4), ('11A', 9, 20, 4),
	--Cuma
	('11A', 8, 17, 5), ('11A', 8, 17, 5), ('11A', 10, 21, 5),('11A', 10, 21, 5), ('11A', 1, 1, 5), ('11A', 9, 22, 5), ('11A', 3, 7, 5), ('11A', 3, 7, 5),
--11B
	--Pazartesi
	('11B', 6, 15, 1), ('11B', 6, 15, 1), ('11B', 11, 23, 1),('11B', 14, 29,  1), ('11B', 14, 29, 1), ('11B', 9, 21, 1), ('11B', 9, 21, 1), ('11B', 3, 7, 1),
	--Salı
	('11B', 8, 17, 2), ('11B', 8, 17, 2), ('11B', 11, 23, 2),('11B', 14, 28, 2), ('11B', 14, 28, 2), ('11B', 9, 21, 2), ('11B', 9, 21, 2), ('11B', 1, 2, 2),
	--Çarşamba
	('11B', 5, 12, 3), ('11B', 5, 12, 3), ('11B', 1, 4, 3),('11B', 1, 4, 3), ('11B', 14, 28, 3), ('11B', 14, 28, 3), ('11B', 12, 24, 3), ('11B', 12, 24, 3),
	--Perşembe
	('11B', 5, 12, 4), ('11B', 5, 12, 4), ('11B', 1, 3, 4),('11B', 13, 25, 4), ('11B', 2, 6, 4), ('11B', 2, 6, 4), ('11B', 7, 16, 4), ('11B', 7, 16, 4),
	--Cuma
	('11B', 5, 11, 5), ('11B', 5, 11, 5), ('11B', 3, 7, 5),('11B', 1, 4, 5), ('11B', 4, 8, 5), ('11B', 4, 8, 5), ('11B', 10, 20, 5), ('11B', 10, 20, 5),
--11C
	--Pazartesi
	('11C', 1, 3, 1), ('11C', 5, 13, 1), ('11C', 1, 3, 1),('11C', 5, 13, 1), ('11C', 8, 17, 1), ('11C', 8, 17, 1), ('11C', 11, 23, 1), ('11C', 11, 23, 1),
	--Salı
	('11C', 5, 14, 2), ('11C', 5, 14, 2), ('11C', 14, 29, 2),('11C', 14, 29, 2), ('11C', 1, 4, 2), ('11C', 1, 4, 2), ('11C', 9, 22, 2), ('11C', 10, 22, 2),
	--Çarşamba
	('11C', 5, 13, 3), ('11C', 5, 13, 3), ('11C', 14, 30, 3),('11C', 10, 22, 3), ('11C', 9, 21, 3), ('11C', 12, 24, 3), ('11C', 3, 7, 3), ('11C', 3, 7, 3),
	--Perşembe
	('11C', 4, 8, 4),('11C', 4, 8, 4), ('11C', 2, 6, 4), ('11C', 2, 6, 4), ('11C', 9, 21, 4), ('11C', 9, 21, 4), ('11C', 14, 30, 4), ('11C', 12, 24, 4),
	--Cuma
	('11C', 6, 15, 5), ('11C', 6, 15, 5), ('11C', 14, 30, 5),('11C', 14, 30, 5), ('11C', 13, 25, 5), ('11C', 7, 16, 5), ('11C', 7, 16, 5), ('11C', 1, 5, 5)
GO

INSERT INTO Ogrenci(OgrenciAdi, OgrenciSoyadi, SinifID)
VALUES 
--9A
	('Ali', 'Veli', '9A'), ('Ayşe', 'Fatma', '9A'), ('Mehmet', 'Ahmet', '9A'), ('Aslı', 'Selin', '9A'), ('Emre', 'Can', '9A'), ('Deniz', 'Cem', '9A'), ('Ece', 'Elif', '9A'), ('Berk', 'Efe', '9A'),	('Nazlı', 'Yılmaz', '9A'), ('Gamze', 'Kemal', '9A'), ('Burak', 'Zeynep', '9A'), ('Seda', 'Melis', '9A'), ('Yusuf', 'Hasan', '9A'), ('Zeynep', 'Derya', '9A'), ('Ahmet', 'Murat', '9A'),
--9B
	('Ayşe', 'Kadir', '9B'), ('Mustafa', 'Fatma', '9B'), ('Ahmet', 'Özlem', '9B'), ('Zeynep', 'Mehmet', '9B'), ('Fatma', 'Deniz', '9B'), ('Emre', 'Seda', '9B'), ('Elif', 'Berk', '9B'), ('Efe', 'Aylin', '9B'), ('Selin', 'Barış', '9B'), ('Ege', 'Nazlı', '9B'), ('Ebru', 'Mehmet', '9B'), ('Şeyma', 'Mert', '9B'), ('Onur', 'Selin', '9B'), ('Murat', 'Ebru', '9B'), ('Aslı', 'Yavuz', '9B'),
--9C
	('Veli', 'Elif', '9C'), ('Yavuz', 'Begüm', '9C'), ('Selin', 'Özgür', '9C'), ('Kemal', 'Şeyma', '9C'), ('Ayşe', 'Emre', '9C'), ('Ahmet', 'Derya', '9C'), ('Melis', 'Sercan', '9C'), ('Barış', 'Selin', '9C'), ('Zeynep', 'Onur', '9C'), ('Seda', 'Ali', '9C'), ('Ahmet', 'Elif', '9C'), ('Mert', 'Nur', '9C'), ('Ebru', 'Burak', '9C'), ('Fatma', 'Mehmet', '9C'), ('Ege', 'Ayşe', '9C'),
--10A
	('Can', 'Özge', '10A'), ('Yusuf', 'Zehra', '10A'), ('Ezgi', 'Yasin', '10A'), ('Beril', 'Şahin', '10A'), ('Şükrü', 'Buse', '10A'), ('Ege', 'Aslı', '10A'), ('Sibel', 'Kaan', '10A'), ('Özlem', 'Umut',	'10A'), ('Elif', 'Emre', '10A'), ('Fatih', 'Derya', '10A'), ('Gizem', 'Ali', '10A'), ('Batuhan', 'İrem', '10A'), ('Gülşen', 'Can', '10A'), ('Hakan', 'Melike', '10A'), ('Zeynep', 'Sercan', '10A'),
--10B
	('Aylin', 'Berk', '10B'), ('Cem', 'Selin', '10B'), ('Derya', 'Kemal', '10B'), ('Elif', 'Ahmet', '10B'), ('Fatma', 'Barış', '10B'), ('Gökçe', 'Burak', '10B'), ('Hakan', 'Aslı', '10B'), ('İrem',	'Berkay', '10B'), ('Jale', 'Can', '10B'), ('Kaan', 'Deniz', '10B'), ('Lale', 'Emre', '10B'), ('Melike', 'Fatih', '10B'), ('Nur', 'Gizem', '10B'), ('Özge', 'Hakan', '10B'), ('Pelin', 'İrem',  '10B'),
--10C
	('Sercan', 'Zeynep', '10C'), ('Şahin', 'Aylin', '10C'), ('Umut', 'Cem', '10C'), ('Veli', 'Derya', '10C'), ('Yasin', 'Elif', '10C'), ('Zehra', 'Fatma', '10C'), ('Ali', 'Gökçe', '10C'), ('Berkay',	'Hakan', '10C'), ('Can', 'İrem', '10C'), ('Deniz', 'Jale', '10C'), ('Emre', 'Kaan', '10C'), ('Fatih', 'Lale', '10C'), ('Gizem', 'Melike', '10C'), ('Hakan', 'Nur', '10C'), ('İrem', 'Özge', '10C'),
--11A
	('Kemal', 'Pelin', '11A'), ('Lale', 'Sercan', '11A'), ('Melike', 'Şahin', '11A'), ('Nur', 'Umut', '11A'), ('Özge', 'Veli', '11A'), ('Pelin', 'Yasin', '11A'), ('Sercan', 'Zehra', '11A'), ('Şahin', 'Ali', '11A'), ('Umut', 'Berkay', '11A'), ('Veli', 'Can', '11A'), ('Yasin', 'Deniz', '11A'), ('Zehra', 'Emre', '11A'), ('Ali', 'Fatih', '11A'), ('Berkay', 'Gizem', '11A'), ('Can', 'Hakan', '11A'),
--11B
	('Derya', 'İrem', '11B'), ('Elif', 'Kaan', '11B'), ('Fatma', 'Lale', '11B'), ('Gizem', 'Melike', '11B'), ('Hakan', 'Nur', '11B'), ('İrem', 'Özge', '11B'), ('Kaan', 'Pelin', '11B'), ('Lale',	'Sercan', '11B'), ('Melike', 'Şahin', '11B'), ('Nur', 'Umut', '11B'), ('Özge', 'Veli', '11B'), ('Pelin', 'Yasin', '11B'), ('Sercan', 'Zehra', '11B'), ('Şahin', 'Ali', '11B'), ('Berkay', 'Aylin', '11B'),
--11C
	('Ali', 'Berkay', '11C'), ('Aylin', 'Can', '11C'), ('Berk', 'Deniz', '11C'), ('Can', 'Emre', '11C'), ('Deniz', 'Fatma', '11C'), ('Emre', 'Gizem', '11C'), ('Fatma', 'Hakan', '11C'), ('Gizem', 'İrem', '11C'), ('Hakan', 'Kaan', '11C'), ('İrem', 'Lale', '11C'), ('Kaan', 'Melike', '11C'), ('Lale', 'Nur', '11C'), ('Melike', 'Özge', '11C'), ('Nur', 'Pelin', '11C'), ('Özge', 'Sercan', '11C')
GO


--SELECTS
SELECT * FROM Ogretmen
SELECT * FROM Gun	
SELECT * FROM Ders
SELECT * FROM Sinif
SELECT * FROM Ogrenci


--ÇIKTILAR
-- 1) 9A Sınıfı Ders Programı
SELECT g.GunAdi AS GUN,
	d.DersAdi AS DERS,
	o.OgretmenAdi + ' ' + o.OgretmenSoyadi AS OGRETMEN
FROM Sinif AS s
	INNER JOIN Ders AS d ON d.DersID = s.DersID
	INNER JOIN Gun AS g ON g.GunID = s.GunID
	INNER JOIN Ogretmen AS o ON o.OgretmenID = s.OgretmenID
WHERE s.SinifID = '9A'
ORDER BY g.GunID

-- 2) Matematik1 (Sema Aksoy) Öğretmenin Ders Programı
SELECT * FROM Ogretmen -- Sema Aksoy => OgretmenID=9

SELECT g.GunAdi AS GUN,
	s.SinifID AS SINIF
FROM Ogretmen AS o
	INNER JOIN Sinif AS s ON s.OgretmenID = o.OgretmenID
	INNER JOIN Gun AS g ON g.GunID = s.GunID
WHERE o.OgretmenID = 9
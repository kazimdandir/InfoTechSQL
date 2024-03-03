CREATE DATABASE GeziDB
GO

USE GeziDB
GO

CREATE TABLE Uyruklar
(
ID INT IDENTITY PRIMARY KEY,
Uyruk VARCHAR(30)
)
GO

CREATE TABLE Ulkeler
(
ID INT IDENTITY PRIMARY KEY,
Ulke VARCHAR(30)
)
GO

CREATE TABLE Kisiler
(
ID INT IDENTITY PRIMARY KEY,
Ad VARCHAR(30),
Soyad VARCHAR(30),
Cinsiyet VARCHAR(5),
DogumTarihi DATETIME,
Uyruk INT FOREIGN KEY REFERENCES Uyruklar(ID),
Ulke INT FOREIGN KEY REFERENCES Ulkeler(ID)
)
GO

CREATE TABLE Rehber
(
ID INT IDENTITY PRIMARY KEY,
RehberAd VARCHAR(30),
RehberSoyad VARCHAR(30),
RehberTelNo VARCHAR(10)
)
GO

CREATE TABLE GidYer
(
ID INT IDENTITY PRIMARY KEY,
GidilecekYerler VARCHAR(30)
)
GO

CREATE TABLE Gezi
(
ID INT IDENTITY PRIMARY KEY,
KisiID INT FOREIGN KEY REFERENCES Kisiler(ID),
RehberID INT FOREIGN KEY REFERENCES Rehber(ID),
GidYerID INT FOREIGN KEY REFERENCES GidYer(ID)
)
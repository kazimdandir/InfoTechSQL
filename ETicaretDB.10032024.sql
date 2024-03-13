CREATE DATABASE ECommerceDB
GO

USE ECommerceDB
GO


--CREATE TABLES

--Countries
CREATE TABLE tbl_Countries
(
CountryID NCHAR(3) PRIMARY KEY, 
CountryName NVARCHAR(30) NOT NULL,
)
GO

--Cities
CREATE TABLE tbl_Cities
(
CityID INT IDENTITY PRIMARY KEY,
CityName NVARCHAR(30),
CountryID NCHAR(3) FOREIGN KEY REFERENCES tbl_Countries(CountryID)
)
GO

--Customers
CREATE TABLE tbl_Customers
(
CustomerID INT IDENTITY PRIMARY KEY,
FirstName NVARCHAR(50),
LastName NVARCHAR(50),
BirthDate DATE,
Address NVARCHAR(MAX),
CityID INT FOREIGN KEY REFERENCES tbl_Cities(CityID),
CountryID NCHAR(3) FOREIGN KEY REFERENCES tbl_Countries(CountryID),
Phone NVARCHAR(20)
)
GO

--Carriers
CREATE TABLE tbl_Carriers
(
CarrierID INT IDENTITY PRIMARY KEY,
CompanyName NVARCHAR(50),
Address NVARCHAR(MAX),
CityID INT FOREIGN KEY REFERENCES tbl_Cities(CityID),
CountryID NCHAR(3) FOREIGN KEY REFERENCES tbl_Countries(CountryID),
Phone NVARCHAR(20)
)
GO

--Categories
CREATE TABLE tbl_Categories
(
CategoryID INT IDENTITY PRIMARY KEY,
CategoryName NVARCHAR(50),
Description NVARCHAR(MAX)
)
GO

--Suppliers
CREATE TABLE tbl_Suppliers
(
SupplierID INT IDENTITY PRIMARY KEY,
CompanyName NVARCHAR(50),
Address NVARCHAR(MAX),
CityID INT FOREIGN KEY REFERENCES tbl_Cities(CityID),
CountryID NCHAR(3) FOREIGN KEY REFERENCES tbl_Countries(CountryID),
Phone NVARCHAR(20)
)
GO

--Products
CREATE TABLE tbl_Products
(
ProductID INT IDENTITY PRIMARY KEY,
ProductName NVARCHAR(50),
CarrierID INT FOREIGN KEY REFERENCES tbl_Carriers(CarrierID),
SupplierID INT FOREIGN KEY REFERENCES tbl_Suppliers(SupplierID),
CategoryID INT FOREIGN KEY REFERENCES tbl_Categories(CategoryID),
UnitPrice MONEY,
UnitInStock SMALLINT
)
GO

--Orders
CREATE TABLE tbl_Orders
(
OrderID INT IDENTITY PRIMARY KEY,
CustomerID INT FOREIGN KEY REFERENCES tbl_Customers(CustomerID),
SupplierID INT FOREIGN KEY REFERENCES tbl_Suppliers(SupplierID),
OrderDate DATETIME,
DeliveryDate DATETIME,
CarrierID INT FOREIGN KEY REFERENCES tbl_Carriers(CarrierID)
)
GO

--OrderDetails
CREATE TABLE tbl_OrderDetails
(
OrderID INT FOREIGN KEY REFERENCES tbl_Orders(OrderID),
ProductID INT FOREIGN KEY REFERENCES tbl_Products(ProductID),
UnitPrice MONEY,
Quantity SMALLINT,
Discount REAL
)
GO


--CREATE TRIGGERS

--Countries
CREATE TRIGGER trg_ListCountries ON tbl_Countries
AFTER INSERT 
AS 
BEGIN
	SELECT * FROM tbl_Countries 
END
GO

--Cities
CREATE TRIGGER trg_ListCities ON tbl_Cities
AFTER INSERT 
AS 
BEGIN
	SELECT * FROM tbl_Cities 
END
GO

--Customers
CREATE TRIGGER trg_ListCustomers ON tbl_Customers
AFTER INSERT 
AS 
BEGIN
	SELECT * FROM tbl_Customers 
END
GO

CREATE TRIGGER trg_AgeLimit ON tbl_Customers
FOR INSERT
AS
IF (EXISTS(SELECT * FROM tbl_Customers WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) < 18))
BEGIN
	RAISERROR('tbl_Customers tablosuna 18 ya��ndan k���kler eklenemez, do�um tarihini kontrol ediniz.', 11, 0)
    ROLLBACK TRANSACTION
END
GO

--Carriers
CREATE TRIGGER trg_ListCarriers ON tbl_Carriers
AFTER INSERT 
AS 
BEGIN
	SELECT * FROM tbl_Carriers 
END
GO

CREATE TRIGGER trg_CarrierCannotBeDeleted ON tbl_Carriers
INSTEAD OF DELETE
AS
BEGIN
	RAISERROR('Herhangi bir ta��y�c� silinemez ! Ancak g�ncelleme yapabilirsiniz.', 11, 0)
    ROLLBACK TRANSACTION
END
GO

--Categories
CREATE TRIGGER trg_ListCategories ON tbl_Categories
AFTER INSERT 
AS 
BEGIN
	SELECT * FROM tbl_Categories 
END
GO

--Suppliers
CREATE TRIGGER trg_ListSuppliers ON tbl_Suppliers
AFTER INSERT 
AS 
BEGIN
	SELECT * FROM tbl_Suppliers 
END
GO

--Products
CREATE TRIGGER trg_ListProducts ON tbl_Products
AFTER INSERT 
AS 
BEGIN
	SELECT * FROM tbl_Products 
END
GO

--Orders
CREATE TRIGGER trg_ListOrders ON tbl_Orders
AFTER INSERT 
AS 
BEGIN
	SELECT * FROM tbl_Orders 
END
GO

--OrderDetails
CREATE TRIGGER trg_ListOrderDetails ON tbl_OrderDetails
AFTER INSERT 
AS 
BEGIN
	SELECT * FROM tbl_OrderDetails 
END
GO


--STORE PROCEDURES

--Belirli bir m��terinin sipari�lerini listeleme
CREATE PROC sp_GetCustomerOrders
(
@CustomerFirstName NVARCHAR(50)
)
AS 
BEGIN
	SELECT 	p.ProductName,
		cat.CategoryName,
		s.CompanyName AS Supplier,
		ca.CompanyName AS Carrier,
		p.UnitPrice,
		p.UnitInStock
	FROM tbl_Orders AS o
		INNER JOIN tbl_Customers AS cu ON o.CustomerID = cu.CustomerID
		INNER JOIN tbl_OrderDetails AS od ON o.OrderID = od.OrderID
		INNER JOIN tbl_Products AS p ON od.ProductID = p.ProductID
		INNER JOIN tbl_Suppliers AS s ON s.SupplierID = o.SupplierID
		INNER JOIN tbl_Carriers AS ca ON ca.CarrierID = o.CarrierID
		INNER JOIN tbl_Categories AS cat ON cat.CategoryID = p.CategoryID
	WHERE cu.FirstName = @CustomerFirstName
END
GO

--Bir tedarik�inin �r�nlerini listeleme
CREATE PROC sp_GetSupplierProducts
(
@SupplierID INT
)
AS
BEGIN
	SELECT p.ProductID,
		p.ProductName,
		p.UnitPrice,
		c.CompanyName AS Carrier
	FROM tbl_Products AS p
		INNER JOIN tbl_Carriers AS c ON c.CarrierID = p.CarrierID
	WHERE SupplierID = @SupplierID
END
GO

--Ta��y�c�n�n �r�nlerini listeleme
CREATE PROC sp_GetCarrierProducts
(
@CarrierID INT
)
AS
BEGIN
	SELECT p.ProductID,
		p.ProductName,
		p.UnitPrice,
		s.CompanyName AS Supplier
	FROM tbl_Products AS p
		INNER JOIN tbl_Suppliers AS s ON s.SupplierID = p.SupplierID
	WHERE CarrierID = @CarrierID
END
GO


--FUNCTIONS

--Bir �r�n�n belirli bir miktar indirimle fiyat�n� hesaplayan bir fonksiyon
CREATE FUNCTION fn_CalculateDiscountedPrice
(
@ProductID INT,
@DiscountRate REAL
)
RETURNS MONEY
AS
BEGIN
	DECLARE @Price MONEY

	SELECT @Price = UnitPrice * (1 - @DiscountRate)
	FROM tbl_Products 
	WHERE ProductID = @ProductID

	RETURN @Price
END
GO

--Bir �r�n�n stok durumunu kontrol eden bir fonksiyon
CREATE FUNCTION fn_CheckProductStock
(
@ProductID INT
)
RETURNS NVARCHAR(100)
AS 
BEGIN
	DECLARE @StockStatus NVARCHAR(100)

	SELECT @StockStatus = 
		CASE 
			WHEN UnitInStock > 0 THEN 'Stokta' 
			ELSE 'Stokta Yok'
		END
	FROM tbl_Products 
	WHERE ProductID = @ProductID

	RETURN @StockStatus
END
GO


--VIEWS

--T�m m��teri bilgilerini getiren view yaz�n�z
CREATE VIEW vw_GetCustomerInfo
WITH ENCRYPTION 
AS
SELECT FirstName, LastName, Address, CityName, CountryName, Phone
FROM tbl_Customers AS c
	INNER JOIN tbl_Cities AS ci ON c.CityID = ci.CityID
	INNER JOIN tbl_Countries AS co ON c.CountryID = co.CountryID
GO

--T�m �r�n bilgilerini getiren view yaz�n�z
CREATE VIEW vw_GetProductInfo
WITH ENCRYPTION 
AS
SELECT p.ProductName, 
	car.CompanyName AS Carrier,
	s.CompanyName AS Supplier,
	cat.CategoryName,
	p.UnitPrice,
	p.UnitInStock
FROM tbl_Products AS p
	INNER JOIN tbl_Carriers AS car ON p.CarrierID = car.CarrierID
	INNER JOIN tbl_Suppliers AS s ON p.SupplierID = s.SupplierID
	INNER JOIN tbl_Categories AS cat ON p.CategoryID = cat.CategoryID
GO


--INSERTS

--Countries
INSERT INTO tbl_Countries(CountryID, CountryName)
VALUES ('ABD', 'Amerika Birle�ik Devletleri'),
	('ALM', 'Almanya'),
	('FRA', 'Fransa'),
	('TR', 'T�rkiye'),
	('ITA', '�talya'),
	('ING', '�ngiltere'),
	('JPN', 'Japonya'),
	('BRA', 'Brezilya'),
	('HIN', 'Hindistan'),
	('KAN', 'Kanada'),
	('AUS', 'Avustralya')
GO

--Cities
INSERT INTO tbl_Cities(CityName, CountryID)
VALUES 
--ABD
	('New York City', 'ABD'), ('Los Angeles', 'ABD'), ('Chicago', 'ABD'), 
--ALM
	('Berlin', 'ALM'), ('M�nih', 'ALM'), ('Hamburg', 'ALM'), 
--FRA
	('Paris', 'FRA'), ('Marsilya', 'FRA'), ('Lyon', 'FRA'), 
--TR	
	('�stanbul', 'TR'), ('Ankara', 'TR'), ('�zmr', 'TR'), 
--ITA
	('Roma', 'ITA'), ('Milano', 'ITA'), ('Venedik', 'ITA'), 
--ING
	('Londra', 'ING'), ('Manchester', 'ING'), ('Birmingham', 'ING'), 
--JPN
	('Tokyo', 'JPN'), ('Osaka', 'JPN'), ('Kyoto', 'JPN'), 
--BRA
	('S�o Paulo', 'BRA'), ('Rio de Janeiro', 'BRA'), ('Salvador', 'BRA'),
--HIN
	('New Delhi', 'HIN'), ('Mumbai', 'HIN'), ('Bangalore', 'HIN'),
--KAN
	('Toronto', 'KAN'), ('Montreal', 'KAN'), ('Vancouver', 'KAN'),
--AUS
	('Sydney', 'AUS'), ('Melbourne', 'AUS'), ('Brisbane', 'AUS')

--Customers
INSERT INTO tbl_Customers(FirstName, LastName, BirthDate, Address, CityID, CountryID, Phone)
VALUES ('Emily', 'Johnson', '1985-07-15', '1234 Elm Street', 2, 'ABD', '+1 555 123 4567'),
	('Lukas', 'M�ller', '1990-10-25', 'Musteristra�e 25', 6, 'ALM', '+49 30 12345678'),
	('Camille', 'Dubois', '1988-12-05', '45 Rue de la R�publique', 8, 'FRA', '+33 1 23456789'),
	('Ay�e', 'Y�lmaz', '1988-12-05', 'Moda Caddesi, No: 123', 10, 'TR', '+90  0532 123 45 67'),
	('Giorgio', 'Rossi', '1983-02-20', 'Calle Larga XXII Marzo, 1234', 15, 'ITA', '+39 02 1234567'),
	('Charlotte', 'Smith', '1992-01-10', '123 High Street', 18, 'ING', '+44 20 1234 5678'),
	('Yuki', 'Tanaka', '1987-03-03', '1-1-1 Marunouchi, Chiyoda-ku', 19, 'JPN', '+81 3 1234 5678'),
	('Rafael', 'Silva', '1980-06-12', 'Avenida Atl�ntica, 123', 23, 'BRA', '+55 11 1234-5678'),
	('Priya', 'Patel', '1995-09-18', '123 Marine Drive', 26, 'HIN', '+91 12345 67890'),
	('Liam', 'Wilson', '1982-11-08', '123 Yonge Street', 28, 'KAN', '+1 416 123 4567'),
	('Isabella', 'Brown', '1993-07-30', '123 Queen Street', 33, 'AUS', '+61 2 1234 5678')
GO

--Carriers
INSERT INTO tbl_Carriers(CompanyName, Address, CityID, CountryID, Phone)
VALUES ('Global Express Logistics', '123 Main Street, Suite 100', 1, 'ABD', '+1 212 555 1234'),
	('EuroCargo Shipping Co.', '456 Avenue des Champs-�lys�es', 7, 'FRA', '+33 1 23456789'),
	('Pacific Transport Solutions', '789 Harbour Road', 32, 'AUS', '+61 2 9876 5432'),
	('Oceanic Freight Services', '1010 Harbour Drive', 30, 'KAN', '+1 604 555 6789')
GO

--Categories
INSERT INTO tbl_Categories(CategoryName, Description)
VALUES ('Elektronik', 'Teknolojik cihazlar ve aletler, genellikle elektrikle �al��an ve bilgi i�lem veya e�lence ama�l� kullan�lan �r�nler'),
	('Giyim', '�nsanlar�n giydi�i giysilerin t�m�, genellikle moda, stil ve i�levsellik gibi fakt�rlere g�re tasarlanm�� ve �retilmi�tir'),
	('G�da', '�nsanlar�n t�ketebilece�i ve besin sa�layabilecek her t�rl� yiyecek ve i�ece�i kapsayan kategori'),
	('Kitap', 'Yaz�l� metinlerin bir araya getirilmesiyle olu�an ve genellikle e�itim, e�lence veya referans ama�l� kullan�lan yay�nlar'),
	('Spor', 'Bedensel aktiviteyi te�vik eden, egzersiz yapmay� sa�layan ve sporcular�n performans�n� art�rmaya y�nelik �r�nler'),
	('Mobilya', 'Oturma odas�, yatak odas�, mutfak ve ofis gibi farkl� mekanlarda kullan�lan mobilyalar�n t�m�'),
	('Kozmetik', 'Teknolojik cihazlar ve aletler, genellikle elektrikle �al��an ve bilgi i�lem veya e�lence ama�l� kullan�lan �r�nler'),
	('Oyuncak', ' �ocuklar�n e�lenmesini sa�layan, oyun oynamalar�n� te�vik eden ve geli�imlerine katk� sa�layan �r�nler')
GO

--Suppliers
INSERT INTO tbl_Suppliers(CompanyName, Address, CityID, CountryID, Phone)
VALUES ('ElectroTech Solutions', '123 Main Street, Suite 100', 3, 'ABD', '+1 415 555 1234'),
	('StyleZone Clothing', '456 Rue de Rivoli', 7, 'FRA', '+33 1 23456789'),
	('GreenHarvest Organic', '789 Oxford Street', 16, 'ING', '+44 20 1234 5678'),
	('DeutschTech Solutions', '123 Alexanderplatz', 4, 'ALM', '+49 30 12345678'),
	('ActiveSport Gear', '15-1 Ginza, Chuo-ku', 19, 'JPN', '+81 3 1234 5678'),
	('Anadolu Furnishings', '456 �stiklal Caddesi', 10, 'TR', '+90 212 9876543'),
	('BellaBeauty Cosmetics', '789 Via Veneto', 13, 'ITA', '+39 06 1234567'),
	('ToyWorld Fun', '789 Pitt Street', 31, 'AUS', '+61 2 9876 5432')
GO

--Products
INSERT INTO tbl_Products(ProductName, CarrierID, SupplierID, CategoryID, UnitPrice, UnitInStock)
VALUES 
--Elektronik
	('Ak�ll� Telefon', 3, 1, 1, 500, 100), ('Diz�st� Bilgisayar', 1, 1, 1, 1000, 75), ('Ak�ll� Saat', 4, 1, 1, 250, 50),  
--Giyim
	('Kad�n Elbisesi', 2, 2, 2, 50, 120), ('Erkek G�mle�i', 1, 2, 2, 40, 90), ('Spor Ayakkab�', 3, 2, 2, 70, 80),  
--G�da
	('Organik Kahve', 1, 3, 3, 10, 200), ('Do�al Bal', 4, 3, 3, 7, 150), ('Organik Zeytinya��', 2, 3, 3, 8, 180),  
--Kitap
	('Bilim Kurgu Roman�', 2, 4, 4, 12, 80), ('Tarih Kitab�', 3, 4, 4, 15, 70), ('Roman', 4, 4, 4, 10, 100),  
--Spor
	('Ko�u Ayakkab�s�', 3, 5, 5, 100, 60), ('Yoga Mat�', 1, 5, 5, 30, 70), ('Fitness Band�', 1, 5, 5, 40, 90),  
--Mobilya
	('�elik Tencere Seti', 4, 6, 6, 50, 50), ('Yumu�ak Yatak', 4, 6, 6, 200, 40), ('Modern Masa', 2, 6, 6, 120, 60),  
--Kozmetik
	('Parf�m', 1, 7, 7, 50, 120), ('Makyaj F�r�a Seti', 3, 7, 7, 25, 90), ('Nemlendirici Krem', 4, 7, 7, 15, 110), 
--Oyuncak
	('Ah�ap Oyuncak Seti', 2, 8, 8, 20, 150), ('Oyun Hamuru Seti', 4, 8, 8, 100, 200), ('Lego Seti', 1, 8, 8, 30, 180)
GO

--Orders
INSERT INTO tbl_Orders(CustomerID, SupplierID, OrderDate, DeliveryDate, CarrierID)
VALUES (1, 7, '2021-07-10', '2021-07-20', 2), 
	(8, 3, '2021-09-25', '2021-10-07', 1), 
	(4, 2, '2022-02-14', '2022-02-21', 3), 
	(11, 5, '2022-05-03', '2022-05-10', 4), 
	(5, 4, '2023-01-18', '2023-01-25', 2), 
	(9, 1, '2023-08-29', '2023-09-05', 3) 
GO

--OrderDetails
INSERT INTO tbl_OrderDetails(OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (1, 19, 45, 50, 0.05),
	(2, 8, 6, 37, 0),
	(3, 6, 65, 41, 0.15),
	(4, 14, 28.5, 8, 0),
	(5, 10, 10, 70, 0.05),
	(6, 2, 990, 25, 0.1)
GO


--SELECTS
SELECT * FROM tbl_Customers
SELECT * FROM tbl_Orders
SELECT * FROM tbl_OrderDetails
SELECT * FROM tbl_Products
SELECT * FROM tbl_Categories
SELECT * FROM tbl_Suppliers
SELECT * FROM tbl_Carriers
SELECT * FROM tbl_Cities
SELECT * FROM tbl_Countries


--STORE PROCEDUR KULLANIMLARI

--Emily'nin sipari�lerini listeleyen sp
EXEC sp_GetCustomerOrders 'Emily'

--ID'si 1 olan ta��y�c�n�n �r�nlerini listeleyen sp
EXEC sp_GetSupplierProducts 1

--ID'si 4 olan sat�c�n�n �r�nlerini listeleyen sp
EXEC sp_GetCarrierProducts 4


--FUNCTION KULLANIMLARI

--ID'si 1 olan �r�ne %10 indirim uygulayan fonksiyonu �a��r�n�z (�r�n Ad�, Stok Adedi kolonlar�da olsun)
SELECT ProductName, 
	UnitInStock,
	dbo.fn_CalculateDiscountedPrice(1, 0.10) AS [Discounted Price (USD)]
FROM tbl_Products 
WHERE ProductID = 1

--ID'si 10 olan �r�n�n stok durumunu kontrol eden fonksiyonu �a��r�n�z
SELECT dbo.fn_CheckProductStock(10) AS StockStatus


--VIEW KULLANIMLARI

--M��teri bilgilerini getiren view'i �a��r
SELECT * FROM vw_GetCustomerInfo

--�r�n bilgilerini getiren view'i �a��r
SELECT * FROM vw_GetProductInfo


--SORGULAR

--M��terilerin say�s�n� �lkelere g�re s�ralama
SELECT co.CountryName,
	COUNT(*) AS CustomerCount
FROM tbl_Customers AS cu
	INNER JOIN tbl_Countries AS co ON cu.CountryID = co.CountryID
GROUP BY co.CountryName
ORDER BY 2

--�r�nlerin toplam stok de�erlerini b�y�kten k����e g�steren sorgu
SELECT ProductName, 
	SUM(UnitInStock * UnitPrice) AS 'Total Stock Value(USD)'
FROM tbl_Products
GROUP BY ProductName
ORDER BY 2 DESC

--Toplam sat�� miktar�n� �lke baz�nda g�sterme
SELECT c.CountryName,
	COUNT(*) AS TotalOrders
FROM tbl_Orders AS o
	INNER JOIN tbl_Customers AS cust ON cust.CustomerID = o.CustomerID
	INNER JOIN tbl_Countries AS c ON c.CountryID = cust.CountryID
GROUP BY c.CountryName
ORDER BY 2

--�r�n kategorilerine g�re ortalama fiyatlar� g�sterme
SELECT c.CategoryName,
	AVG(p.UnitPrice) AS 'AvgPrice ($)'
FROM tbl_Products AS p 
	INNER JOIN tbl_Categories AS c ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName

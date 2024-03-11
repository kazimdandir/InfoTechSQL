--Bir m��terinin belirli bir tarih aral���ndaki toplam sipari� tutar�n� hesaplayan fonk.

CREATE FUNCTION FN_Get_Total_Amount
(
@CustomerID NCHAR(5),
@BaslangicTarih DATE,
@BitisTarih DATE
)
RETURNS MONEY
AS
BEGIN
	DECLARE @ToplamTutar MONEY
	
	SELECT @ToplamTutar = SUM(od.Quantity*od.UnitPrice)
	FROM Orders AS o
		INNER JOIN [Order Details] AS od ON o.OrderID = od.OrderID
	WHERE o.RequiredDate BETWEEN @BaslangicTarih AND @BitisTarih
		AND o.CustomerID = @CustomerID
RETURN ISNULL(@ToplamTutar,0)
END

SELECT dbo.FN_Get_Total_Amount('ALFKI', '1997-01-01', '1997-12-31') AS TotalAmount


--CASE WHEN 
CREATE FUNCTION FN_Ay_Adi_Bul
(
@AyNumarasi TINYINT
)
RETURNS VARCHAR(20)
AS
BEGIN
	RETURN
	(
		SELECT CASE @AyNumarasi
				WHEN 1 THEN 'OCAK'
				WHEN 2 THEN '�UBAT'
				WHEN 3 THEN 'MART'
				WHEN 4 THEN 'N�SAN'
				WHEN 5 THEN 'MAYIS'
				WHEN 6 THEN 'HAZ�RAN'
				WHEN 7 THEN 'TEMMUZ'
				WHEN 8 THEN 'A�USTOS'
				WHEN 9 THEN 'EYL�L'
				WHEN 10 THEN 'EK�M'
				WHEN 11 THEN 'KASIM'
				WHEN 12 THEN 'ARALIK'
				ELSE 'TANIMSIZ'
		END
	)
END

SELECT dbo.FN_Ay_Adi_Bul(6)


--TABLO D�ND�REN FUNC.

--Bir m��terinin ID'sini girdi�imizde, alm�� oldu�u �r�nleri listeleyen bir func olu�tural�m
--ProductName, Unit Price, Units In Stock kolonlar� olacak
CREATE FUNCTION FN_Product_Details
(
@CustomerID NCHAR(5)
)
RETURNS TABLE
AS
RETURN
(
SELECT p.ProductName, 
	p.UnitPrice, 
	p.UnitsInStock
FROM Customers AS c
	INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
	INNER JOIN [Order Details] AS od ON od.OrderID = o.OrderID
	INNER JOIN Products AS p ON p.ProductID = od.ProductID
WHERE c.CustomerID = @CustomerID
)

SELECT * 
FROM dbo.FN_Product_Details('ANTON')
WHERE UnitPrice BETWEEN 20 AND 50

--Sipari� adedi de�il detayl� tablo olarak func yazal�m
--�al��anlar�n belirli bir y�lda yapm�� oldu�� sipari�ler i�erisinde bulunan t�m �r�nlerin, �r�n ad�n�, birim fiyatlar�n� ve mevcut stok miktarlar�n� bulan bir func tan�mlayal�m
--EmployeeName, ProductName, UnitPrice, UnitInStock
CREATE FUNCTION FN_Product_Of_Employee
(
@EmployeeID NVARCHAR(10),
@YearsOld INT
)
RETURNS TABLE 
AS
RETURN
(
SELECT e.FirstName + ' ' + e.LastName AS EmployeeName,
	p.ProductName,
	p.UnitPrice,
	p.UnitsInStock
FROM Employees AS e
	INNER JOIN Orders AS o ON e.EmployeeID = o.EmployeeID
	INNER JOIN [Order Details] AS od ON od.OrderID = o.OrderID
	INNER JOIN Products AS p ON od.ProductID = p.ProductID
WHERE e.EmployeeID = @EmployeeID
	AND YEAR(o.OrderDate) = @YearsOld
)

SELECT * 
FROM dbo.FN_Product_Of_Employee(1, 1996)
ORDER BY UnitPrice DESC


--�OK DEY�ML� TABLO D�ND�REN FUNC.

--�r�nler (Products) tablosundan ProductName ve UnitPrice verilerini g�r�nt�leyecek bir function yazman�z isteniyor. Function d��ar�dan bir ID parametresi alacak. ID<0 ise Product tablosundaki b�t�n �r�nler, Products_Of_Customer tablosuna, ID>0 ise girilen ID�ye ait �r�n� Products tablosundan Products_Of_Customer tablosuna, e�er ID=0 ise Products_Of_Customer tablosuna (0,�Test �r�n��,10) �eklinde bir kay�t�girilecek.
CREATE FUNCTION FN_Get_Products
(
@UrunID INT
)
RETURNS @Products_Of_Customers TABLE --sanal table
							   ( 
							   ID INT,
							   ProductName NVARCHAR(40),
							   UnitPrice MONEY
							   )
AS 
BEGIN
	IF (@UrunID < 0)
		BEGIN
			INSERT INTO @Products_Of_Customers(ID, ProductName, UnitPrice)
			SELECT ProductID, ProductName, UnitPrice FROM Products
		END
	ELSE IF (@UrunID > 0)
		BEGIN
			INSERT INTO @Products_Of_Customers(ID, ProductName, UnitPrice)
			SELECT ProductID, ProductName, UnitPrice FROM Products WHERE ProductID = @UrunID
		END
	ELSE
		BEGIN
			INSERT INTO @Products_Of_Customers(ID, ProductName, UnitPrice)
			VALUES (0, 'Test Urun', 15)
		END
RETURN
END

SELECT * FROM dbo.FN_Get_Products(0)
SELECT * FROM dbo.FN_Get_Products(5)
SELECT * FROM dbo.FN_Get_Products(-1)
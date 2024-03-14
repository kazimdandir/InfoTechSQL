USE Northwind
--1- Tüm müþterileri listeleyiniz.
SELECT * 
FROM Customers

--2- Tüm müþterilerin sadece MusteriAdi ve MusteriUnvanini listeleyiniz.
SELECT CompanyName, 
	ContactTitle
FROM Customers

--3- Birim fiyatý 18 ve üzeri olan ürünleri listeleyiniz.
SELECT * 
FROM Products 
WHERE UnitPrice >= 18

--4- Sehir bilgisi ‘London’ olan tüm personelleri listeleyiniz.
SELECT * 
FROM Employees 
WHERE City = 'London'

--5- Sehir bilgisi ‘London’ olmayan tüm personellerin adý ve soyadýný listeleyiniz.
SELECT FirstName, 
	LastName 
FROM Employees 
WHERE City != 'London'

--6- KategoriID’si 3 olan ve birim fiyatý 10 dan küçük olan tüm ürünleri listeleyiniz
SELECT * 
FROM Products 
WHERE CategoryID = 3 
	AND UnitPrice < 10

--7- Sehir bilgisi ‘London’ veya ‘Seattle’ olan tüm personelleri listeleyiniz.
SELECT * 
FROM Employees 
WHERE City IN ('London', 'Seattle')

--8- 3,5 veya 7 nolu kategorideki tüm ürünleri listeleyiniz.
SELECT * 
FROM Products 
WHERE CategoryID IN (3, 5, 7)

--9- 6 ve 9 nolu kategorideki ürünler dýþýndaki tüm ürünleri listeleyiniz.
SELECT * 
FROM Products 
WHERE CategoryID NOT IN (6, 9)

--10- Birim fiyatý 10 ve 20 arasýndaki tüm ürünleri listeleyiniz.
SELECT * 
FROM Products 
WHERE UnitPrice BETWEEN 10 AND 20

--11- 1996-07-16 ile 1996-07-30 arasýnda sevk edilen satýþlarý listeleyiniz.
SELECT * 
FROM Orders 
WHERE ShippedDate BETWEEN '1996-07-16' AND '1996-07-30'

--12- Bölgesi tanýmlý olmayan tüm müþterileri listeleyiniz.
SELECT * 
FROM Customers 
WHERE Region IS NULL

--13- Faks numarasý olan tüm müþterileri listeleyiniz.
SELECT * 
FROM Customers 
WHERE Fax IS NOT NULL

--14- Manager ünvanýna sahip tüm müþterileri listeleyiniz.
SELECT * 
FROM Customers 
WHERE ContactTitle LIKE '%Manager%'

--15- FR ile baþlayan 5 karekter olan tüm müþterileri listeleyiniz.
SELECT * 
FROM Customers 
WHERE CustomerID LIKE '%FR___'

--16- (171) alan kodlu telefon numarasýna sahip müþterileri listeleyiniz.
SELECT * 
FROM Customers 
WHERE Phone LIKE '(171)%'

--17- BirimdekiMiktar alanýnda boxes geçen tüm ürünleri listeleyiniz.
SELECT * 
FROM Products 
WHERE QuantityPerUnit LIKE '%boxes%'

--18- Fransa ve Almanyadaki (France,Germany) Müdürlerin (Manager) Adýný ve Telefonunu listeleyiniz.(MusteriAdi,Telefon)
SELECT CompanyName, 
	Phone 
FROM Customers 
WHERE Country IN ('France', 'Germany') 
	AND ContactTitle LIKE '%Manager%' 

--19- Birim fiyatý 10 un altýnda olan ürünlerin kategoriID lerini tekil bir þekilde listeleyiniz.
SELECT CategoryID 
FROM Products 
WHERE UnitPrice < 10 
ORDER BY CategoryID

--20- En düþük birim fiyata sahip 5 ürünü listeleyiniz.
SELECT TOP 5 * 
FROM Products 
ORDER BY UnitPrice

--21- En yüksek birim fiyata sahip 10 ürünü listeleyiniz.
SELECT TOP 10 * 
FROM Products 
ORDER BY UnitPrice DESC

--22- Müþterileri ülke ve þehir bilgisine göre sýralayýp listeleyiniz.
SELECT * 
FROM Customers 
ORDER BY City, Country

--23- Personellerin ad,soyad ve yaþ bilgilerini listeleyiniz.(DATEDIFF,GETDATE())
SELECT FirstName, 
	LastName,
	DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age 
FROM Employees 

--24- 35 gün içinde sevk edilmeyen satýþlarý listeleyiniz.
SELECT * 
FROM Orders 
WHERE DATEDIFF(dd, OrderDate, ShippedDate) > 35

--25- Birim fiyatý en yüksek olan ürünün kategori adýný listeleyiniz. (Alt Sorgu)
SELECT CategoryName 
FROM Categories 
WHERE CategoryID = (SELECT TOP 1 CategoryID
					FROM Products 
					ORDER BY UnitPrice DESC)

--26- Kategori adýnda 'on' geçen kategorilerin ürünlerini listeleyiniz. (Alt Sorgu)
SELECT *
FROM Products 
WHERE CategoryID IN (SELECT CategoryID 
					 FROM Categories 
					 WHERE CategoryName LIKE '%on%')

--27- Nancy adlý personelin Brezilyaya sevk ettiði satýþlarý listeleyiniz (Alt Sorgu)
 SELECT * 
 FROM Orders 
 WHERE ShipCountry = 'Brazil'
	AND EmployeeID IN (SELECT EmployeeID 
					   FROM Employees
					   WHERE FirstName = 'Nancy')

--28- 1996 yýlýnda yapýlan sipariþlerin listesi
SELECT * 
FROM Orders 
WHERE DATEPART(yy, RequiredDate) = 1996

--29- Japonyadan kaç farklý ürün tedarik edilmektedir.
SELECT COUNT(*) AS Count 
FROM Products 
WHERE SupplierID IN (SELECT SupplierID 
					 FROM Suppliers 
					 WHERE Country = 'Japan')

--30- Konbu adlý üründen kaç adet satýlmýþtýr.
SELECT SUM(Quantity) AS Count 
FROM [Order Details] 
WHERE ProductID IN (SELECT ProductID 
					FROM Products
					WHERE ProductName = 'Konbu')

--31- 1997 yýlýnda yapýlmýþ satýþlarýn en yüksek, en düþük ve ortalama nakliye ücretlisi ne kadardýr?
SELECT MIN(Freight) AS Min,
	MAX(Freight) AS Max,
	AVG(Freight) AS Avg
FROM Orders 
WHERE DATEPART(yy, OrderDate) = 1997

--32- Tüm ürünleri listeleyiniz. Tablolarý basit birleþtirme baðlayýnýz. (urunAdi,kategoriAdi)
SELECT p.ProductName,
	c.CategoryName
FROM Products AS P,
	Categories AS c
WHERE p.CategoryID = c.CategoryID

--33- Tüm ürünleri listeleyiniz. Tablolarý join metodu baðlayýnýz. (urunAdi,kategoriAdi,Tedarikçi þirket adý)
SELECT p.ProductName,
	c.CategoryName,
	s.CompanyName AS Supplier
FROM Products AS P
	INNER JOIN Categories AS c ON p.CategoryID = c.CategoryID
	INNER JOIN Suppliers AS s ON s.SupplierID = p.SupplierID

--34- 10248 ID li satýþýn ürünlerini listeleyiniz. (UrunAdi,Toplam fiyatý)
SELECT p.ProductName,
	(od.Quantity * od.UnitPrice) AS TotalAmont
FROM [Order Details] AS od
	INNER JOIN Products AS p ON od.ProductID = p.ProductID
WHERE od.OrderID = 10248

--35- En pahalý ve En ucuz ürünü listeleyiniz.
SELECT * FROM (SELECT TOP 1 * FROM Products ORDER BY UnitPrice DESC) A
UNION
SELECT * FROM (SELECT TOP 1 * FROM Products ORDER BY UnitPrice) B

--36- Personelleri ve baðlý çalýþtýðý kiþileri listeleyiniz. (Ad,Tur(Patron,Personel,Müþteri))
SELECT e.FirstName + ' ' + e.LastName AS Name, Address,'Patron' AS Title FROM Employees e WHERE ReportsTo IS NULL
UNION
SELECT em.FirstName + ' ' + em.LastName AS Name, Address,'Personel' AS Title FROM Employees em WHERE ReportsTo IS NOT NULL
UNION
SELECT CompanyName AS Name,Address ,'Müþteri' AS Title FROM Customers

--37- Her bir kategoride kaç adet ürün var listeleyiniz.
SELECT CategoryID,
	COUNT(*) AS Count
FROM Products 
GROUP BY CategoryID

--38- Nancy adlý personelin ülkelere göre kaç adet satýþ sevk ettiðini listeleyiniz. (Sevk Ülkesi,Adet)
SELECT o.ShipCountry,
	COUNT(*) AS Count
FROM Orders AS o 
	INNER JOIN Employees AS e ON o.EmployeeID = e.EmployeeID
WHERE e.FirstName = 'Nancy'
GROUP BY o.ShipCountry

--39- Tüm ürünlerin kaç adet satýldýðýný listeleyiniz. (Ürün adý, Adet)
SELECT p.ProductName,
	SUM(od.Quantity) AS OrderQuantity
FROM Orders AS o
	INNER JOIN [Order Details] AS od ON od.OrderID = o.OrderID
	INNER JOIN Products AS p ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY ProductName
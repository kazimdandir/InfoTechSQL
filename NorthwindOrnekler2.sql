USE Northwind
--1- T�m m��terileri listeleyiniz.
SELECT * 
FROM Customers

--2- T�m m��terilerin sadece MusteriAdi ve MusteriUnvanini listeleyiniz.
SELECT CompanyName, 
	ContactTitle
FROM Customers

--3- Birim fiyat� 18 ve �zeri olan �r�nleri listeleyiniz.
SELECT * 
FROM Products 
WHERE UnitPrice >= 18

--4- Sehir bilgisi �London� olan t�m personelleri listeleyiniz.
SELECT * 
FROM Employees 
WHERE City = 'London'

--5- Sehir bilgisi �London� olmayan t�m personellerin ad� ve soyad�n� listeleyiniz.
SELECT FirstName, 
	LastName 
FROM Employees 
WHERE City != 'London'

--6- KategoriID�si 3 olan ve birim fiyat� 10 dan k���k olan t�m �r�nleri listeleyiniz
SELECT * 
FROM Products 
WHERE CategoryID = 3 
	AND UnitPrice < 10

--7- Sehir bilgisi �London� veya �Seattle� olan t�m personelleri listeleyiniz.
SELECT * 
FROM Employees 
WHERE City IN ('London', 'Seattle')

--8- 3,5 veya 7 nolu kategorideki t�m �r�nleri listeleyiniz.
SELECT * 
FROM Products 
WHERE CategoryID IN (3, 5, 7)

--9- 6 ve 9 nolu kategorideki �r�nler d���ndaki t�m �r�nleri listeleyiniz.
SELECT * 
FROM Products 
WHERE CategoryID NOT IN (6, 9)

--10- Birim fiyat� 10 ve 20 aras�ndaki t�m �r�nleri listeleyiniz.
SELECT * 
FROM Products 
WHERE UnitPrice BETWEEN 10 AND 20

--11- 1996-07-16 ile 1996-07-30 aras�nda sevk edilen sat��lar� listeleyiniz.
SELECT * 
FROM Orders 
WHERE ShippedDate BETWEEN '1996-07-16' AND '1996-07-30'

--12- B�lgesi tan�ml� olmayan t�m m��terileri listeleyiniz.
SELECT * 
FROM Customers 
WHERE Region IS NULL

--13- Faks numaras� olan t�m m��terileri listeleyiniz.
SELECT * 
FROM Customers 
WHERE Fax IS NOT NULL

--14- Manager �nvan�na sahip t�m m��terileri listeleyiniz.
SELECT * 
FROM Customers 
WHERE ContactTitle LIKE '%Manager%'

--15- FR ile ba�layan 5 karekter olan t�m m��terileri listeleyiniz.
SELECT * 
FROM Customers 
WHERE CustomerID LIKE '%FR___'

--16- (171) alan kodlu telefon numaras�na sahip m��terileri listeleyiniz.
SELECT * 
FROM Customers 
WHERE Phone LIKE '(171)%'

--17- BirimdekiMiktar alan�nda boxes ge�en t�m �r�nleri listeleyiniz.
SELECT * 
FROM Products 
WHERE QuantityPerUnit LIKE '%boxes%'

--18- Fransa ve Almanyadaki (France,Germany) M�d�rlerin (Manager) Ad�n� ve Telefonunu listeleyiniz.(MusteriAdi,Telefon)
SELECT CompanyName, 
	Phone 
FROM Customers 
WHERE Country IN ('France', 'Germany') 
	AND ContactTitle LIKE '%Manager%' 

--19- Birim fiyat� 10 un alt�nda olan �r�nlerin kategoriID lerini tekil bir �ekilde listeleyiniz.
SELECT CategoryID 
FROM Products 
WHERE UnitPrice < 10 
ORDER BY CategoryID

--20- En d���k birim fiyata sahip 5 �r�n� listeleyiniz.
SELECT TOP 5 * 
FROM Products 
ORDER BY UnitPrice

--21- En y�ksek birim fiyata sahip 10 �r�n� listeleyiniz.
SELECT TOP 10 * 
FROM Products 
ORDER BY UnitPrice DESC

--22- M��terileri �lke ve �ehir bilgisine g�re s�ralay�p listeleyiniz.
SELECT * 
FROM Customers 
ORDER BY City, Country

--23- Personellerin ad,soyad ve ya� bilgilerini listeleyiniz.(DATEDIFF,GETDATE())
SELECT FirstName, 
	LastName,
	DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age 
FROM Employees 

--24- 35 g�n i�inde sevk edilmeyen sat��lar� listeleyiniz.
SELECT * 
FROM Orders 
WHERE DATEDIFF(dd, OrderDate, ShippedDate) > 35

--25- Birim fiyat� en y�ksek olan �r�n�n kategori ad�n� listeleyiniz. (Alt Sorgu)
SELECT CategoryName 
FROM Categories 
WHERE CategoryID = (SELECT TOP 1 CategoryID
					FROM Products 
					ORDER BY UnitPrice DESC)

--26- Kategori ad�nda 'on' ge�en kategorilerin �r�nlerini listeleyiniz. (Alt Sorgu)
SELECT *
FROM Products 
WHERE CategoryID IN (SELECT CategoryID 
					 FROM Categories 
					 WHERE CategoryName LIKE '%on%')

--27- Nancy adl� personelin Brezilyaya sevk etti�i sat��lar� listeleyiniz (Alt Sorgu)
 SELECT * 
 FROM Orders 
 WHERE ShipCountry = 'Brazil'
	AND EmployeeID IN (SELECT EmployeeID 
					   FROM Employees
					   WHERE FirstName = 'Nancy')

--28- 1996 y�l�nda yap�lan sipari�lerin listesi
SELECT * 
FROM Orders 
WHERE DATEPART(yy, RequiredDate) = 1996

--29- Japonyadan ka� farkl� �r�n tedarik edilmektedir.
SELECT COUNT(*) AS Count 
FROM Products 
WHERE SupplierID IN (SELECT SupplierID 
					 FROM Suppliers 
					 WHERE Country = 'Japan')

--30- Konbu adl� �r�nden ka� adet sat�lm��t�r.
SELECT SUM(Quantity) AS Count 
FROM [Order Details] 
WHERE ProductID IN (SELECT ProductID 
					FROM Products
					WHERE ProductName = 'Konbu')

--31- 1997 y�l�nda yap�lm�� sat��lar�n en y�ksek, en d���k ve ortalama nakliye �cretlisi ne kadard�r?
SELECT MIN(Freight) AS Min,
	MAX(Freight) AS Max,
	AVG(Freight) AS Avg
FROM Orders 
WHERE DATEPART(yy, OrderDate) = 1997

--32- T�m �r�nleri listeleyiniz. Tablolar� basit birle�tirme ba�lay�n�z. (urunAdi,kategoriAdi)
SELECT p.ProductName,
	c.CategoryName
FROM Products AS P,
	Categories AS c
WHERE p.CategoryID = c.CategoryID

--33- T�m �r�nleri listeleyiniz. Tablolar� join metodu ba�lay�n�z. (urunAdi,kategoriAdi,Tedarik�i �irket ad�)
SELECT p.ProductName,
	c.CategoryName,
	s.CompanyName AS Supplier
FROM Products AS P
	INNER JOIN Categories AS c ON p.CategoryID = c.CategoryID
	INNER JOIN Suppliers AS s ON s.SupplierID = p.SupplierID

--34- 10248 ID li sat���n �r�nlerini listeleyiniz. (UrunAdi,Toplam fiyat�)
SELECT p.ProductName,
	(od.Quantity * od.UnitPrice) AS TotalAmont
FROM [Order Details] AS od
	INNER JOIN Products AS p ON od.ProductID = p.ProductID
WHERE od.OrderID = 10248

--35- En pahal� ve En ucuz �r�n� listeleyiniz.
SELECT * FROM (SELECT TOP 1 * FROM Products ORDER BY UnitPrice DESC) A
UNION
SELECT * FROM (SELECT TOP 1 * FROM Products ORDER BY UnitPrice) B

--36- Personelleri ve ba�l� �al��t��� ki�ileri listeleyiniz. (Ad,Tur(Patron,Personel,M��teri))
SELECT e.FirstName + ' ' + e.LastName AS Name, Address,'Patron' AS Title FROM Employees e WHERE ReportsTo IS NULL
UNION
SELECT em.FirstName + ' ' + em.LastName AS Name, Address,'Personel' AS Title FROM Employees em WHERE ReportsTo IS NOT NULL
UNION
SELECT CompanyName AS Name,Address ,'M��teri' AS Title FROM Customers

--37- Her bir kategoride ka� adet �r�n var listeleyiniz.
SELECT CategoryID,
	COUNT(*) AS Count
FROM Products 
GROUP BY CategoryID

--38- Nancy adl� personelin �lkelere g�re ka� adet sat�� sevk etti�ini listeleyiniz. (Sevk �lkesi,Adet)
SELECT o.ShipCountry,
	COUNT(*) AS Count
FROM Orders AS o 
	INNER JOIN Employees AS e ON o.EmployeeID = e.EmployeeID
WHERE e.FirstName = 'Nancy'
GROUP BY o.ShipCountry

--39- T�m �r�nlerin ka� adet sat�ld���n� listeleyiniz. (�r�n ad�, Adet)
SELECT p.ProductName,
	SUM(od.Quantity) AS OrderQuantity
FROM Orders AS o
	INNER JOIN [Order Details] AS od ON od.OrderID = o.OrderID
	INNER JOIN Products AS p ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY ProductName
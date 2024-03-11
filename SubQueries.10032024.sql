--SUB QUERIES

--Ortalama ücretin üzerinde yer alan ürünler
SELECT ProductName FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)


--Beverages kategorisine ait ürünleri raporlar
SELECT * FROM Products
WHERE CategoryID = (SELECT CategoryID FROM Categories WHERE CategoryName = 'Beverages')


--Ortalama yaþýn üzerinde olan çalýþanlarým
SELECT FirstName, DATEDIFF(YEAR, BirthDate, GETDATE()) FROM Employees
WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) > (SELECT AVG(DATEDIFF(YEAR, BirthDate, GETDATE())) FROM Employees)


--Fiyatý 30 liradan büyük olan ürünlerin listesi
SELECT ProductName FROM Products
WHERE ProductID IN (SELECT ProductID FROM [Order Details] WHERE UnitPrice > 30)


--Chai ürününden 5'ten fazla sipariþ vermiþ olan müþterilerin listesi
SELECT ProductID FROM Products WHERE ProductName = 'Chai' --Chai'nin ID'si 1
SELECT OrderID FROM [Order Details] WHERE Quantity > 5 AND ProductID = (SELECT ProductID FROM Products WHERE ProductName = 'Chai') --5'ten fazla Chai sipariþi yapýlmýþ sipariþ ID'leri

--
SELECT CustomerID FROM Orders WHERE OrderID IN (SELECT OrderID FROM [Order Details] WHERE Quantity > 5 AND ProductID = (SELECT ProductID FROM Products WHERE ProductName = 'Chai'))

--
SELECT CompanyName FROM Customers WHERE CustomerID IN (SELECT CustomerID FROM Orders WHERE OrderID IN (SELECT OrderID FROM [Order Details] WHERE Quantity > 5 AND ProductID = (SELECT ProductID FROM Products WHERE ProductName = 'Chai')))


--KategoriName B ile D arasýnda olan fiyatý 30 liradan fazla olan ürünler ÝSÝMLERÝ
SELECT ProductName FROM Products
WHERE ProductID IN (
SELECT ProductID FROM [Order Details] 
WHERE ProductID IN 
(SELECT ProductID FROM Products 
WHERE UnitPrice>30 AND CategoryID 
IN (SELECT CategoryID FROM 
Categories WHERE CategoryName LIKE '[BD]%')))
ORDER BY ProductName



--CORRELATED ÝLÝÞKÝLÝ ÝÇ ÝÇE

--Ürünler ve kategori isimleri
SELECT p.ProductName, 
	c.CategoryName 
FROM Products AS p, 
	Categories AS c 
WHERE p.CategoryID = c.CategoryID

--Correlated ile
SELECT ProductName, 
	(SELECT CategoryName 
	FROM Categories AS c 
	WHERE c.CategoryID = p.CategoryID) 
	AS CategoryName
FROM Products AS p


--Sipariþlerimi ID'ler ve sipariþin toplam tutarý olarak listeleyiniz
SELECT o.OrderID,
	(SELECT SUM(od.Quantity * od.UnitPrice) 
	FROM [Order Details] AS od 
	WHERE o.OrderID = od.OrderID) 
	AS TotalAmount
FROM Orders AS o


--Çalýþanlarýmýn toplam kazandýkdýrdýklarý kazancý bul

--SUBQUERY(CORRELATED)
SELECT e.FirstName,
	(SELECT SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) 
	FROM [Order Details] AS od
	WHERE OrderID IN (SELECT OrderID 
					 FROM Orders AS o 
					 WHERE o.EmployeeID = e.EmployeeID)
	)AS [Total Earnings]
FROM Employees AS e

--JOIN
SELECT e.FirstName,
	SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS [Total Earnings]
FROM [Order Details] AS od
	INNER JOIN Orders AS o ON o.OrderID = od.OrderID
	INNER JOIN Employees AS e ON e.EmployeeID = o.EmployeeID
GROUP BY e.FirstName

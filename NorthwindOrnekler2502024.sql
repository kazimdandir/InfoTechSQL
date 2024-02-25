--Çalýþanlarým ürün bazýnda ne kadarlýk satýþ yapmýþlar (çalýþan-ürün-adet-gelir)
SELECT * FROM Employees
SELECT * FROM Products
SELECT * FROM Orders
SELECT * FROM [Order Details]

SELECT e.FirstName + ' ' + e.LastName AS NAMESURNAME, 
p.ProductName, 
SUM(od.Quantity) AS ProductCount,
SUM(od.Quantity*od.UnitPrice) AS Income
FROM Products AS p
JOIN [Order Details] AS od ON od.ProductID=p.ProductID
JOIN Orders AS o ON o.OrderID=od.OrderID
JOIN Employees AS e ON e.EmployeeID=o.EmployeeID
GROUP BY e.FirstName, e.LastName, p.ProductName


--Hangi kargo þirketine toplam ne kadar ödeme yapmýþým?
SELECT * FROM Shippers
SELECT * FROM Orders

SELECT s.CompanyName, SUM(o.Freight) AS TotalAmount
FROM Orders AS o
JOIN Shippers AS s ON o.ShipVia=s.ShipperID
GROUP BY s.CompanyName
ORDER BY 2 DESC


--Hangi tedarikçiden aldýðým ürünlerden ne kadar satmýþým?
--(Satýþ bilgileri order details tablosundan alýnacak) (gelir adet bazýnda)
SELECT * FROM Suppliers
SELECT * FROM [Order Details]
SELECT * FROM Products

SELECT s.CompanyName, 
p.ProductName, 
SUM(od.Quantity) AS ProductCount,
SUM(od.Quantity*od.UnitPrice) AS Income
FROM Suppliers AS s
JOIN Products AS p ON s.SupplierID=p.SupplierID
JOIN [Order Details] AS od ON od.ProductID=p.ProductID
GROUP BY s.CompanyName, p.ProductName
ORDER BY 4 DESC


--En fazla satýþ yaptýðým müþteri? (gelir-adet bazýnda)
SELECT * FROM Customers
SELECT * FROM [Order Details]
SELECT * FROM Orders

SELECT TOP 1 c.CompanyName, 
SUM(od.Quantity*od.UnitPrice) AS Income
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID=o.CustomerID
JOIN [Order Details] AS od ON o.OrderID=od.OrderID
GROUP BY c.CompanyName
ORDER BY 2 DESC


--Hangi ülkelere ne kadarlýk satýþ yapmýþým?
SELECT c.Country, 
SUM(od.Quantity*od.UnitPrice) AS Income
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID=o.CustomerID
JOIN [Order Details] AS od ON o.OrderID=od.OrderID
GROUP BY c.Country
ORDER BY 2 DESC


--Zamanýnda teslim edemediðim sipariþlerimin ID'leri nelerdir ve kaç gün geç göndermiþim?
--DATEDIFF kullanýlacak
SELECT OrderID, DATEDIFF(DAY,RequiredDate,ShippedDate) AS Gun
FROM Orders 
WHERE DATEDIFF(DAY,RequiredDate,ShippedDate)>0
ORDER BY 2 DESC


--Ortalama satýþ miktarýnýn üzerine çýkan satýþlarým hangisi? (adet bazýnda)
SELECT AVG(Quantity) FROM [Order Details]

SELECT * FROM [Order Details]
WHERE Quantity>(SELECT AVG(Quantity) FROM [Order Details])

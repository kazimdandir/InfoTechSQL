--�al��anlar�m �r�n baz�nda ne kadarl�k sat�� yapm��lar (�al��an-�r�n-adet-gelir)
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


--Hangi kargo �irketine toplam ne kadar �deme yapm���m?
SELECT * FROM Shippers
SELECT * FROM Orders

SELECT s.CompanyName, SUM(o.Freight) AS TotalAmount
FROM Orders AS o
JOIN Shippers AS s ON o.ShipVia=s.ShipperID
GROUP BY s.CompanyName
ORDER BY 2 DESC


--Hangi tedarik�iden ald���m �r�nlerden ne kadar satm���m?
--(Sat�� bilgileri order details tablosundan al�nacak) (gelir adet baz�nda)
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


--En fazla sat�� yapt���m m��teri? (gelir-adet baz�nda)
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


--Hangi �lkelere ne kadarl�k sat�� yapm���m?
SELECT c.Country, 
SUM(od.Quantity*od.UnitPrice) AS Income
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID=o.CustomerID
JOIN [Order Details] AS od ON o.OrderID=od.OrderID
GROUP BY c.Country
ORDER BY 2 DESC


--Zaman�nda teslim edemedi�im sipari�lerimin ID'leri nelerdir ve ka� g�n ge� g�ndermi�im?
--DATEDIFF kullan�lacak
SELECT OrderID, DATEDIFF(DAY,RequiredDate,ShippedDate) AS Gun
FROM Orders 
WHERE DATEDIFF(DAY,RequiredDate,ShippedDate)>0
ORDER BY 2 DESC


--Ortalama sat�� miktar�n�n �zerine ��kan sat��lar�m hangisi? (adet baz�nda)
SELECT AVG(Quantity) FROM [Order Details]

SELECT * FROM [Order Details]
WHERE Quantity>(SELECT AVG(Quantity) FROM [Order Details])

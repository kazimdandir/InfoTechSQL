--1-)Tüm cirom ne kadar?
SELECT SUM((UnitPrice*Quantity)-(UnitPrice*Quantity*Discount))
FROM [Order Details]

--2-)Bugün doðumgünü olan çalýþanlarým kimler?
SELECT *
FROM Employees 
WHERE MONTH(BirthDate) = MONTH(GETDATE())
	AND DAY(BirthDate) = DAY(GETDATE())

--3-)Hangi çalýþaným hangi çalýþanýma baðlý? (Ýsim - Ýsim)
SELECT e.FirstName,
	em.FirstName
FROM Employees AS e
	INNER JOIN Employees AS em ON e.EmployeeID = em.EmployeeID

--4-)Çalýþanlarým ne kadarlýk satýþ yapmýþlar? (Gelir bazýnda)
SELECT e.FirstName,
	e.LastName,
	SUM(od.Quantity * od.UnitPrice) AS SalesAmount
FROM Employees AS e
	INNER JOIN Orders AS o ON o.EmployeeID = e.EmployeeID
	INNER JOIN [Order Details] AS od ON od.OrderID = o.OrderID
GROUP BY e.FirstName,
	e.LastName

--5-)Hangi ülkelere ihracat yapýyorum?
SELECT DISTINCT Country
FROM Customers

--6-)Ürünlere göre satýþým nasýl? (Ürün-Adet-Gelir)
SELECT p.ProductName,
	SUM(od.Quantity) AS TotalQuantity,
	SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS Income
FROM Products AS p
	INNER JOIN [Order Details] AS od ON od.ProductID = p.ProductID
GROUP BY p.ProductName

--7-)Ürün kategorilerine göre satýþlarým nasýl? (Gelir bazýnda)
SELECT c.CategoryName,
	SUM(od.Quantity * od.UnitPrice) AS SalesAmount
FROM Products AS p	
	INNER JOIN Categories AS c ON c.CategoryID = p.CategoryID
	INNER JOIN [Order Details] AS od ON od.ProductID = p.ProductID
GROUP BY c.CategoryName
ORDER BY 2 DESC

--8-)Ürün kategorilerine göre satýþlarým nasýl? (Adet bazýnda)
SELECT c.CategoryName,
	SUM(od.Quantity) AS Quantity
FROM Products AS p	
	INNER JOIN Categories AS c ON c.CategoryID = p.CategoryID
	INNER JOIN [Order Details] AS od ON od.ProductID = p.ProductID
GROUP BY c.CategoryName
ORDER BY 2 DESC

--9-)Çalýþanlarým ürün bazýnda ne kadarlýk satýþ yapmýþlar? (Çalýþan  –  Ürün – Adet – Gelir)
SELECT e.FirstName + ' ' + e.LastName AS Employee,
	p.ProductName,
	SUM(od.Quantity) AS Quantity, 
	SUM(od.Quantity * od.UnitPrice) AS SalesAmount
FROM Employees AS e
	INNER JOIN Orders AS o ON o.EmployeeID = e.EmployeeID
	INNER JOIN [Order Details] AS od ON od.OrderID = o.OrderID
	INNER JOIN Products AS p ON p.ProductID = od.ProductID
GROUP BY e.FirstName, 
	e.LastName,
	p.ProductName
ORDER BY 4 DESC

--10-)Hangi kargo þirketine toplam ne kadar ödeme yapmýþým?
SELECT s.CompanyName AS Supplier,
	SUM(o.Freight) AS FeePaid
FROM Shippers AS s
	INNER JOIN Orders AS o ON o.ShipVia = s.ShipperID
	INNER JOIN [Order Details] AS od ON od.OrderID = o.OrderID
GROUP BY s.CompanyName

--11-)Tost yapmayý seven çalýþaným hangisi? (Basit bir like sorgusu :))
SELECT FirstName + ' ' + LastName AS Employee,
	Notes
FROM Employees
WHERE Notes LIKE '%Toast%'

--12-)Hangi tedarikçiden aldýðým ürünlerden ne kadar satmýþým? (Satýþ bilgisi order details tablosundan alýnacak) (Gelir ve adet bazýnda)
SELECT s.CompanyName AS Supplier,
	p.ProductName,
	SUM(od.Quantity) AS Quantity, 
	SUM(od.Quantity * od.UnitPrice) AS Income
FROM [Order Details] AS od
	INNER JOIN Products AS p ON p.ProductID = od.ProductID
	INNER JOIN Suppliers AS s ON s.SupplierID = p.SupplierID
GROUP BY s.CompanyName,	
	p.ProductName

--13-)En deðerli müþterim hangisi? (en fazla satýþ yaptýðým müþteri) (Gelir ve adet bazýnda)
SELECT TOP 1 c.CompanyName,
	SUM(od.Quantity) AS Quantity, 
	SUM(od.Quantity * od.UnitPrice) AS Income
FROM Customers AS c
	INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
	INNER JOIN [Order Details] AS od ON od.OrderID = o.OrderID
GROUP BY c.CompanyName
ORDER BY 3 DESC

--14-)Hangi ülkelere ne kadarlýk satýþ yapmýþým?
SELECT c.Country,
	SUM(od.Quantity * od.UnitPrice) AS Income
FROM Customers AS c
	INNER JOIN Orders AS o ON o.CustomerID = c.CustomerID
	INNER JOIN [Order Details] AS od ON od.OrderID = o.OrderID
GROUP BY c.Country
ORDER BY 2 DESC

--15-)Zamanýnda teslim edemediðim sipariþlerim ID’leri  nelerdir ve kaç gün geç göndermiþim?
SELECT OrderID,
	DATEDIFF(DAY, ShippedDate, RequiredDate) AS [How many days late]
FROM Orders
WHERE DATEDIFF(DAY, ShippedDate, RequiredDate) > 0
ORDER BY 2 DESC

--16-)Ortalama satýþ miktarýnýn üzerine çýkan satýþlarým hangisi?(subquerry kullandýk, querrynin içinde querry tanýmladýk)
SELECT * 
FROM [Order Details] AS od
WHERE Quantity > (SELECT AVG(Quantity) FROM [Order Details])
ORDER BY od.Quantity DESC

--17-)Satýþlarýmý kaç günde teslim etmiþim?
SELECT OrderID,
	DATEDIFF(DAY, OrderDate, ShippedDate) AS [Which day delivery?]
FROM Orders
WHERE ShippedDate NOT LIKE 'NULL'
ORDER BY 2 DESC
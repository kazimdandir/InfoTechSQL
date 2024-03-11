--VIEWS

--Müþterilerin yapmýþ olduklarý sipariþ sayýlarýný gösteren bir view oluþturunuz
CREATE VIEW VW_Get_CustomerOrders(MüþteriID, [Sipariþ Sayýsý])
AS
SELECT c.CustomerID, 
	COUNT(o.OrderID)
FROM Customers AS c
	INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID

SELECT * FROM VW_Get_CustomerOrders

--Beverages kategorisindeki ürünlerin ProductID, ProductName, UnitPrice ve CategoryName'lerini getiren bir view oluþturalým ve with encryption özelliðini aktif edelim

CREATE VIEW VW_GetProducts
WITH ENCRYPTION
AS
SELECT p.ProductID,
	p.ProductName,
	p.UnitPrice,
	c.CategoryName
FROM Products AS p, 
	Categories AS c
WHERE c.CategoryID = p.CategoryID
	AND c.CategoryName = 'Beverages'

SELECT * FROM VW_GetProducts

--Speedy Express ile taþýnmýþ, Nancy'nin almýþ olduðu DUMON ya da ALFKI adlý müþteriler tarafýndan verilmiþ olan sipariþleri saklayan view oluþturunuz
CREATE VIEW VW_Shipper_Speedy_EmpNancy
AS 
SELECT o.OrderID,
	o.OrderDate,
	c.CompanyName 'CustomerCompanyName',
	s.CompanyName 'ShipperCompanyName',
	e.FirstName + ' ' + e.LastName 'Full Name'
FROM Orders AS o 
	INNER JOIN Shippers AS s ON s.ShipperID = o.ShipVia
	INNER JOIN Employees AS e ON o.EmployeeID = e.EmployeeID
	INNER JOIN Customers AS c ON o.CustomerID = c.CustomerID
WHERE s.CompanyName = 'Speedy Express'
	AND e.FirstName = 'Nancy'
	AND c.CustomerID in ('DUMON', 'ALFKI')

SELECT * FROM VW_Shipper_Speedy_EmpNancy


--Ortalama satýþ miktarýnýn üzerine çýkan(para bazlý) satýþlarý gösteren bir view yazýnýz
CREATE VIEW VW_DetaySorgu
AS
SELECT od.OrderID,	 
	SUM(od.Quantity*Od.UnitPrice*(1-od.Discount)) AS 'ToplamTutar' 
FROM [Order Details] AS od 
GROUP BY od.OrderID
HAVING SUM(od.Quantity*Od.UnitPrice*(1-od.Discount)) > 
(SELECT AVG(t.SiparisBazliPara) FROM 
(
	SELECT od.OrderID AS 'SiparisID', 
		SUM(od.Quantity*Od.UnitPrice*(1-od.Discount)) AS 'SiparisBazliPara' 
	FROM [Order Details] AS od
	GROUP BY od.OrderID
) AS t
)

SELECT * FROM VW_DetaySorgu

--En çok satan ürünün (adet olarak) adýný, kategori adýný ve toplam satýþ adedini gösteren bir view yazýnýz
CREATE VIEW VW_EnCokSatan
AS
SELECT TOP 1 p.ProductName, 
	c.CategoryName,
	COUNT(od.Quantity) AS OrderCount
FROM [Order Details] AS od
	INNER JOIN Products AS p ON p.ProductID = od.ProductID
	INNER JOIN Orders AS o ON od.OrderID = o.OrderID
	INNER JOIN Categories as c ON p.CategoryID = c.CategoryID
GROUP BY p.ProductName, 
	c.CategoryName
ORDER BY COUNT(od.Quantity) DESC

SELECT * FROM VW_EnCokSatan

--Uzun versiyonu
CREATE VIEW VW_Info_EnCokSatan
AS
SELECT TOP 1 PERCENT dbo.Products.ProductName, 
	COUNT(dbo.[Order Details].Quantity) AS [Toplam Satýþ Adedi], 
	dbo.Categories.CategoryName
FROM dbo.Products 
	INNER JOIN dbo.[Order Details] ON dbo.Products.ProductID = dbo.[Order Details].ProductID 
	INNER JOIN dbo.Orders ON dbo.[Order Details].OrderID = dbo.Orders.OrderID 
	INNER JOIN dbo.Categories ON dbo.Products.CategoryID = dbo.Categories.CategoryID
GROUP BY dbo.Products.ProductName, dbo.Categories.CategoryName
ORDER BY [Toplam Satýþ Adedi] DESC

SELECT * FROM VW_Info_EnCokSatan
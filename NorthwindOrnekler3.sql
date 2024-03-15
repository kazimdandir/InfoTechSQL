--1-)T�m cirom ne kadar?
SELECT SUM((UnitPrice*Quantity)-(UnitPrice*Quantity*Discount))
FROM [Order Details]

--2-)Bug�n do�umg�n� olan �al��anlar�m kimler?
SELECT *
FROM Employees 
WHERE MONTH(BirthDate) = MONTH(GETDATE())
	AND DAY(BirthDate) = DAY(GETDATE())

--3-)Hangi �al��an�m hangi �al��an�ma ba�l�? (�sim - �sim)
SELECT e.FirstName,
	em.FirstName
FROM Employees AS e
	INNER JOIN Employees AS em ON e.EmployeeID = em.EmployeeID

--4-)�al��anlar�m ne kadarl�k sat�� yapm��lar? (Gelir baz�nda)
SELECT e.FirstName,
	e.LastName,
	SUM(od.Quantity * od.UnitPrice) AS SalesAmount
FROM Employees AS e
	INNER JOIN Orders AS o ON o.EmployeeID = e.EmployeeID
	INNER JOIN [Order Details] AS od ON od.OrderID = o.OrderID
GROUP BY e.FirstName,
	e.LastName

--5-)Hangi �lkelere ihracat yap�yorum?
SELECT DISTINCT Country
FROM Customers

--6-)�r�nlere g�re sat���m nas�l? (�r�n-Adet-Gelir)
SELECT p.ProductName,
	SUM(od.Quantity) AS TotalQuantity,
	SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS Income
FROM Products AS p
	INNER JOIN [Order Details] AS od ON od.ProductID = p.ProductID
GROUP BY p.ProductName

--7-)�r�n kategorilerine g�re sat��lar�m nas�l? (Gelir baz�nda)
SELECT c.CategoryName,
	SUM(od.Quantity * od.UnitPrice) AS SalesAmount
FROM Products AS p	
	INNER JOIN Categories AS c ON c.CategoryID = p.CategoryID
	INNER JOIN [Order Details] AS od ON od.ProductID = p.ProductID
GROUP BY c.CategoryName
ORDER BY 2 DESC

--8-)�r�n kategorilerine g�re sat��lar�m nas�l? (Adet baz�nda)
SELECT c.CategoryName,
	SUM(od.Quantity) AS Quantity
FROM Products AS p	
	INNER JOIN Categories AS c ON c.CategoryID = p.CategoryID
	INNER JOIN [Order Details] AS od ON od.ProductID = p.ProductID
GROUP BY c.CategoryName
ORDER BY 2 DESC

--9-)�al��anlar�m �r�n baz�nda ne kadarl�k sat�� yapm��lar? (�al��an  �  �r�n � Adet � Gelir)
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

--10-)Hangi kargo �irketine toplam ne kadar �deme yapm���m?
SELECT s.CompanyName AS Supplier,
	SUM(o.Freight) AS FeePaid
FROM Shippers AS s
	INNER JOIN Orders AS o ON o.ShipVia = s.ShipperID
	INNER JOIN [Order Details] AS od ON od.OrderID = o.OrderID
GROUP BY s.CompanyName

--11-)Tost yapmay� seven �al��an�m hangisi? (Basit bir like sorgusu :))
SELECT FirstName + ' ' + LastName AS Employee,
	Notes
FROM Employees
WHERE Notes LIKE '%Toast%'

--12-)Hangi tedarik�iden ald���m �r�nlerden ne kadar satm���m? (Sat�� bilgisi order details tablosundan al�nacak) (Gelir ve adet baz�nda)
SELECT s.CompanyName AS Supplier,
	p.ProductName,
	SUM(od.Quantity) AS Quantity, 
	SUM(od.Quantity * od.UnitPrice) AS Income
FROM [Order Details] AS od
	INNER JOIN Products AS p ON p.ProductID = od.ProductID
	INNER JOIN Suppliers AS s ON s.SupplierID = p.SupplierID
GROUP BY s.CompanyName,	
	p.ProductName

--13-)En de�erli m��terim hangisi? (en fazla sat�� yapt���m m��teri) (Gelir ve adet baz�nda)
SELECT TOP 1 c.CompanyName,
	SUM(od.Quantity) AS Quantity, 
	SUM(od.Quantity * od.UnitPrice) AS Income
FROM Customers AS c
	INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
	INNER JOIN [Order Details] AS od ON od.OrderID = o.OrderID
GROUP BY c.CompanyName
ORDER BY 3 DESC

--14-)Hangi �lkelere ne kadarl�k sat�� yapm���m?
SELECT c.Country,
	SUM(od.Quantity * od.UnitPrice) AS Income
FROM Customers AS c
	INNER JOIN Orders AS o ON o.CustomerID = c.CustomerID
	INNER JOIN [Order Details] AS od ON od.OrderID = o.OrderID
GROUP BY c.Country
ORDER BY 2 DESC

--15-)Zaman�nda teslim edemedi�im sipari�lerim ID�leri  nelerdir ve ka� g�n ge� g�ndermi�im?
SELECT OrderID,
	DATEDIFF(DAY, ShippedDate, RequiredDate) AS [How many days late]
FROM Orders
WHERE DATEDIFF(DAY, ShippedDate, RequiredDate) > 0
ORDER BY 2 DESC

--16-)Ortalama sat�� miktar�n�n �zerine ��kan sat��lar�m hangisi?(subquerry kulland�k, querrynin i�inde querry tan�mlad�k)
SELECT * 
FROM [Order Details] AS od
WHERE Quantity > (SELECT AVG(Quantity) FROM [Order Details])
ORDER BY od.Quantity DESC

--17-)Sat��lar�m� ka� g�nde teslim etmi�im?
SELECT OrderID,
	DATEDIFF(DAY, OrderDate, ShippedDate) AS [Which day delivery?]
FROM Orders
WHERE ShippedDate NOT LIKE 'NULL'
ORDER BY 2 DESC
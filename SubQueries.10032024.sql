--SUB QUERIES

--Ortalama �cretin �zerinde yer alan �r�nler
SELECT ProductName FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)


--Beverages kategorisine ait �r�nleri raporlar
SELECT * FROM Products
WHERE CategoryID = (SELECT CategoryID FROM Categories WHERE CategoryName = 'Beverages')


--Ortalama ya��n �zerinde olan �al��anlar�m
SELECT FirstName, DATEDIFF(YEAR, BirthDate, GETDATE()) FROM Employees
WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) > (SELECT AVG(DATEDIFF(YEAR, BirthDate, GETDATE())) FROM Employees)


--Fiyat� 30 liradan b�y�k olan �r�nlerin listesi
SELECT ProductName FROM Products
WHERE ProductID IN (SELECT ProductID FROM [Order Details] WHERE UnitPrice > 30)


--Chai �r�n�nden 5'ten fazla sipari� vermi� olan m��terilerin listesi
SELECT ProductID FROM Products WHERE ProductName = 'Chai' --Chai'nin ID'si 1
SELECT OrderID FROM [Order Details] WHERE Quantity > 5 AND ProductID = (SELECT ProductID FROM Products WHERE ProductName = 'Chai') --5'ten fazla Chai sipari�i yap�lm�� sipari� ID'leri

--
SELECT CustomerID FROM Orders WHERE OrderID IN (SELECT OrderID FROM [Order Details] WHERE Quantity > 5 AND ProductID = (SELECT ProductID FROM Products WHERE ProductName = 'Chai'))

--
SELECT CompanyName FROM Customers WHERE CustomerID IN (SELECT CustomerID FROM Orders WHERE OrderID IN (SELECT OrderID FROM [Order Details] WHERE Quantity > 5 AND ProductID = (SELECT ProductID FROM Products WHERE ProductName = 'Chai')))


--KategoriName B ile D aras�nda olan fiyat� 30 liradan fazla olan �r�nler �S�MLER�
SELECT ProductName FROM Products
WHERE ProductID IN (
SELECT ProductID FROM [Order Details] 
WHERE ProductID IN 
(SELECT ProductID FROM Products 
WHERE UnitPrice>30 AND CategoryID 
IN (SELECT CategoryID FROM 
Categories WHERE CategoryName LIKE '[BD]%')))
ORDER�BY�ProductName



--CORRELATED �L��K�L� �� ��E

--�r�nler ve kategori isimleri
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


--Sipari�lerimi ID'ler ve sipari�in toplam tutar� olarak listeleyiniz
SELECT o.OrderID,
	(SELECT SUM(od.Quantity * od.UnitPrice) 
	FROM [Order Details] AS od 
	WHERE o.OrderID = od.OrderID) 
	AS TotalAmount
FROM Orders AS o


--�al��anlar�m�n toplam kazand�kd�rd�klar� kazanc� bul

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

--Hangi �al��an�m hangi �al��an�ma ba�l� (�sim-�sim)
SELECT e.FirstName + ' ' + e.LastName + '-' + e.Title AS Yoneticiler,
em.FirstName + ' ' + em.LastName + '-' + em.Title AS Calisanlar
FROM Employees AS e	
JOIN Employees AS em
ON e.EmployeeID=em.ReportsTo
ORDER BY 1 ASC


--�al��anlar�m ne kadarl�k sat�� yapm��lar? (Gelir baz�nda)
SELECT * FROM Employees
SELECT * FROM Orders
SELECT * FROM [Order Details]

SELECT e.FirstName + ' ' + e.LastName AS EMPLOYEE,
SUM(Quantity*UnitPrice) AS INCOME
FROM Employees AS e
JOIN Orders AS o ON e.EmployeeID=o.EmployeeID
JOIN [Order Details] as od ON o.OrderID=od.OrderID
GROUP BY e.FirstName, e.LastName
ORDER BY 2 DESC


--Hangi �lkere ihracat yap�yorum?
SELECT DISTINCT Country FROM Customers
GROUP BY Country
--ya da 
SELECT Country FROM Customers
GROUP BY Country


--5 �ehirden fazla ihracat yapan �lkeler ve ka� �ehire yapt���?
SELECT Country, COUNT(City) AS CityCount
FROM Customers
GROUP BY Country
HAVING COUNT(City)>5
ORDER BY 2 DESC


--Sadece �ehir isimleri
SELECT DISTINCT City FROM Customers


--Hangi �ehirde ka� m��teri vard�r
SELECT City, Count(City) AS CustomerCount
FROM Customers 
GROUP BY City
ORDER BY 2 DESC


--�r�nlere g�re sat���m nas�l?(�r�n-Adet-Gelir)
SELECT * FROM Products
SELECT * FROM [Order Details]

SELECT p.ProductName,
SUM(od.Quantity) AS ProductCount,
SUM(od.Quantity*od.UnitPrice*(1-od.Discount)) AS Income
FROM Products AS p
JOIN [Order Details] AS od ON p.ProductID=od.ProductID
GROUP BY p.ProductName
ORDER BY Income DESC


--�r�n kategorilerine g�re sat��lar�m nas�l?(gelir baz�nda)
SELECT * FROM Categories
SELECT * FROM Products
SELECT * FROM [Order Details]

SELECT c.CategoryName,
SUM(od.Quantity*od.UnitPrice*(1-od.Discount)) AS Income
FROM Categories AS c
JOIN Products AS p ON c.CategoryID=p.CategoryID
JOIN [Order Details] AS od ON p.ProductID=od.ProductID
GROUP BY c.CategoryName
ORDER BY 2 DESC
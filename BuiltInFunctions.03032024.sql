--BUILT IN FUNCTIONS
SELECT LEN('Merhaba') AS Uzunluk
SELECT UPPER('Merhaba') AS BuyukHarf
SELECT LOWER('Merhaba') AS KucukHarf
SELECT LEFT('Merhaba', 3) AS SoldanUc
SELECT RIGHT('Merhaba', 3) AS SagdanUc
SELECT CONCAT('Mer', 'haba') AS Birlesik
SELECT GETDATE() AS Simdi
SELECT DATEDIFF(DAY, '2022-01-01', '2024-02-28') AS GunFarki
SELECT DATEDIFF(MONTH, '2022-01-01', '2024-02-28') AS AyFarki
SELECT DATEDIFF(YEAR, '2022-01-01', '2024-02-28') AS YilFark
SELECT SUM(UnitPrice) AS ToplamSatis FROM Products
SELECT SUBSTRING('Merhaba D�nya', 1, 7)
SELECT DATEPART(DAY, GETDATE())
SELECT ROUND(123.456, 3)
SELECT CEILING(123.456)
SELECT FLOOR(123.456)
SELECT 10 % 3
SELECT REPLACE('Merhaba D�nya', 'Merhaba', 'Selam')
SELECT REVERSE('Merhaba')
SELECT LTRIM('    Merhaba')
SELECT RTRIM('Merhaba     ')
SELECT REPLICATE('abc', 3)
SELECT 'Merhaba' + SPACE(5) + 'D�nya'
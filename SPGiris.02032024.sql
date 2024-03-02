--De�i�kenler
DECLARE @Sayi INT = 15 --declare --> tan�m
PRINT 'Atanan De�er' --print ekrana basar
PRINT @Sayi
SET @Sayi = 5 --set ile bir de�i�ken atamas�
PRINT 'Atanan Yeni De�er'
PRINT @Sayi

DECLARE @Ad NVARCHAR(50), @Yas INT;
SELECT @Ad = 'Ali', @Yas = 25 --select ile birden fazla de�i�ken atamas�
PRINT @Ad
PRINT @Yas

DECLARE @Tarih DATETIME
SET @Tarih = '2013-12-12'
PRINT @Tarih

DECLARE @Price Money
SET @Price = 12.2
PRINT @Price

DECLARE @Description NVARCHAR(MAX)
SET @Description = 'Lorem Ipsum....'
PRINT @Description

USE Northwind
DECLARE @CategoryCount INT
SET @CategoryCount = (SELECT COUNT(*) FROM Categories)
SELECT @CategoryCount


--IF-ELSE

--IF(KOSUL)
--BEGIN

--END
--ELSE
--BEGIN

--END

--�r�nler tablosunda 5000 den fazla kay�t olup olmad���n� kontrol eden SQL ifadesini yaz�n�z
DECLARE @Sayi1 INT
SELECT @Sayi1 = (SELECT COUNT(*) FROM Products)
IF @Sayi1>5000
BEGIN 
	PRINT '5000 DEN FAZLA �R�N'
END
ELSE
BEGIN
	PRINT '5000 DEN AZ �R�N'
END

IF EXISTS(SELECT * FROM sys.tables WHERE NAME = 'Products1') -- Var m�?
BEGIN
	PRINT 'Evet var'
END
ELSE
BEGIN
	PRINT 'Hay�r yok'
END

--IF NOT EXISTS() -- Yok mu?


--WHILE

--BREAK D�ng�y� k�rar 
--CONTINUE D�ng� devam ettirir

--0 ile 10 aras�ndaki say�lar� ekrana yazd�ran SQL ifadesi
DECLARE @Sayac INT
SET @Sayac = 0

WHILE (@Sayac<=10)
	BEGIN
		PRINT @Sayac
		SET @Sayac += 1
	END

--T�m �r�nlerin fiyat ortalamalar�n� kontrol edelim e�er 50�nin alt�nda ise �r�n fiyat�n� ikiye katlayal�m. 
--T�m �r�nlerin fiyatlar�n�n ortalamas� 50��st�ne ��kana kadar d�ng�m�z devam etsin.
--While d�ng�s� i�indeki k�s�mda �r�n fiyat�n� ikiye katlad�ktan sonra tabloda bulunan en pahal� �r�n� bulup 50 den b�y�k m� diye bakal�m e�er b�y�kse d�ng�y� BREAK ile sonland�ral�m de�il ise CONTINUE ile d�ng�ye�devam�edelim
SELECT AVG(UnitPrice) FROM Products

WHILE (SELECT AVG(UnitPrice) FROM Products) < 50
	BEGIN 
		UPDATE Products SET UnitPrice = UnitPrice * 2
		IF (SELECT MAX(UnitPrice) FROM Products) > 50
			BREAK
		ELSE
			CONTINUE
	END
PRINT 'MAXIMUM F�YATI 50 DEN B�Y�K'

--VER�TABANINI BOZDU�UMUZ ���N ��LEM� GER�YE ALALIM

WHILE (SELECT AVG(UnitPrice) FROM Products) > 50
	BEGIN 
		UPDATE Products SET UnitPrice = UnitPrice / 2
		IF (SELECT MAX(UnitPrice) FROM Products) > 50
			BREAK
		ELSE
			CONTINUE
	END
PRINT 'MAXIMUM F�YATI 50 DEN B�Y�K'


--SP : STORED PROCEDURE : Derlenmi� SQL c�mlecikleri

--�stemci makinelerdeki i� y�k�n� azalt�r ve performans�artt�r�r (yaz�ld��� zaman ayn� zamanda compile edildikleri i�in query optimizer taraf�ndan optimize edilmi� en h�zl� �ekilde �al���r).
--SQL c�mleleri, Sakl� Yordamlardan �ok daha yava� sonu�d�nd�r�r.
--Network� (A� Trafi�ini) azalt�r.
--A��k SQL c�mleciklerine nazaran daha g�venlidir. Stored prosed�reler sadece giri� ve ��k�� parametreleri uygulama katman�nda g�r�nd��� i�in daha g�venilirdir.
--Programlama deyimlerini i�erebilirler. if, try, catch , set vs.. Gelen parametrelere g�re sorgu yap�l�p sonucun d�nmesi�sa�lanabilir

--En fazla sat�lan 6 �r�n�m� g�steren sp'yi ve sp'yi �al��t�ran kodlar� yaz�n�z.
CREATE PROC SP_InfoMaxUrunGoster
AS
BEGIN
	SELECT TOP 6
		p.ProductName,
		SUM(od.Quantity)
	FROM [Order Details] AS od
		INNER JOIN Products AS p ON od.ProductID=p.ProductID
	GROUP BY p.ProductName
	ORDER BY 2 DESC
END

ALTER PROC SP_InfoMaxUrunGoster
AS
BEGIN
	SELECT TOP 6
		p.ProductName,
		SUM(od.Quantity) AS Quantity
	FROM [Order Details] AS od
		INNER JOIN Products AS p ON od.ProductID=p.ProductID
	GROUP BY p.ProductName
	ORDER BY 2 DESC
END


EXEC SP_InfoMaxUrunGoster

--Parametre alan SP
--CREATE PROCEDURE ISIM
--(@Prm1 NVARCHAR(30), @Prm2 INT)
--AS
--BEGIN
--END


--Kargolara kay�t ekleyen stored procedure�� ve stored procedure�� �al��t�ran kodlar� yaz�n�z. (isim eklemeniz yeterli)
CREATE PROC SP_InfoKayitEkle
(
@name NVARCHAR(30)
)
AS
BEGIN
	INSERT INTO Shippers(CompanyName) VALUES(@name)
END

EXEC SP_InfoKayitEkle 'Yurti�i Kargo'

--Olu�turdu�unuz Kay�tEkle procedurunu telefon numaras� da eklensin �eklinde g�ncelleyiniz.
ALTER PROC SP_InfoKayitEkle
(
@name NVARCHAR(30),
@phone CHAR(20)
)
AS
INSERT INTO Shippers(CompanyName, Phone) VALUES(@name, @phone)

EXEC SP_InfoKayitEkle 'Yurti�i Kargo', '123456789'

--Olu�turdu�unuz Kay�tEkle procedurunu silme komutunu�yaz�n�z.
DROP PROC SP_InfoKayitEkle


----D��ar�dan girilen de�er kadar �r�ne zam veya indirim yapan proc yaz�n�z.
--(��lemi �zam veya indirim�, �r�nId�yi ve zam veya indirim miktar�n�  d��ar�dan parametre ile biz�g�nderece�iz
CREATE PROC SP_InfoZamIndirimYap
(
@islem NVARCHAR(10),
@miktar DECIMAL,
@proID INT
)
AS
IF (@islem = 'zam')
	BEGIN
		UPDATE Products SET UnitPrice += @miktar WHERE ProductID = @proID
	END
ELSE IF (@islem = 'indirim')
	BEGIN 
		UPDATE Products SET UnitPrice -= @miktar WHERE ProductID = @proID
	END

EXEC SP_InfoZamIndirimYap 'zam', 100, 2
EXEC SP_InfoZamIndirimYap 'indirim', 100, 2

--Hi� if olmad���n� d���nelim
ALTER PROC SP_InfoZamIndirimYap
(
@miktar DECIMAL,
@proID INT
)
AS
UPDATE Products SET UnitPrice += @miktar WHERE ProductID = @proID

EXEC SP_InfoZamIndirimYap 100,2 --zam
EXEC SP_InfoZamIndirimYap -100,2 --indirim


--D��ar�dan girilen kargo firmas� taraf�ndan ta��nm�� ve yine d��ar�dan girilen kargo �demesi de�er aral���ndaki sipari�leri proc ile listeleyiniz.
CREATE PROC SP_InfoKargoFirmasiSiparis
(
@companyName NVARCHAR(30),
@minFreigt INT,
@maxFreight INT
)
AS
BEGIN 
	SELECT o.OrderID, s.CompanyName
	FROM Orders AS o 
		INNER JOIN Shippers AS s ON o.ShipVia=s.ShipperID
	WHERE s.CompanyName LIKE '%' +@companyName+ '%'
		AND o.Freight BETWEEN @minFreigt AND @maxFreight
END

EXEC SP_InfoKargoFirmasiSiparis 'Fed', 10, 100

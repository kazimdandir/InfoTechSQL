--Deðiþkenler
DECLARE @Sayi INT = 15 --declare --> taným
PRINT 'Atanan Deðer' --print ekrana basar
PRINT @Sayi
SET @Sayi = 5 --set ile bir deðiþken atamasý
PRINT 'Atanan Yeni Deðer'
PRINT @Sayi

DECLARE @Ad NVARCHAR(50), @Yas INT;
SELECT @Ad = 'Ali', @Yas = 25 --select ile birden fazla deðiþken atamasý
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

--Ürünler tablosunda 5000 den fazla kayýt olup olmadýðýný kontrol eden SQL ifadesini yazýnýz
DECLARE @Sayi1 INT
SELECT @Sayi1 = (SELECT COUNT(*) FROM Products)
IF @Sayi1>5000
BEGIN 
	PRINT '5000 DEN FAZLA ÜRÜN'
END
ELSE
BEGIN
	PRINT '5000 DEN AZ ÜRÜN'
END

IF EXISTS(SELECT * FROM sys.tables WHERE NAME = 'Products1') -- Var mý?
BEGIN
	PRINT 'Evet var'
END
ELSE
BEGIN
	PRINT 'Hayýr yok'
END

--IF NOT EXISTS() -- Yok mu?


--WHILE

--BREAK Döngüyü kýrar 
--CONTINUE Döngü devam ettirir

--0 ile 10 arasýndaki sayýlarý ekrana yazdýran SQL ifadesi
DECLARE @Sayac INT
SET @Sayac = 0

WHILE (@Sayac<=10)
	BEGIN
		PRINT @Sayac
		SET @Sayac += 1
	END

--Tüm ürünlerin fiyat ortalamalarýný kontrol edelim eðer 50’nin altýnda ise ürün fiyatýný ikiye katlayalým. 
--Tüm ürünlerin fiyatlarýnýn ortalamasý 50’üstüne çýkana kadar döngümüz devam etsin.
--While döngüsü içindeki kýsýmda ürün fiyatýný ikiye katladýktan sonra tabloda bulunan en pahalý ürünü bulup 50 den büyük mü diye bakalým eðer büyükse döngüyü BREAK ile sonlandýralým deðil ise CONTINUE ile döngüye devam edelim
SELECT AVG(UnitPrice) FROM Products

WHILE (SELECT AVG(UnitPrice) FROM Products) < 50
	BEGIN 
		UPDATE Products SET UnitPrice = UnitPrice * 2
		IF (SELECT MAX(UnitPrice) FROM Products) > 50
			BREAK
		ELSE
			CONTINUE
	END
PRINT 'MAXIMUM FÝYATI 50 DEN BÜYÜK'

--VERÝTABANINI BOZDUÐUMUZ ÝÇÝN ÝÞLEMÝ GERÝYE ALALIM

WHILE (SELECT AVG(UnitPrice) FROM Products) > 50
	BEGIN 
		UPDATE Products SET UnitPrice = UnitPrice / 2
		IF (SELECT MAX(UnitPrice) FROM Products) > 50
			BREAK
		ELSE
			CONTINUE
	END
PRINT 'MAXIMUM FÝYATI 50 DEN BÜYÜK'


--SP : STORED PROCEDURE : Derlenmiþ SQL cümlecikleri

--Ýstemci makinelerdeki iþ yükünü azaltýr ve performansýarttýrýr (yazýldýðý zaman ayný zamanda compile edildikleri için query optimizer tarafýndan optimize edilmiþ en hýzlý þekilde çalýþýr).
--SQL cümleleri, Saklý Yordamlardan çok daha yavaþ sonuçdöndürür.
--Networkü (Að Trafiðini) azaltýr.
--Açýk SQL cümleciklerine nazaran daha güvenlidir. Stored prosedüreler sadece giriþ ve çýkýþ parametreleri uygulama katmanýnda göründüðü için daha güvenilirdir.
--Programlama deyimlerini içerebilirler. if, try, catch , set vs.. Gelen parametrelere göre sorgu yapýlýp sonucun dönmesi saðlanabilir

--En fazla satýlan 6 ürünümü gösteren sp'yi ve sp'yi çalýþtýran kodlarý yazýnýz.
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


--Kargolara kayýt ekleyen stored procedure’ü ve stored procedure’ü çalýþtýran kodlarý yazýnýz. (isim eklemeniz yeterli)
CREATE PROC SP_InfoKayitEkle
(
@name NVARCHAR(30)
)
AS
BEGIN
	INSERT INTO Shippers(CompanyName) VALUES(@name)
END

EXEC SP_InfoKayitEkle 'Yurtiçi Kargo'

--Oluþturduðunuz KayýtEkle procedurunu telefon numarasý da eklensin þeklinde güncelleyiniz.
ALTER PROC SP_InfoKayitEkle
(
@name NVARCHAR(30),
@phone CHAR(20)
)
AS
INSERT INTO Shippers(CompanyName, Phone) VALUES(@name, @phone)

EXEC SP_InfoKayitEkle 'Yurtiçi Kargo', '123456789'

--Oluþturduðunuz KayýtEkle procedurunu silme komutunu yazýnýz.
DROP PROC SP_InfoKayitEkle


----Dýþarýdan girilen deðer kadar ürüne zam veya indirim yapan proc yazýnýz.
--(Ýþlemi ‘zam veya indirim’, ürünId’yi ve zam veya indirim miktarýný  dýþarýdan parametre ile biz göndereceðiz
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

--Hiç if olmadýðýný düþünelim
ALTER PROC SP_InfoZamIndirimYap
(
@miktar DECIMAL,
@proID INT
)
AS
UPDATE Products SET UnitPrice += @miktar WHERE ProductID = @proID

EXEC SP_InfoZamIndirimYap 100,2 --zam
EXEC SP_InfoZamIndirimYap -100,2 --indirim


--Dýþarýdan girilen kargo firmasý tarafýndan taþýnmýþ ve yine dýþarýdan girilen kargo ödemesi deðer aralýðýndaki sipariþleri proc ile listeleyiniz.
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

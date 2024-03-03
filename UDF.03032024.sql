--UDF USER DEFINED FUNCTIONS
-- 1. SCALER DEĞERLİ TEK DEĞER DÖNDÜREN FUNC.
-- 2. TABLO DÖNDÜREN FUNC.
-- 3. ÇOK DEYİMLİ TABLO DÖNDÜREN FUNC.

--2 sayının çarpımını bulan func.
CREATE FUNCTION FN_Carpma
(
@Sayi1 FLOAT, 
@Sayi2 FLOAT
)
RETURNS FLOAT
AS
BEGIN
	RETURN (@Sayi1 * @Sayi2)
END

SELECT dbo.FN_Carpma(1.4, 2.6) AS SONUC


--Norhtwind veritabanında Products tablosundaki tüm ürünlerin fiyatlarını 5₺ arttıran bir fonksiyon yazalım
CREATE FUNCTION FN_AddUnitPrice
(
@UnitPrice MONEY
)
RETURNS MONEY
AS
BEGIN
	DECLARE @Deger MONEY
	SET @Deger = @UnitPrice + 5
	RETURN @Deger
END

SELECT dbo.FN_AddUnitPrice(10) AS UrunFiyat

SELECT ProductName, dbo.FN_AddUnitPrice(UnitPrice) AS UrunFiyat FROM Products


--Northwind db'de, satış fiyatı ve kdv değerleri verildiğinde, kdv'yi ekleyerek son fiyatını veren fonk. yazınız. 
CREATE FUNCTION FN_KdvliUrun
(
@UrunFiyati INT,
@kdv INT
)
RETURNS INT
AS
BEGIN
	RETURN ((@UrunFiyati * @kdv) / 100) + @UrunFiyati
END

SELECT dbo.FN_KdvliUrun(100, 18)

SELECT ProductName, 
	UnitPrice, 
	dbo.FN_KdvliUrun(UnitPrice, 18) AS KdvliFiyat
FROM Products
ORDER BY KdvliFiyat


--Çalışanların belirli yıllarda kaç siparişte görev aldıklarını bulalım. EmployeeID ve Yıl bilgisini dışarıdan alan ve sonuç olarak, görev alınan sipariş bilgisini veren bir func. yazalım.
CREATE FUNCTION FN_SiparisAdet
(
@EmployeeId INT,
@Year INT
)
RETURNS INT
AS 
BEGIN
	RETURN (SELECT COUNT(OrderID) 
			FROM Orders
			WHERE EmployeeID = @EmployeeId 
				AND YEAR(OrderDate) = @Year)
END

SELECT COUNT(*) FROM Orders WHERE EmployeeID=5 AND OrderDate LIKE '%1996%'

SELECT dbo.FN_SiparisAdet(1,1996) AS SiparisAdet
SELECT dbo.FN_SiparisAdet(1,1997) AS SiparisAdet


--ÖDEVLER

--1. ders programı projesinin veri tabanı normalizasyon kurallarına göre


--2. Müşt. adı verilen bir müşteriye ait sipariş sayısını döndüren func.
CREATE FUNCTION FN_MusteriSiparisAdet
(
@MusteriAdi NVARCHAR(50),
)



--3. Yeni çalışan ekleyen sp yapılacak.
--Daha önce kayıtlı ise sistemde zaten kayıtlı diyecek ve eklemeyecek
--
--adı
--soyadı
--telefonu
--adresi
--not
--dogum tarihi

--bildigi prog dilleri

--yaşı 30 dan büyük olanları 
--HEM ÇALIŞANLAR TABLOSUNA HEMDE 
--ayrı bir denetmenler tablosuna ekleyecek

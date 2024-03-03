--Stok miktarý dýþarýdan girilen min. ve max. aralýðýnda olan
--ürün ücreti dýþarýdan girilen min. ve max. deðerler aralýðýnda olan
--toptancý firma adý dýþarýdan girilen karakterleri barýndýran tedarikçi firma adý, ürün fiyatý dýþarýdan girilen KDV uygulanmýþ haliyle listeleyiniz
CREATE PROC SP_StokFiyatKdv
(
@minStok SMALLINT,
@maxStok SMALLINT,
@minUcret DECIMAL,
@maxUcret DECIMAL,
@name NVARCHAR(50),
@kdv FLOAT
)
AS
BEGIN
	SELECT (p.UnitPrice + (p.UnitPrice * @kdv)) AS KdvliFiyat,
		p.ProductName,
		s.CompanyName
	FROM Products AS p
		INNER JOIN Suppliers AS s ON p.SupplierID = s.SupplierID
	WHERE p.UnitsInStock BETWEEN @minStok AND @maxStok
		AND p.UnitPrice BETWEEN @minUcret AND @maxUcret
		AND s.CompanyName LIKE '%' + @name + '%'
END

EXEC SP_StokFiyatKdv 10, 50, 50, 250, 'A', 0.18

SELECT * FROM Products WHERE ProductName LIKE '%Mishi%'


--SP ile tablo nesnesi oluþturunuz.
--Dýþarýdan tablo ismini, kolon isimlerini ve tiplerini parametre alacak.
CREATE PROC SP_TabloOlustur
(
@tabloAdi NVARCHAR(50),
@kolon1adi NVARCHAR(50), 
@kolon1tip NVARCHAR(50),
@kolon2adi NVARCHAR(50),
@kolon2tip NVARCHAR(50),
@kolon3adi NVARCHAR(50),
@kolon3tip NVARCHAR(50)
)
AS 
EXEC ('CREATE TABLE ' + @tabloAdi + '(' + @kolon1adi + ' ' + @kolon1tip + ',' + @kolon2adi + ' ' + @kolon2tip + ',' + @kolon3adi + ' ' + @kolon3tip + ',' + ')')

EXEC SP_TabloOlustur 'TestTablo', 'ID', 'INT PRIMARY KEY IDENTITY ', 'Adi', 'NVARCHAR(50)', 'Soyadi', 'NVARCHAR(50)'

SELECT * FROM TestTablo


--GERÝ DEÐER DÖNDÜREN SP

--Dýþarýdan aldýðý kategori ID'sine göre o kategoride kaç adet ürün olduðunu döndüren SP yazýnýz ve SP'yi çalýþtýran kodlarý yazýnýz
CREATE PROC SP_InfoUrunAdetDondur
(
@ID INT,
@adet INT OUTPUT
)
AS
BEGIN
	SELECT @adet = COUNT(*) 
	FROM Products
	WHERE CategoryID = @ID
END

DECLARE @adet1 INT
EXEC SP_InfoUrunAdetDondur 3, @adet1 OUT
SELECT @adet1 AS UrunAdet


--Urunler tablosundaki stok adedini geri döndüren sp yazalým 
CREATE PROC SP_InfoUrunStokAdetGetir
(
@UrunID INT,
@UrunAdet INT OUT
)
AS
BEGIN
	SET @UrunAdet = (SELECT UnitsInStock FROM Products WHERE ProductID = @UrunID)
END

DECLARE @adetgetir INT
EXECUTE SP_InfoUrunStokAdetGetir 1, @adetgetir OUT
SELECT @adetgetir AS STOK
PRINT @adetgetir


--Aþaðýdakiler son ürentilen IDENTITY deðerini verir

@@IDENTITY -- Tabloya baðlý trigger olmamalý
SCOPE_IDENTITY() --Trigger olsa da doðru çalýþýr
SELECT IDENT_CURRENT('Products')


INSERT INTO Products(ProductName, UnitPrice)
VALUES ('Info Yeni Ürün', 19.19)

DECLARE @ProductID INT
SET @ProductID = @@IDENTITY
SET @ProductID = SCOPE_IDENTITY()
SELECT @ProductID AS NewProductID

SELECT IDENT_CURRENT('Categories')


--Dýþarýdan girilen kategori adý ve ürün adý alan bir proc yazýnýz
--Eðer böyle bir kategori varsa ürün o kategoriye eklensin
--Yoksa önce kategoriyi ekleyip daha sonra ürünü kategoriye eklesin
CREATE PROC SP_KategoriEkle
(
@CatName NVARCHAR(50),
@CatId INT OUTPUT
)
AS 
BEGIN
	INSERT INTO Categories(CategoryName)
	VALUES (@CatName)
	SET @CatId = (SELECT SCOPE_IDENTITY())
END


CREATE PROC SP_UrunEkle
(
@UrunAdi NVARCHAR(50),
@KategoriAdi NVARCHAR(50)
)
AS
BEGIN
	DECLARE @katid INT
	IF NOT EXISTS(SELECT * FROM Categories WHERE CategoryName = @KategoriAdi)
		BEGIN
			EXEC SP_KategoriEkle @KategoriAdi, @katid OUT
		END
	ELSE
		BEGIN
			SET @katid = (SELECT CategoryID FROM Categories WHERE CategoryName = @KategoriAdi)
		END
	INSERT INTO Products(CategoryID, ProductName)
	VALUES (@katid, @UrunAdi)
END

EXEC SP_UrunEkle 'Yeni Test Ürün1', 'Meyveler'
EXEC SP_UrunEkle 'Yeni Test Ürün2', 'Beverages'



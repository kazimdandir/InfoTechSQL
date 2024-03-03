--Stok miktar� d��ar�dan girilen min. ve max. aral���nda olan
--�r�n �creti d��ar�dan girilen min. ve max. de�erler aral���nda olan
--toptanc� firma ad� d��ar�dan girilen karakterleri bar�nd�ran tedarik�i firma ad�, �r�n fiyat� d��ar�dan girilen KDV uygulanm�� haliyle listeleyiniz
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


--SP ile tablo nesnesi olu�turunuz.
--D��ar�dan tablo ismini, kolon isimlerini ve tiplerini parametre alacak.
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


--GER� DE�ER D�ND�REN SP

--D��ar�dan ald��� kategori ID'sine g�re o kategoride ka� adet �r�n oldu�unu d�nd�ren SP yaz�n�z ve SP'yi �al��t�ran kodlar� yaz�n�z
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


--Urunler tablosundaki stok adedini geri d�nd�ren sp yazal�m 
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


--A�a��dakiler son �rentilen IDENTITY de�erini verir

@@IDENTITY -- Tabloya ba�l� trigger olmamal�
SCOPE_IDENTITY() --Trigger olsa da do�ru �al���r
SELECT IDENT_CURRENT('Products')


INSERT INTO Products(ProductName, UnitPrice)
VALUES ('Info Yeni �r�n', 19.19)

DECLARE @ProductID INT
SET @ProductID = @@IDENTITY
SET @ProductID = SCOPE_IDENTITY()
SELECT @ProductID AS NewProductID

SELECT IDENT_CURRENT('Categories')


--D��ar�dan girilen kategori ad� ve �r�n ad� alan bir proc yaz�n�z
--E�er b�yle bir kategori varsa �r�n o kategoriye eklensin
--Yoksa �nce kategoriyi ekleyip daha sonra �r�n� kategoriye eklesin
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

EXEC SP_UrunEkle 'Yeni Test �r�n1', 'Meyveler'
EXEC SP_UrunEkle 'Yeni Test �r�n2', 'Beverages'



--Baðlý tablo örnekleri

SELECT * FROM Urunler
SELECT * FROM Kategoriler

--ELEKTRONÝK  VE MOBÝLYALARI GETÝR
SELECT * FROM Urunler
WHERE KategoriRefId=(SELECT KategoriId FROM Kategoriler WHERE KategoriAdi='Mobilya')
OR KategoriRefId=(SELECT KategoriId FROM Kategoriler WHERE KategoriAdi='Elektronik')

--ORTALAMA ÜRÜN FÝYATINDAN BÜYÜK OLAN ÜRÜNLER
SELECT * FROM Urunler WHERE UrunFiyati > (SELECT AVG(UrunFiyati) FROM Urunler)

--ORTALAMA ÜRÜN FÝYATINDAN BÜYÜK OLAN ELEKTRONÝK ÜRÜNLER
SELECT * FROM Urunler WHERE UrunFiyati > (SELECT AVG(UrunFiyati) FROM Urunler) 
AND KategoriRefId=(SELECT KategoriId FROM Kategoriler WHERE KategoriAdi='Elektronik')

--En pahalý ürün hangisi?
SELECT TOP 1* FROM Urunler
ORDER BY UrunFiyati DESC

--Kategori stok adetleri
SELECT KategoriRefId, SUM(UrunStokAdet) AS toplamStok 
FROM Urunler 
GROUP BY KategoriRefId

--ürün adý, ürün fiyatý, stok adedi, toplam tutar
SELECT UrunAdi, 
UrunFiyati, 
UrunStokAdet,
(UrunFiyati*UrunStokAdet) AS [Toplam Tutar]
FROM Urunler

--Kategori cirolarý 
SELECT KategoriRefId, SUM((UrunFiyati*UrunStokAdet)) AS Ciro
FROM Urunler
GROUP BY KategoriRefId

--ürün fiyatýna göre gruplama
SELECT UrunFiyati, COUNT(UrunFiyati) 
FROM Urunler
GROUP BY UrunFiyati

UPDATE Urunler SET UrunStokAdet=100, UrunAdi='TestUrun'
WHERE UrunFiyati BETWEEN 20000 AND 30000
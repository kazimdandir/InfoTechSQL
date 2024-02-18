--Ba�l� tablo �rnekleri

SELECT * FROM Urunler
SELECT * FROM Kategoriler

--ELEKTRON�K  VE MOB�LYALARI GET�R
SELECT * FROM Urunler
WHERE KategoriRefId=(SELECT KategoriId FROM Kategoriler WHERE KategoriAdi='Mobilya')
OR KategoriRefId=(SELECT KategoriId FROM Kategoriler WHERE KategoriAdi='Elektronik')

--ORTALAMA �R�N F�YATINDAN B�Y�K OLAN �R�NLER
SELECT * FROM Urunler WHERE UrunFiyati > (SELECT AVG(UrunFiyati) FROM Urunler)

--ORTALAMA �R�N F�YATINDAN B�Y�K OLAN ELEKTRON�K �R�NLER
SELECT * FROM Urunler WHERE UrunFiyati > (SELECT AVG(UrunFiyati) FROM Urunler) 
AND KategoriRefId=(SELECT KategoriId FROM Kategoriler WHERE KategoriAdi='Elektronik')

--En pahal� �r�n hangisi?
SELECT TOP 1* FROM Urunler
ORDER BY UrunFiyati DESC

--Kategori stok adetleri
SELECT KategoriRefId, SUM(UrunStokAdet) AS toplamStok 
FROM Urunler 
GROUP BY KategoriRefId

--�r�n ad�, �r�n fiyat�, stok adedi, toplam tutar
SELECT UrunAdi, 
UrunFiyati, 
UrunStokAdet,
(UrunFiyati*UrunStokAdet) AS [Toplam Tutar]
FROM Urunler

--Kategori cirolar� 
SELECT KategoriRefId, SUM((UrunFiyati*UrunStokAdet)) AS Ciro
FROM Urunler
GROUP BY KategoriRefId

--�r�n fiyat�na g�re gruplama
SELECT UrunFiyati, COUNT(UrunFiyati) 
FROM Urunler
GROUP BY UrunFiyati

UPDATE Urunler SET UrunStokAdet=100, UrunAdi='TestUrun'
WHERE UrunFiyati BETWEEN 20000 AND 30000
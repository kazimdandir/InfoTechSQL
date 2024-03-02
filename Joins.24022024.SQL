--JOIN VEYA INNER JOIN

SELECT * FROM Musteriler
SELECT * FROM Satislar

SELECT m.AdiSoyadi, m.Sehir, m.Sehir, s.SatilanMal, s.SatisFiyati 
FROM Musteriler AS m
INNER JOIN Satislar AS s 
ON m.id = s.id
WHERE s.SatisFiyati > 25000
ORDER BY s.SatisFiyati DESC


--LEFT JOIN

INSERT INTO Ogretmen (id, Ogretmen)
VALUES (1, 'Ali Veli'),(2, 'Can Canan'),(3, 'Cansu Cansýz'),(4, 'Veli Bitik'),(6,'Ahmet Mehmet')

INSERT INTO Ders (id, DersAdi, HaftalikSaat)
VALUES (1, 'Türkçe', 20),(2, 'Matematik', 25),(3, 'Ýngilizce', 10),(4, 'Fen', 5),(5,'Coðrafya',6)

SELECT * FROM Ogretmen
SELECT * FROM Ders

SELECT * FROM Ogretmen AS o
LEFT JOIN Ders AS d 
ON o.id=d.id


--RIGHT JOIN

SELECT * FROM Personel AS p
RIGHT JOIN Departman AS d
ON p.DepRefId=d.id


--FULL JOIN
SELECT * FROM Personel AS p
FULL JOIN Departman AS d
ON p.DepRefId=d.id

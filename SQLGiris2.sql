SELECT * FROM Personel

INSERT INTO Personel(adi, soyadi, gorevi, yoneticisi, girisTarihi, ucret)
VALUES('Ali', 'Veli', 'Yazýlýmcý', 1, '01-01-2000', 56000)

INSERT INTO Personel(adi, soyadi, gorevi, yoneticisi, girisTarihi, ucret)
VALUES('Veli', 'Can', 'Analist', 2, '01-01-2000', 56000)

INSERT INTO Personel(adi, soyadi, gorevi, yoneticisi, girisTarihi, ucret)
VALUES('Ayþe', 'Yýldýz', 'SQL Uzmaný', 1, '01-01-2000', 36500)

SELECT * FROM Personel WHERE ucret > (SELECT AVG(ucret) FROM Personel)

--GÝRÝÞ TARÝHÝ 2000DEN ÖNCE OLUP MAAÞI 10000DEN BÜYÜK OLANLAR
SELECT * FROM Personel 
WHERE girisTarihi < '01.01.2000' AND ucret > 25000
--UPDATE Personel SET girisTarihi='06.06.1998' WHERE personelNo=1

DELETE FROM Personel --Id'ler kaldýðý yerden devam eder
TRUNCATE TABLE Personel --Id'lerde resetlenir

DELETE FROM Personel
WHERE NOT ucret<45000

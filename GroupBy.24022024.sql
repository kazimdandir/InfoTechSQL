INSERT INTO Ulkeler (UlkeAd, SehirAd) 
VALUES
-- T�rkiye
('T�rkiye', '�stanbul'),
('T�rkiye', 'Ankara'),
('T�rkiye', '�zmir'),
('T�rkiye', 'Antalya'),
('T�rkiye', 'Bursa'),
-- Fransa
('Fransa', 'Paris'),
('Fransa', 'Marsilya'),
('Fransa', 'Lyon'),
-- Almanya
('Almanya', 'Berlin'),
('Almanya', 'M�nih'),
('Almanya', 'Hamburg'),
('Almanya', 'K�ln'),
('Almanya', 'Frankfurt'),
-- Rusya
('Rusya', 'Moskova'),
('Rusya', 'Sankt-Peterburg'),
-- ABD
('ABD', 'New York'),
('ABD', 'Los Angeles'),
('ABD',�'Chicago')

SELECT UlkeAd, COUNT(SehirAd) AS [�EH�R SAYISI] FROM Ulkeler
WHERE NOT SehirAd='�stanbul' --T�m sorguyu etkiler
GROUP BY UlkeAd
HAVING COUNT(SehirAd) > 3 --Grubu etkiler

SELECT DISTINCT UlkeAd FROM Ulkeler -- DISTINCT tekrar eden verileri tekler


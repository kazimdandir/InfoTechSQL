INSERT INTO Ulkeler (UlkeAd, SehirAd) 
VALUES
-- Türkiye
('Türkiye', 'Ýstanbul'),
('Türkiye', 'Ankara'),
('Türkiye', 'Ýzmir'),
('Türkiye', 'Antalya'),
('Türkiye', 'Bursa'),
-- Fransa
('Fransa', 'Paris'),
('Fransa', 'Marsilya'),
('Fransa', 'Lyon'),
-- Almanya
('Almanya', 'Berlin'),
('Almanya', 'Münih'),
('Almanya', 'Hamburg'),
('Almanya', 'Köln'),
('Almanya', 'Frankfurt'),
-- Rusya
('Rusya', 'Moskova'),
('Rusya', 'Sankt-Peterburg'),
-- ABD
('ABD', 'New York'),
('ABD', 'Los Angeles'),
('ABD', 'Chicago')

SELECT UlkeAd, COUNT(SehirAd) AS [ÞEHÝR SAYISI] FROM Ulkeler
WHERE NOT SehirAd='Ýstanbul' --Tüm sorguyu etkiler
GROUP BY UlkeAd
HAVING COUNT(SehirAd) > 3 --Grubu etkiler

SELECT DISTINCT UlkeAd FROM Ulkeler -- DISTINCT tekrar eden verileri tekler


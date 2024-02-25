create table tur(
turno int primary key identity,
turadi nvarchar(50)
)
go

create table yazar(
yazarno int primary key identity,
yazarad nvarchar(50),
yazarsoyad nvarchar(50)
)
go

create table kitap(
kitapno int primary key identity,
isbnno int,
kitapadi nvarchar(50),
yazarno int foreign key references yazar(yazarno),
turno int foreign key references tur(turno),
sayfasayisi int,
puan int
)
go

create table ogrenci(
ogrno int primary key identity,
ograd nvarchar(50),
ogrsoyad nvarchar(50),
cinsiyet nvarchar(5),
dtarih date,
sinif nvarchar(50),
puan int -- 100 puan basla
)
go

create table islem(
islemno int primary key identity,
ogrno int foreign key references ogrenci(ogrno),
kitapno int foreign key references kitap(kitapno),
atarih date,
vtarih date
)
go

insert into ogrenci (ograd, ogrsoyad, cinsiyet, dtarih, sinif, puan)
values
('ali', 'veli', 'erkek', '1996-01-01', 'A', 100),
('ayse', 'fatma', 'kadin', '1997-01-01', 'B', 100)

insert into yazar (yazarad, yazarsoyad)
values
('ahmet', 'can'),
('esin', 'ecem')

insert into tur (turadi)
values
('yazilim'),
('mizah')

insert into kitap (isbnno, kitapadi, yazarno, turno, sayfasayisi, puan)
values
(1, 'C#', 1, 1, 150, 95),
(2, 'php', 1, 1, 500, 90),
(3, 'yuruyen ucak', 2, 2, 100, 50)

insert into islem (ogrno, kitapno, atarih, vtarih)
values
(4, 1, '2024-01-01', '2024-01-02'),
(4, 2, '2024-01-02', '2024-02-01'),
(5, 3, '2024-01-03', '2024-02-15')

alter table ogrenci add tc varchar(11)
alter table ogrenci alter column ograd nvarchar(75)
select * into yedek_islem from islem

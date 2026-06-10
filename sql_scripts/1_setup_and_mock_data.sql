-- ========================================================
-- ADIM 1: TABLO YAPILARININ İNŞASI VE SENTETİK VERİ ÜRETİMİ
-- ========================================================

-- Müşteriler Tablosu
CREATE TABLE Musteriler (
    MusteriID SERIAL PRIMARY KEY,
    Ad VARCHAR(50),
    Soyad VARCHAR(50),
    Sehir VARCHAR(50),
    KayitTarihi DATE
);

-- Siparişler Tablosu
CREATE TABLE Siparisler (
    SiparisID SERIAL PRIMARY KEY,
    MusteriID INT,
    SiparisTarihi DATE,
    Tutar NUMERIC(10, 2),
    Durum VARCHAR(20)
);

-- 50.000 Müşteri Ekleme (generate_series)
INSERT INTO Musteriler (Ad, Soyad, Sehir, KayitTarihi)
SELECT 
    'MusteriAd_' || seq, 
    'MusteriSoyad_' || seq, 
    (ARRAY['Ankara', 'Istanbul', 'Izmir', 'Bursa', 'Antalya'])[floor(random() * 5 + 1)],
    CURRENT_DATE - (random() * 1000)::INT
FROM generate_series(1, 50000) seq;

-- 500.000 Sipariş Ekleme (generate_series)
INSERT INTO Siparisler (MusteriID, SiparisTarihi, Tutar, Durum)
SELECT 
    floor(random() * 50000 + 1),
    CURRENT_DATE - (random() * 500)::INT,
    (random() * 5000 + 50)::NUMERIC(10,2),
    (ARRAY['Bekliyor', 'Kargoda', 'Tamamlandı', 'İptal Edildi'])[floor(random() * 4 + 1)]
FROM generate_series(1, 500000) seq;

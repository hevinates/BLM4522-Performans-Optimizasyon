-- ========================================================
-- ADIM 2: İNDEKS MİMARİLERİNİN KURULUMU VE OPTİMİZASYON
-- ========================================================

-- Müşteriler tablosunda 'Sehir' kolonuna indeks ekleme
CREATE INDEX idx_musteri_sehir ON Musteriler(Sehir);

-- Siparişler tablosunda 'Durum' ve 'MusteriID' kolonlarına indeks ekleme
CREATE INDEX idx_siparis_durum ON Siparisler(Durum);
CREATE INDEX idx_siparis_musteriid ON Siparisler(MusteriID);

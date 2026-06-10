# PostgreSQL Performance Optimization & Query Tuning Framework

Bu proje; ağ tabanlı dağıtık sistemlerde veri yoğunluğunun yönetilmesi, sorgu darboğazlarının giderilmesi ve fiziksel disk optimizasyonunun sağlanması amacıyla geliştirilmiş, **yüksek hacimli (550.000+ kayıt)** bir veritabanı performans analizi çözümüdür. Sistem, macOS tabanlı PostgreSQL ortamı için optimize edilmiştir.

---

## 🚀 Proje Öne Çıkanlar

* **Large-Scale Dataset:** 50.000 müşteri ve 500.000 sipariş kaydından oluşan, indeks stres testlerine uygun sentetik veri kümesi.
* **Query Execution Analysis:** `EXPLAIN ANALYZE` yardımcı programı kullanılarak tespit edilen yavaş sorgular ve Sequential Scan darboğazlarının çözümlenmesi.
* **B-Tree Indexing Architecture:** Sık filtrelenen kolonlar (Şehir, Durum) üzerinde özel indeks mimarileri kurularak sorgu hızlarının milisaniye seviyelerine indirilmesi.
* **Disk Defragmentation:** `VACUUM FULL` operasyonları ile diskteki ölü satırların (dead tuples) temizlenmesi ve veri yoğunluğu optimizasyonu.
* **Role-Based Access Control (RBAC):** Veri yöneticisi ve analist profilleri için katı yetkilendirme (GRANT/REVOKE) matrislerinin kurulması.

---

## 📁 Proje Yapısı

| Klasör         | Teknik İçerik                                                                           |
| :------------- | :-------------------------------------------------------------------------------------- |
| `sql_scripts/` | Veritabanı şeması, 550.000 kayıt üreten fonksiyonlar ve İndeks/Rol tanımlama scriptleri |
| `screenshots/` | Optimizasyon öncesi/sonrası Execution Plan kanıtları ve terminal operasyon çıktıları    |

---

## 🛠 Kurulum ve Devreye Alma

### 1. Veri Setinin İnşası ve Sentetik Yükleme

Sistemi ayağa kaldırmak ve 550.000 satırlık mock datayı üretmek için:

```sql
-- Tablo iskeletlerinin kurulması ve veri üretim serilerinin (generate_series) çalıştırılması
psql -U postgres -d PerformansDB -f sql_scripts/1_setup_and_mock_data.sql
```

### 2. İndeksleme ve Optimizasyon

Sorgu darboğazlarını gidermek için indeks mimarilerinin devreye alınması:

```sql
psql -U postgres -d PerformansDB -f sql_scripts/2_index_creation.sql
```

### 3. Disk Alanı Bakımı (Vacuum)

Fiziksel disk optimizasyonu ve defragmentasyon için:

```sql
psql -U postgres -d PerformansDB -c "VACUUM FULL ANALYZE Musteriler;"
psql -U postgres -d PerformansDB -c "VACUUM FULL ANALYZE Siparisler;"
```

---

## ⚠️ Karşılaşılan Teknik Zorluklar ve Çözümler

### Hata (Bottleneck)

Büyük tablolar üzerinde JOIN ve GROUP BY işlemleri sırasında PostgreSQL'in tüm tabloyu taramak zorunda kalması (**Sequential Scan**) sebebiyle oluşan yüksek Execution Time (Sorgu Süresi) sorunu.

### Çözüm

Filtreleme kriteri olarak kullanılan **Sehir** ve **Durum** kolonlarına B-Tree Index yapıları tanımlanmıştır. Bu müdahale ile veritabanı motoru Bitmap Index Scan yöntemine geçiş yapmış, I/O maliyetleri düşürülerek sorgu sürelerinde %90'ın üzerinde performans artışı sağlanmıştır.


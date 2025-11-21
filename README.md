# Facebook-Scan

`Facebook-Scan` dizini Facebook verisi arama ve ZIP parçalarını birleştirme için hazırlanmış araçları içerir.
Bu README, `kurulum.sh` (parça birleştirici / unzip scripti) ve `face_scann.py` (Türkiye verisi üzerinde arama yapan Python scripti) için kullanım talimatları, bağımlılıklar ve örnek terminal çıktıları ("screenshot" olarak ASCII önizleme) içerir.

---

## İçindekiler
- `kurulum.sh` — Parçalanmış ZIP dosyalarını birleştirip `Turkey.txt` dosyasını çıkarır.
- `face_scann.py` — `Turkey.txt` içinde isim/soyisim/şehir kriterlerine göre arama yapan komut satırı aracı.
- `parcali_veri.*` — Parçalanmış zip dosyaları (projede örnek parçalar bulunuyor olabilir).

---

## Gereksinimler
- Python 3.8+
- `pyfiglet` ve `colorama` (terminal logoları ve renkli çıktılar için)
- `unzip`, `cat`, `du`, `wc` gibi temel Linux araçları (kurulum scripti için)

Kurulum (örnek):

```bash
# Python paketleri
pip install pyfiglet colorama

# unzip aracı (örnek Debian/Termux):
# Debian/Ubuntu
sudo apt update && sudo apt install -y unzip
# Termux (Android)
pkg update && pkg install -y unzip coreutils
```

---

## `kurulum.sh` kullanımı
Parçalanmış dosyaları (ör. `parcali_veri.z01` ... `parcali_veri.zip`) aynı dizine koyduktan sonra scripti çalıştırın:

```bash
chmod +x kurulum.sh
./kurulum.sh
```

Script başarılı çalışırsa `Turkey.zip` oluşturulacak ve içinden `Turkey.txt` çıkarılacaktır. Script sonrasında `Turkey.txt` dosyasının boyutu ve satır sayısı gösterilir.

### `kurulum.sh` - Örnek terminal önizleme
Aşağıda script çalıştırıldığında görebileceğiniz tipik bir çıktı örneği (ASCII önizleme) yer almaktadır:

```
╔════════════════════════════════════════╗
║        ZIP BİRLEŞTİRİCİ SCRIPT        ║
║           Renkli Versiyon             ║
╚════════════════════════════════════════╝

ℹ️ Parçalanmış dosyalar birleştiriliyor...
✅ Parçalanmış dosyalar bulundu, birleştirme başlıyor...
📁 Parçalar doğru sıralanıyor...
Birleştirilecek parçalar:
  • parcali_veri.z01 (4.0M)
  • parcali_veri.z02 (4.0M)
  • parcali_veri.z03 (4.0M)
  • parcali_veri.zip (1.2M)
Parçalar birleştiriliyor...
✅ Turkey.zip başarıyla oluşturuldu - Boyut: 13M

Turkey.zip açılıyor...
✅ Turkey.zip başarıyla açıldı
✅ Turkey.txt dosyası başarıyla çıkarıldı
  ↳ Boyut: 12M
  ↳ Satır sayısı: 123456

Temizlik işlemi...
✅ Turkey.zip silindi 🗑️
✅ Parça dosyaları silindi 🗑️

╔════════════════════════════════════════╗
║          İŞLEM TAMAMLANDI!            ║
╚════════════════════════════════════════╝

Son durum:
-rw-r--r-- 1 user user 12M Turkey.txt

İstatistikler:
  • Dosya: Turkey.txt
  • Boyut: 12M
  • Satır: 123456
  • Tarih: Fri Oct 17 12:34:56 UTC 2025

✅ Her şey hazır! Turkey.txt kullanıma hazır.
```

> Not: Gerçek dosya boyutları ve satır sayıları çalıştırma ortamına göre değişir.

---

## `face_scann.py` kullanımı
`face_scann.py`, `Turkey.txt` dosyasını okuyup satır satır filtreleme yapar ve eşleşen kayıtları renkli olarak terminale yazdırır.

Çalıştırma:

```bash
python face_scann.py
```

Script sizi şu sorularla yönlendirir:
- Ad (boş bırakılabilir)
- Soyad (boş bırakılabilir)
- Şehir (boş bırakılabilir)

Hiçbir filtre girmezseniz tüm kayıtları listeleme seçeneği sorulur.

### `face_scann.py` - Örnek terminal önizleme
Aşağıda scriptin çalıştığında verebileceği örnek bir çıktı gösterilmiştir:

```
  ________  ________  ________  ________
  __  ___/  __  ___/  __  ___/  __  ___/

🔍 Arama yapılıyor...
Ad: Ahmet
Soyad: Yılmaz
Şehir: Istanbul
--------------------------------------------------

🎯 **EŞLEŞME #1**
📋 Satır No: 15234
👤 Ad-Soyad: Ahmet Yılmaz
📞 Telefon: 05551234567
🆔 ID: 987654321
⚤ Cinsiyet: Male
🌍 Dil: tr
🏙️ Şehir: Istanbul
🔗 Profil: https://facebook.com/profile.php?id=987654321
----------------------------------------

✅ **ARAMA TAMAMLANDI**
📊 Toplam eşleşme: 1
```

## Dikkat & Etik Uyarı
- Bu araçlar yalnızca eğitim ve araştırma amaçlıdır.
- `Turkey.txt` veya benzeri toplu veri dosyalarını kullanırken yerel yasalar ve gizlilik kurallarına uyun.
- İzinsiz veri toplama, kişisel verileri kötüye kullanma veya hedefe yönelik saldırılar yasa dışıdır; sorumluluk kullanıcıya aittir.

---

## İsteğe Bağlı İyileştirmeler
- `face_scann.py` için `--output` parametresi ekleyip JSON/CSV çıktı desteği ekleyebilirim.
- `kurulum.sh` çıktısını doğrudan `Turkey.txt` yerine `src/` altına taşıyacak şekilde güncelleme yapabilirim.
- README'ye gerçek PNG ekran görüntüleri eklemek isterseniz, `assets/` klasörüne yükleyip README'ye gömülü görsel ekleyebilirim.

---

## Lisans
Bu proje MIT lisansı ile dağıtılmaktadır. Ayrıntılar proje kökündeki `LICENSE` dosyasında yer almaktadır.

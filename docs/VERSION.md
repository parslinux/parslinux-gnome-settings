# 🏷️ Sürümleme Politikası ve Versiyon Bilgisi (VERSION.md)

Bu belge, `parslinux-gnome-settings` paketinin sürüm numaralandırma kurallarını ve güncel durumunu belirtir.

---

## 📌 Mevcut Sürüm
- **Versiyon:** `1.0.0`
- **Yayın Tarihi:** 17 Ekim 2026
- **Kod Adı:** ParsLinux GNOME Genesis
- **Durum:** Kararlı (Stable)

---

## 📐 Semantik Sürümleme (SemVer 2.0.0)

Projede `MAJOR.MINOR.PATCH` formatı izlenir:

- **MAJOR (1.x.x):** GNOME Shell ana sürüm yükseltmeleri (örneğin GNOME 45 $\rightarrow$ 46 $\rightarrow$ 47) veya geriye dönük uyumsuz köklü şema değişikliklerinde artırılır.
- **MINOR (x.1.x):** Yeni uzantı destekleri, yeni şablonlar, varsayılan duvar kağıdı güncellemeleri veya yeni yönetim betikleri eklendiğinde artırılır.
- **PATCH (x.x.1):** Hata düzeltmeleri, çeviri güncellemeleri, yol düzeltmeleri veya küçük dokümantasyon revizyonlarında artırılır.

---

## 🚀 Yeni Sürüm Yayınlama Adımları

1. `debian/changelog` dosyasına yeni sürüm girdisi ekleyin:
   ```bash
   dch -v 1.0.1 "Açıklama"
   ```
2. Git etiketi (tag) oluşturun:
   ```bash
   git tag -a v1.0.1 -m "Release v1.0.1"
   git push origin v1.0.1
   ```
3. GitHub Actions otomatik olarak yeni `.deb` paketini inşa eder.

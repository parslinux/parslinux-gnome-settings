# 🤝 Katkıda Bulunma Kılavuzu (CONTRIBUTING.md)

ParsLinux GNOME Settings projesine katkıda bulunmak istediğiniz için teşekkür ederiz! Açık kaynak topluluğunun gücüne inanıyor ve her türlü yapıcı katkıyı memnuniyetle karşılıyoruz.

---

## 🚀 Nasıl Katkı Sağlayabilirsiniz?

1. **Hata Bildirimi (Bug Report):** Karşılaştığınız beklenmedik davranışları, bozuk şablonları veya hatalı masaüstü ayarlarını GitHub Issues üzerinden bildirebilirsiniz.
2. **Özellik Önerisi (Feature Request):** GNOME masaüstü deneyimini zenginleştirecek yeni uzantılar, kısayollar veya ayarlar önerebilirsiniz.
3. **Çeviri Katkısı (Localization):** Şablon oluşturucunun yeni dilleri desteklemesi için `po/` dizini altındaki gettext dosyalarını güncelleyebilirsiniz.
4. **Kod ve İyileştirme:** Hata düzeltmeleri ve paketleme geliştirmeleri için Pull Request açabilirsiniz.

---

## 🛠️ Geliştirme Süreci

1. Depoyu forklayın (`git fork`).
2. Yeni bir özellik dalı açın:
   ```bash
   git checkout -b feature/yeni-ozellik
   ```
3. Değişikliklerinizi yapın ve `./run.sh --check` veya `./package.sh` ile doğrulayın.
4. Değişiklikleri anlamlı bir mesajla işleyin (`git commit -m "feat: ..."`).
5. Kendi forkladığınız depoya gönderin ve GitHub üzerinden **Pull Request (PR)** oluşturun.

---

## 📜 Kod Standartları
- Shell betiklerinde `set -e` ve hata yakalama mekanizmaları kullanılmalıdır.
- Yollar ve isimlendirmelerde Pars Linux standartlarına (`parslinux-` öneki) sadık kalınmalıdır.
- Debian standartları (`debian/control`, `debian/changelog`) bozulmamalıdır.

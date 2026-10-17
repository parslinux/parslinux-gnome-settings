# 🧪 Test ve Doğrulama Kılavuzu (TESTING.md)

Bu belge, `parslinux-gnome-settings` paketinin kararlılık, sözdizimi doğruluğu ve sistem uyumluluğu açısından test edilmesine yönelik prosedürleri açıklar.

---

## 🔍 1. Statik Kod ve Sözdizimi Testleri

### A. GSettings Override Sözdizim Testi
GSettings şema geçersiz kılma dosyasında yazım hatası olup olmadığını denetlemek için:
```bash
glib-compile-schemas --strict --dry-run debian/
```

### B. Python Şablon Betiği Sözdizim Testi
```bash
python3 -m py_compile usr/share/parslinux/gnome-settings/xdg-parslinux-templates-gnome/xdg-parslinux-templates-gnome
```

### C. Makefile Derleme Testi
```bash
make -n
make install DESTDIR=/tmp/test-install
rm -rf /tmp/test-install
```

---

## 🖥️ 2. Çalışma Zamanı (Runtime) Fonksiyonel Testleri

1. **Şablon Oluşturucu Testi:**
   ```bash
   ./run.sh --templates
   ```
   `~/Şablonlar` veya `xdg-user-dir TEMPLATES` dizininde belgelerin oluşturulduğunu doğrulayın.

2. **Kullanıcı Oturumu Testi:**
   ```bash
   ./run.sh --apply-user
   ./run.sh --check
   ```
   Panel ikonunun ve favori uygulamaların güncellendiğini teyit edin.

---

## 📦 3. Paketleme Testi
```bash
./package.sh
dpkg -I build/*.deb
dpkg -c build/*.deb
```
Paketin doğru dosya izinleriyle ve bağımlılıklarla üretildiğinden emin olun.

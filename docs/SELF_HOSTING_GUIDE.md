# 🏢 Kendi Sunucunda Barındırma ve Kurumsal Dağıtım (SELF_HOSTING_GUIDE.md)

Bu rehber, kurumların, okulların veya toplulukların `parslinux-gnome-settings` paketini kendi gereksinimlerine göre özelleştirip yerel bir APT deposu üzerinden nasıl dağıtabileceğini açıklar.

---

## 🛠️ 1. Paketi Kendi Kurumunuza Göre Özelleştirme

1. **Kurumsal Logo:** `usr/share/parslinux/gnome-settings/start-parslinux-gnome.svg` dosyasını kendi logonuzla değiştirin.
2. **Sabitlenen Uygulamalar:** `debian/parslinux-gnome-settings.gsettings-override` içindeki `favorite-apps` listesine kurumunuza ait ERP, tarayıcı veya ofis araçlarının `.desktop` isimlerini ekleyin.
3. **Duvar Kağıdı:** Kurumsal arka plan görselinizin yolunu `picture-uri` alanına yazın.
4. **Şablonlar:** `usr/share/parslinux/gnome-settings/xdg-parslinux-templates-gnome/templates/` altına kurumsal antetli kağıt veya hesap tablosu şablonlarınızı ekleyin.

---

## 📦 2. Paketi Derleme ve Yerel Depoya Ekleme

```bash
# Paketi derleyin
./package.sh

# Çıkan paketi yerel depoya yükleyin (örnek: reprepro)
reprepro -b /var/packages/parslinux includedeb unstable build/*.deb
```

İstemci makineler `apt update && apt install parslinux-gnome-settings` komutuyla merkezi ayarları otomatik olarak alacaktır.

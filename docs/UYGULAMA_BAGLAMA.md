# 🔗 Uygulama Bağlama ve Entegrasyon Kılavuzu (UYGULAMA_BAGLAMA.md)

Bu belge, yeni geliştirilen Pars Linux uygulamalarının (örneğin `parslinux-software`, `parslinux-formatter`, `parslinux-package-installer` vb.) GNOME masaüstü paneline, favorilere ve dosya yöneticisi şablonlarına nasıl bağlanacağını anlatır.

---

## 📌 1. Favori Uygulamalar Listesine Ekleme

Yeni bir Pars Linux uygulamasını sistem kurulduğunda görev çubuğuna (alt panel / dock) varsayılan olarak sabitlemek için:

1. `debian/parslinux-gnome-settings.gsettings-override` dosyasını açın.
2. `[org.gnome.shell]` bölümündeki `favorite-apps` dizisine uygulamanın `.desktop` dosyasının adını ekleyin:
   ```ini
   [org.gnome.shell]
   favorite-apps = [ 'firefox-esr.desktop', 'org.gnome.Nautilus.desktop', 'org.parslinux.software.desktop', 'tr.org.parslinux.formatter.desktop' ]
   ```

---

## 🗂️ 2. Yeni Masaüstü Şablonu Bağlama

Bir uygulama için yeni bir belge şablonu (örneğin özel bir proje dosyası) tanımlamak için:

1. Şablon dosyanızı `usr/share/parslinux/gnome-settings/xdg-parslinux-templates-gnome/templates/` içine kopyalayın.
2. `usr/share/parslinux/gnome-settings/xdg-parslinux-templates-gnome/xdg-parslinux-templates-gnome` içindeki `templates` listesine dosya adını ve çevirilebilir adını ekleyin:
   ```python
   templates = [
       {"file": "Presentation.odp", "name": _("Presentation")},
       {"file": "OzelDosya.ext", "name": _("Özel Dosya")},
       ...
   ]
   ```
3. `po/` dosyalarını `update-translations.sh` ile güncelleyin.

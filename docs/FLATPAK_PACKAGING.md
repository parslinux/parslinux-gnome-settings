# 📦 Flatpak & Sandbox Ortamları Kılavuzu (FLATPAK_PACKAGING.md)

Bu belge, Flatpak tabanlı uygulamaların `parslinux-gnome-settings` ile entegrasyonunu ve sistem teması / dconf ayarlarının sandbox içindeki davranışını ele alır.

---

## 🌐 1. Flatpak ve GNOME Ayarları Entegrasyonu

Flatpak uygulamaları izole (sandboxed) bir ortamda çalışır. Pars Linux GNOME ayarlarının Flatpak uygulamalarında kusursuz görünmesi için aşağıdaki mekanizmalar kullanılır:

1. **XDG Desktop Portal (`xdg-desktop-portal-gnome`):**
   - Açık/koyu tema tercihi (`picture-uri` / dark mode).
   - Vurgu rengi (accent color).
   - Dosya seçici iletişim kutuları.
2. **DConf Okuma İzinleri:**
   - Flatpak uygulamaları, portal aracılığıyla ana sistemdeki `org.gnome.desktop.interface` ayarlarını (font, GTK teması vb.) okur.

---

## 🎨 2. Tema ve İkon Eşleşmesi

Flatpak uygulamalarının Pars Linux `adw-gtk3` ve `parslinux-gnome` ikon temasını kullanabilmesi için sistemde `org.gtk.Gtk3theme.adw-gtk3` Flatpak runtime uzantısının kurulu olması önerilir:

```bash
flatpak install flathub org.gtk.Gtk3theme.adw-gtk3
```

---

## ⚙️ 3. Flatpak İzinlerini Yönetme
Bir Flatpak uygulamasına dconf veya kullanıcı ayarlarını okuma yetkisi vermek gerekirse:
```bash
flatpak override --user --filesystem=xdg-config/dconf:ro <uygulama-id>
```

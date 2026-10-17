# 🏗️ ParsLinux GNOME Settings — Mimari Dokümantasyonu (ARCHITECTURE.md)

Bu belge, **ParsLinux GNOME Settings** (`parslinux-gnome-settings`) paketinin mimari katmanlarını, GNOME masaüstü bileşenleri arasındaki veri akışını, sistem önceliklerini ve dizin organizasyonunu detaylandırmaktadır.

---

## 📌 1. Sistematik Mimari Şeması

```
┌────────────────────────────────────────────────────────┐
│                   Kullanıcı Katmanı                    │
│   • ~/.config/dconf/user (Kullanıcı dconf DB'si)       │
│   • ~/Şablonlar (Otomatik üretilen kullanıcı belgeleri)│
└───────────────────────────┬────────────────────────────┘
                            │ (Varsayılanları çeker)
                            ▼
┌────────────────────────────────────────────────────────┐
│           DConf Sistem Profili Katmanı                 │
│   • /etc/dconf/profile/user (Profil tanımı)            │
│   • /etc/dconf/db/local.d/20-parslinux (Ayarlar)       │
│   • /etc/dconf/db/local (Derlenmiş sistem dconf DB'si) │
└───────────────────────────┬────────────────────────────┘
                            │ (Fallback & Şema tabanı)
                            ▼
┌────────────────────────────────────────────────────────┐
│              GSettings Override Katmanı                │
│   • /usr/share/glib-2.0/schemas/                       │
│     └── 20_parslinux-gnome-settings.gschema.override   │
│   • /usr/share/glib-2.0/schemas/gschemas.compiled      │
└───────────────────────────┬────────────────────────────┘
                            │
                            ▼
┌────────────────────────────────────────────────────────┐
│             Varlıklar ve Başlatıcılar                  │
│   • /usr/share/parslinux/gnome-settings/               │
│     ├── start-parslinux-gnome.svg                      │
│     └── xdg-parslinux-templates-gnome/                 │
│   • /etc/xdg/autostart/                                │
│     └── xdg-parslinux-templates-gnome.desktop          │
└────────────────────────────────────────────────────────┘
```

---

## ⚙️ 2. Yapılandırma Katmanlarının Öncelik Sıralaması

1. **User Database (`~/.config/dconf/user`):** Kullanıcının GNOME Ayarları (gnome-control-center) veya dconf-editor ile doğrudan yaptığı değişiklikler en yüksek önceliğe sahiptir.
2. **System Database (`/etc/dconf/db/local`):** `/etc/dconf/db/local.d/20-parslinux` içindeki Dash-to-Panel ve sistem geneli görsel zorunluluklar burada tutulur.
3. **GSettings Vendor Overrides (`/usr/share/glib-2.0/schemas/`):** Öncelik seviyesi `20` olan `20_parslinux-gnome-settings.gschema.override`, standart GNOME şemalarını Pars Linux dağıtım tercihlerine göre ezerek ilk oturumda yükler.

---

## 📂 3. Dizin ve Dosya Sorumlulukları

- `dconf/20-parslinux`: Dash to Panel uzantısının alt panel olarak hizalanması, şeffaflık oranları ve Pars Linux başlatıcı ikon dosyasının mutlak yolu.
- `dconf/user`: Dconf profil tanımı. `user-db:user` ve `system-db:local` veritabanlarını birbirine bağlar.
- `debian/parslinux-gnome-settings.gsettings-override`:
  - `favorite-apps`: Sabitlenen uygulamalar (`org.parslinux.software.desktop` vb.)
  - `font-name` & `monospace-font-name`: Yazı tipi aileleri.
  - `icon-theme` & `gtk-theme`: Simge ve pencere teması.
  - `button-layout`: Pencere butonlarının dizilişi (`appmenu:minimize,maximize,close`).
- `etc/xdg/autostart/xdg-parslinux-templates-gnome.desktop`: GNOME oturumu açıldığında arka planda çalışan şablon betiği.
- `usr/share/parslinux/gnome-settings/xdg-parslinux-templates-gnome/`:
  - Python tabanlı şablon oluşturucu.
  - Çok dilli gettext desteği (`po/`, `.mo`).
  - ODT, ODS, ODP ve düz metin şablon kaynakları.

---

## 🔒 4. Çoklu Kullanıcı ve Güvenlik Uyumluluğu

- Sistem geneli yapılandırmalar `/etc` ve `/usr` altında salt okunur olarak saklanır.
- Kullanıcıların kendi özelleştirmeleri ev dizininde tutulur; paket güncellemelerinde kullanıcı tercihleri korunur.
- Şablon mekanizması `~/.config/parslinux/gnome-templates` bayrak dosyasını denetleyerek kullanıcının mevcut dosyalarının üzerine asla yazmaz.

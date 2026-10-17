# 🏗️ ParsLinux GNOME Settings — Mimari Dokümantasyonu

Bu belge, `parslinux-gnome-settings` paketinin iç yapısını, GNOME yapılandırma katmanlarını (GSettings, dconf, autostart) ve şablon mekanizmasını açıklamaktadır.

---

## 1. GNOME Yapılandırma Katmanları

Pars Linux GNOME masaüstünde iki temel ayar mekanizması kullanılır:

```
┌────────────────────────────────────────────────────────┐
│                   Kullanıcı Oturumu                    │
│   (Kullanıcının kendi değiştirdiği dconf/gsettings)    │
└───────────────────────────┬────────────────────────────┘
                            │
                            ▼
┌────────────────────────────────────────────────────────┐
│              DConf Profili (/etc/dconf)                │
│    • /etc/dconf/profile/user                           │
│    • /etc/dconf/db/local.d/20-parslinux                │
│   (Dash-to-Panel ve sistem geneli zorunlu/varsayılan)  │
└───────────────────────────┬────────────────────────────┘
                            │
                            ▼
┌────────────────────────────────────────────────────────┐
│      GSettings Overrides (/usr/share/glib-2.0)         │
│    • 20_parslinux-gnome-settings.gschema.override      │
│   (Favori uygulamalar, yazı tipleri, pencere düzeni)   │
└────────────────────────────────────────────────────────┘
```

---

## 2. Bileşenler

### A. GSettings Override (`debian/parslinux-gnome-settings.gsettings-override`)
- Paket derlendiğinde veya `install.sh` çalıştırıldığında `/usr/share/glib-2.0/schemas/20_parslinux-gnome-settings.gschema.override` olarak yerleştirilir.
- `glib-compile-schemas` çalıştırıldığında gschemas.compiled içine dahil olur.
- Yeni oluşturulan kullanıcıların masaüstü varsayılanlarını belirler.

### B. DConf Veritabanı ve Profili (`dconf/`)
- `dconf/user`: `/etc/dconf/profile/user` dosyasına kurulur. Profil tanımlar:
  ```ini
  user-db:user
  system-db:local
  ```
- `dconf/20-parslinux`: `/etc/dconf/db/local.d/20-parslinux` dosyasına kurulur. Dash-to-Panel uzantısının simgesini, şeffaflığını ve davranışını belirler.
- `dconf update` komutu çalıştırıldığında `/etc/dconf/db/local` ikili veritabanı derlenir.

### C. Şablon Mekanizması (`usr/share/parslinux/gnome-settings/xdg-parslinux-templates-gnome`)
- Kullanıcı ilk oturum açtığında `/etc/xdg/autostart/xdg-parslinux-templates-gnome.desktop` otomatik devreye girer.
- Script kullanıcının ev dizinindeki `~/.config/parslinux/gnome-templates` dosyasını kontrol eder.
- Eğer dosya yoksa ve kullanıcının `~/Şablonlar` dizini boşsa:
  - Sunum (`Presentation.odp`)
  - Hesap Tablosu (`Spreadsheet.ods`)
  - Kelime İşlemci (`Word Processor.odt`)
  - Metin Belgesi (`Text Document`)
  dosyalarını kullanıcının yerel dilinde (Türkçe vb.) adlandırarak şablon klasörüne kopyalar.

### D. Marka & Görseller
- `/usr/share/parslinux/gnome-settings/start-parslinux-gnome.svg`: Başlatıcı (Dash to Panel) ana menü buton simgesi.
- Arka planlar: `/usr/share/backgrounds/parslinux-default-light.svg` ve `dark.svg`.

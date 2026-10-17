# 🐆 ParsLinux GNOME Settings

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL3-blue.svg)](LICENSE)
[![Platform: Pars Linux](https://img.shields.io/badge/Platform-Pars_Linux-success.svg)](https://parslinux.org)
[![Desktop: GNOME](https://img.shields.io/badge/Desktop-GNOME-orange.svg)](https://www.gnome.org)

**ParsLinux GNOME Settings**, Pars Linux GNOME masaüstü ortamının öntanımlı görsel tercihlerini, panel yerleşimini (dash-to-panel), GSettings/DConf yapılandırmalarını ve yeni kullanıcı şablonlarını yöneten sistem paketidir.

---

## 🚀 Özellikler

- **🎯 Öntanımlı Panel & Arayüz Yapılandırması:** `dash-to-panel` ile modern alt görev çubuğu, Pars Linux başlatıcı simgesi ve optimize edilmiş şeffaflık/odak efektleri.
- **⚙️ GSettings Şema Geçersiz Kılmaları (Overrides):**
  - **Favori Uygulamalar:** Firefox ESR, Nautilus ve Pars Linux Yazılım Merkezi (`org.parslinux.software.desktop`).
  - **İkon & Yazı Tipi:** `parslinux-gnome` simge seti, Ubuntu font ailesi.
  - **Pencere Butonları:** `appmenu:minimize,maximize,close` düzeni ve sağ tuşla boyutlandırma.
  - **Duvar Kağıtları:** Açık ve koyu tema için `/usr/share/backgrounds/parslinux-default-*.svg` tanımları.
- **📁 Otomatik Şablon Oluşturucu:** Kullanıcının `~/Şablonlar` (`xdg-user-dir TEMPLATES`) dizinine metin, hesap tablosu, sunum ve kelime işlemci şablonlarını otomatik yerleştirir.
- **🛠️ Kolay Yönetim Betikleri:** Kurulum, kaldırma, test ve paketleme işlemlerini tek komutla çalıştırabilme.

---

## 📂 Dizin Yapısı

```bash
parslinux-gnome-settings/
├── dconf/
│   ├── 20-parslinux               # dash-to-panel vb. dconf anahtarları
│   └── user                       # dconf profil tanımı (user-db / system-db)
├── debian/
│   ├── changelog                  # Sürüm ve paket geçmişi
│   ├── control                    # Paket bağımlılıkları ve üstveri
│   ├── copyright                  # Telif ve lisans bilgileri
│   ├── parslinux-gnome-settings.gsettings-override  # Öntanımlı GSettings anahtarları
│   ├── postinst                   # Kurulum sonrası dconf update betiği
│   └── rules                      # dh derleme kuralları
├── docs/                          # Ayrıntılı dokümantasyon
│   ├── ARCHITECTURE.md            # Mimari ve yapılandırma rehberi
│   ├── GSETTINGS_DCONF_GUIDE.md   # GSettings ve dconf ayarları referansı
│   └── INSTALL.md                 # Kurulum, test ve paketleme kılavuzu
├── etc/
│   └── xdg/autostart/
│       └── xdg-parslinux-templates-gnome.desktop     # Şablon autostart girişi
├── usr/
│   └── share/parslinux/gnome-settings/
│       ├── start-parslinux-gnome.svg                 # Başlatıcı logosu
│       └── xdg-parslinux-templates-gnome/            # Şablon betiği, po ve dosyalar
├── Makefile                       # Standart derleme ve kurulum yöneticisi
├── install.sh                     # Sistem genelinde kurulum betiği
├── uninstall.sh                   # Sistemden temizleme betiği
├── run.sh                         # Çalıştırma, test ve kullanıcı oturumuna uygulama aracı
└── package.sh                     # Debian (.deb) paketi inşa aracı
```

---

## ⚡ Hızlı Başlangıç

### 1. Çalıştırma ve Test (`run.sh`)
Şablon oluşturucuyu denemek veya ayarları mevcut kullanıcı oturumunuza hemen uygulamak için:

```bash
./run.sh
```

Veya doğrudan parametrelerle:
```bash
./run.sh --templates     # Yalnızca şablonları oluşturur
./run.sh --apply-user    # GSettings ve dconf ayarlarını geçerli oturuma uygular
./run.sh --check         # Mevcut oturum ayarlarını listeler
```

---

### 2. Sisteme Kurulum (`install.sh`)
Ayarları, dconf profilini ve şablonları sistem genelinde geçerli kılmak için:

```bash
sudo ./install.sh
```
Bu işlem dosyaları kopyalar, `glib-compile-schemas` çalıştırır ve `dconf update` ile sistem veritabanını yeniler.

---

### 3. Sistemden Kaldırma (`uninstall.sh`)
Tüm Pars Linux ayarlarını ve şablonlarını sistemden temizlemek için:

```bash
sudo ./uninstall.sh
```

---

### 4. Debian Paketi Oluşturma (`package.sh`)
`.deb` paketi üretmek için:

```bash
./package.sh
```
Üretilen paket `build/parslinux-gnome-settings_1.0.0_all.deb` konumuna kaydedilir.

Paketi kurmak için:
```bash
sudo dpkg -i build/parslinux-gnome-settings_1.0.0_all.deb
sudo apt-get install -f
```

---

## 📖 Dokümantasyon

Daha ayrıntılı bilgi için [docs/](docs/) klasöründeki belgelere göz atabilirsiniz:
- 🏗️ [Mimari ve Yapı ([`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md))](docs/ARCHITECTURE.md)
- ⚙️ [GSettings ve DConf Ayar Rehberi ([`docs/GSETTINGS_DCONF_GUIDE.md`](docs/GSETTINGS_DCONF_GUIDE.md))](docs/GSETTINGS_DCONF_GUIDE.md)
- 📦 [Kurulum ve Paketleme Rehberi ([`docs/INSTALL.md`](docs/INSTALL.md))](docs/INSTALL.md)

---

## 📄 Lisans
Bu proje **GNU General Public License v3.0 (GPL-3.0)** kapsamında lisanslanmıştır. Detaylar için [debian/copyright](debian/copyright) dosyasına bakabilirsiniz.

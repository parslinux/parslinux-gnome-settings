# 📦 ParsLinux GNOME Settings — Kurulum, Kaldırma ve Paketleme Rehberi

Bu belge, `parslinux-gnome-settings` paketinin geliştirme ortamında nasıl kurulacağını, test edileceğini, kaldırılacağını ve Debian `.deb` paketine nasıl dönüştürüleceğini adım adım anlatmaktadır.

---

## 📋 Önkoşullar

Debian veya Pars Linux üzerinde geliştirme ve test için önerilen temel araçlar:
```bash
sudo apt update
sudo apt install -y make gettext dconf-cli libglib2.0-bin dpkg-dev debhelper
```

---

## 🛠️ Yönetim Betikleri

Proje kök dizininde 4 adet optimize edilmiş yardımcı betik bulunmaktadır:

| Betik | Görevi | Root Yetkisi |
|---|---|:---:|
| **[`run.sh`](../run.sh)** | Şablonları çalıştırma, kullanıcı oturumuna ayarları anında uygulama veya test etme | ❌ |
| **[`install.sh`](../install.sh)** | Makefile ile tüm dosyaları `/usr` ve `/etc` altına kurar, şemaları ve dconf'u günceller | ✔️ (sudo) |
| **[`uninstall.sh`](../uninstall.sh)** | Sisteme kurulan tüm yapılandırmaları ve şablonları kaldırır | ✔️ (sudo) |
| **[`package.sh`](../package.sh)** | `build/` dizini altına `.deb` paketi üretir | ❌ |

---

## 1. Çalıştırma ve Test (`run.sh`)

Sistem geneline kurmadan önce kendi kullanıcı hesabınızda test etmek için:

```bash
# İnteraktif menü ile çalıştırma
./run.sh

# Veya komut satırı argümanları ile:
./run.sh --templates     # Şablon oluşturucuyu çalıştırır
./run.sh --apply-user    # Ayarları gsettings/dconf ile kullanıcı oturumuna uygular
./run.sh --check         # Mevcut masaüstü ayarlarını kontrol eder
```

---

## 2. Sistem Geneline Kurulum (`install.sh`)

Sistemin varsayılan masaüstü ayarlarını güncellemek için:

```bash
sudo ./install.sh
```

Yapılan işlemler:
1. `make install` çağrılır.
2. `debian/parslinux-gnome-settings.gsettings-override` dosyası `/usr/share/glib-2.0/schemas/20_parslinux-gnome-settings.gschema.override` olarak kopyalanır.
3. `glib-compile-schemas /usr/share/glib-2.0/schemas/` çalıştırılır.
4. `/etc/dconf/db/local` temizlenip `dconf update` ile veritabanı yeniden derlenir.

---

## 3. Sistemden Kaldırma (`uninstall.sh`)

Tüm bileşenleri temizlemek için:

```bash
sudo ./uninstall.sh
```

---

## 4. Debian Paketi Hazırlama (`package.sh`)

```bash
./package.sh
```

- Sistemde `dpkg-buildpackage` varsa standart Debian derleme adımlarını izler.
- Başka bir dağıtımda (Arch, Fedora vb.) çalışıyorsanız bağımsız ar/tar mekanizmasıyla tam uyumlu `.deb` paketi üretir.
- Üretilen paket `build/parslinux-gnome-settings_1.0.0_all.deb` yolunda hazır olur.

### Paketi Kurma:
```bash
sudo dpkg -i build/parslinux-gnome-settings_1.0.0_all.deb
sudo apt-get install -f
```

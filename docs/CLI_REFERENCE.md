# 💻 Uçbirim (CLI) Referansı (CLI_REFERENCE.md)

Bu belge, `parslinux-gnome-settings` bileşenlerinin uçbirimden (komut satırı) yönetimi ve hata ayıklaması için kullanılabilecek komutları listeler.

---

## 1. Proje Yönetim Betikleri

### 🔹 `run.sh`
```bash
./run.sh [SEÇENEK]
```
- *(Parametresiz)*: Etkileşimli terminal menüsünü açar.
- `--templates`: Şablon oluşturucuyu çalıştırır (`xdg-parslinux-templates-gnome`).
- `--apply-user`: GSettings ve dconf ayarlarını mevcut kullanıcıya anında uygular.
- `--check`: Kullanıcı oturumundaki masaüstü ayarlarını okur ve raporlar.

### 🔹 `install.sh`
```bash
sudo ./install.sh
```
Makefile üzerinden dosyaları sisteme kopyalar, `/usr/share/glib-2.0/schemas/` altına override'ı yerleştirir, `glib-compile-schemas` ve `dconf update` komutlarını yürütür.

### 🔹 `uninstall.sh`
```bash
sudo ./uninstall.sh
```
Sistem geneline kurulan dosyaları siler, dconf ve gsettings şema önbelleklerini temizler.

### 🔹 `package.sh`
```bash
./package.sh
```
Bağımsız Debian ikili paketi (`.deb`) üretir. Üretilen paket `build/` dizinine yerleştirilir.

---

## 2. GSettings Komut Satırı İpuçları

```bash
# Mevcut favori uygulamaları listele
gsettings get org.gnome.shell favorite-apps

# Favorileri sıfırla (dağıtım varsayılanına döner)
gsettings reset org.gnome.shell favorite-apps

# İkon temasını sorgula
gsettings get org.gnome.desktop.interface icon-theme

# Pencere buton düzenini sorgula
gsettings get org.gnome.desktop.wm.preferences button-layout
```

---

## 3. DConf Komut Satırı İpuçları

```bash
# Sistem dconf veritabanını yenile (root olarak)
sudo dconf update

# Dash-to-panel ayarlarını dök
dconf dump /org/gnome/shell/extensions/dash-to-panel/

# Başlatıcı simge yolunu oku
dconf read /org/gnome/shell/extensions/dash-to-panel/show-apps-icon-file
```

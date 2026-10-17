# ⚙️ GSettings ve DConf Yapılandırma Kılavuzu

Bu belge, `parslinux-gnome-settings` paketindeki tüm GSettings override ve dconf ayarlarının ayrıntılı dökümünü içerir.

---

## 1. GSettings Override Dosyası
Konum: `debian/parslinux-gnome-settings.gsettings-override`  
Sistemdeki hedefi: `/usr/share/glib-2.0/schemas/20_parslinux-gnome-settings.gschema.override`

### 🔹 [org.gnome.shell]
- **`favorite-apps`**: `[ 'firefox-esr.desktop', 'org.gnome.Nautilus.desktop', 'org.parslinux.software.desktop' ]`
  - Görev çubuğunda (dock/panel) sabitlenen varsayılan uygulamalar. Pars Linux Yazılım Merkezi dahil edilmiştir.
- **`enabled-extensions`**: GNOME Shell başlatıldığında otomatik aktif olan uzantılar:
  - `dash-to-panel@jderose9.github.com` (Alt görev çubuğu)
  - `blur-my-shell@aunetx` (Şeffaflık ve bulanıklık)
  - `clipboard-indicator@tudmotu.com` (Pano geçmişi)
  - `ding@rastersoft.com` (Masaüstü simgeleri)
  - `appindicatorsupport@rgcjonas.gmail.com` (Sistem tepsisi ikonları)
  - `rounded-window-corners@yilozt` (Pencere köşe yuvarlatma)
  - `gtk3-theme-switcher@adwgtk3` ve `gtk3-accent-sync@pardus.org.tr` (Renk ve tema uyumu)
  - `date-menu-formatter@marcinjakubowski.github.com` (Saat ve tarih formatı)

### 🔹 [org.gnome.desktop.interface]
- **`font-name`**: `'Ubuntu 11'`
- **`monospace-font-name`**: `'Ubuntu Mono 13'`
- **`gtk-theme`**: `'adw-gtk3'` (GNOME Libadwaita ile GTK3 uygulamaları arasında görsel uyum)
- **`icon-theme`**: `'parslinux-gnome'` (Pars Linux öntanımlı simge teması)
- **`enable-hot-corners`**: `false` (Sol üst köşeye çarpınca aktivitelerin açılması kapalı)

### 🔹 [org.gnome.desktop.background]
- **`picture-uri`**: `'file:///usr/share/backgrounds/parslinux-default-light.svg'`
- **`picture-uri-dark`**: `'file:///usr/share/backgrounds/parslinux-default-dark.svg'`

### 🔹 [org.gnome.desktop.wm.preferences]
- **`button-layout`**: `'appmenu:minimize,maximize,close'` (Pencere başlığında simge durumuna küçült, büyüt ve kapat butonları)
- **`resize-with-right-button`**: `true` (Alt + Sağ Tık ile pencere boyutlandırma)

### 🔹 [org.parslinux.parslinux-gnome-greeter]
- **`layout-name`**: `'parslinux'`

---

## 2. DConf Profili ve Ayarları
Konum: `dconf/20-parslinux`  
Sistemdeki hedefi: `/etc/dconf/db/local.d/20-parslinux`

### 🔹 [org/gnome/shell/extensions/dash-to-panel]
- **`show-apps-icon-file`**: `'/usr/share/parslinux/gnome-settings/start-parslinux-gnome.svg'`
  - Başlat menüsü simgesi olarak Pars Linux logosunu kullanır.
- **`trans-use-custom-opacity`**: `true`
- **`trans-panel-opacity`**: `0.3` (Masaüstü boşken panel şeffaflığı)
- **`trans-dynamic-anim-target`**: `0.6` (Pencere yaklaştığında dinamik şeffaflık)
- **`group-apps`**: `true` (Aynı uygulamaya ait pencereleri panelde gruplar)
- **`dot-color-dominant`**: `true` (Çalışan uygulamanın baskın renginde gösterge noktası)
- **`dot-style-unfocused`**: `'DASHES'` (Odakta olmayan çalışan uygulamalar için çizgi göstergesi)

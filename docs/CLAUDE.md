# 🤖 CLAUDE / AI Assistant Kılavuzu (CLAUDE.md)

Bu dosya; Claude, Gemini, Antigravity ve diğer yapay zeka kodlama asistanlarının **parslinux-gnome-settings** reposunda çalışırken uyması gereken mimari kuralları ve komutları içerir.

---

## 📌 Proje Genel Bakışı
- **Paket:** `parslinux-gnome-settings`
- **Türü:** GNOME Masaüstü Yapılandırma ve Varlık Paketi (GSettings, DConf, Templates, Assets)
- **Ekosistem:** Pars Linux (Debian tabanlı)
- **Ana Diller:** Bash, Python 3, Make, INI / GSettings Syntax

---

## 🛠️ Temel Komutlar
```bash
# Test çalıştırma (Şablonlar)
./run.sh --templates

# Ayarları mevcut kullanıcıya uygulama
./run.sh --apply-user

# Sistem geneline kurma
sudo ./install.sh

# Sistemden temizleme
sudo ./uninstall.sh

# Debian (.deb) paketi üretme
./package.sh
```

---

## ⚠️ Geliştirici Kuralları
1. **Pardus Kalıntılarına İzin Verme:** Dosya yollarında, betiklerde ve meta verilerde eski `pardus` isimlendirmeleri yerine her zaman `parslinux` standardını kullanın.
2. **Kullanıcı Verilerini Ezme:** Şablon betiği `~/.config/parslinux/gnome-templates` dosyasını denetlemeli ve kullanıcının var olan dosyalarını silmemelidir.
3. **DConf ve GSettings Senkronizasyonu:** `dconf/20-parslinux` veya `debian/parslinux-gnome-settings.gsettings-override` değiştirildiğinde `Makefile`, `install.sh` ve `package.sh` içerisindeki hedef yolların senkronize olduğundan emin olun.
4. **Kod Bütünlüğü:** Dosya düzenlemelerinde mevcut yorum satırlarını ve telif bildirimlerini koruyun.

# 💾 Veri Koruma ve Yapılandırma Saklama Rehberi (DATA_SAVING_GUIDE.md)

Bu rehber, `parslinux-gnome-settings` paketinin sistem ve kullanıcı verileriyle nasıl etkileşime girdiğini, kullanıcı tercihlerinin güncellemeler sırasında nasıl korunduğunu açıklar.

---

## 🛡️ 1. Kullanıcı Verilerinin Korunma İlkeleri

1. **Ev Dizini İzolasyonu:** Bu paket sistem geneline (`/usr`, `/etc`) kurulur. Kullanıcının ev dizini (`~`) altındaki özel yapılandırmalara (`~/.config/dconf/user`) paket kurulumu sırasında asla doğrudan müdahale edilmez.
2. **Kişiselleştirme Önceliği:** GNOME mimarisinde kullanıcı tarafından yapılan ayarlar her zaman `/etc/dconf` ve `/usr/share/glib-2.0/schemas` varsayılanlarını ezer. Paketin güncellenmesi kullanıcının değiştirdiği ayarları sıfırlamaz.
3. **Şablon Güvenliği:** `xdg-parslinux-templates-gnome` betiği, kullanıcının `~/Şablonlar` dizininde önceden var olan dosyaların üzerine asla yazmaz. Yalnızca dizin tamamen boşsa ve `~/.config/parslinux/gnome-templates` bayrağı yoksa ilk kez kopyalama yapar.

---

## 🔄 2. Masaüstü Ayarlarını Yedekleme ve Geri Yükleme

Kullanıcı masaüstü ayarlarını yedeklemek veya başka bir makineye aktarmak için şu adımları izleyebilirsiniz:

### 🔹 DConf Ayarlarını Dışa Aktarma (Backup)
```bash
dconf dump / > ~/parslinux-gnome-backup.dconf
```

### 🔹 Geri Yükleme (Restore)
```bash
dconf load / < ~/parslinux-gnome-backup.dconf
```

### 🔹 Varsayılan Pars Linux Ayarlarına Sıfırlama
Kullanıcının yaptığı tüm özelleştirmeleri sıfırlayıp Pars Linux dağıtım ayarlarına dönmek için:
```bash
dconf reset -f /org/gnome/
```

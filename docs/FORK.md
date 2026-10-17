# 🐆 ParsLinux GNOME Settings — Çatallama Beyannamesi (FORK.md)

Bu belge; **ParsLinux GNOME Settings** (`parslinux-gnome-settings`) projesinin kökenini, çatallanma (fork) gerekçelerini, gerçekleştirilen mimari dönüşümleri ve açık kaynak lisans uyum beyanını detaylandırmaktadır.

---

## 📌 1. Projenin Kökeni (Upstream Origin)

**ParsLinux GNOME Settings**, açık kaynaklı GNU/Linux ekosistemindeki Pardus GNOME Settings projesinden türetilmiş ve bağımsız Pars Linux masaüstü ortamına uyarlanmıştır.

* **Orijinal Proje:** `pardus-gnome-settings`
* **Orijinal Lisans:** GNU General Public License v3.0 (GPL-3.0)
* **Mevcut Lisans:** GNU General Public License v3.0 (GPL-3.0-or-later)
* **Geliştirici & Bakım:** Pars Linux Geliştirici Topluluğu ([dev@parslinux.org](mailto:dev@parslinux.org))
* **Kaynak Kod Deposu:** [https://github.com/parslinux/parslinux-gnome-settings](https://github.com/parslinux/parslinux-gnome-settings)

GPL-3.0 lisansının getirdiği özgür yazılım etiği ve yasal haklar çerçevesinde; orijinal projenin geliştiricilerine teşekkür eder, kaynak kodun özgürce değiştirilme ve geliştirilme hakkını sürdürürüz.

---

## 🎯 2. Neden Fork Edildi? (Motivasyon ve Amaçlar)

1. **Bağımsız Ekosistem Entegrasyonu:** Pars Linux Yazılım Merkezi (`org.parslinux.software.desktop`), Pars Linux ikon ve duvar kağıdı temaları ile kusursuz bir varsayılan masaüstü deneyimi inşa etmek.
2. **Dash-to-Panel ve Görsel Kimlik:** Pars Linux vektörel logosunun ana menü başlatıcısı olarak konumlandırılması ve modern panel şeffaflık kurallarının belirlenmesi.
3. **Geliştirici ve Yönetim Araçları:** Orijinal repoda bulunmayan hızlı test (`run.sh`), sistem kurulumu (`install.sh`), kaldırma (`uninstall.sh`) ve Debian paketleme (`package.sh`) betiklerinin eklenmesi.
4. **Kapsamlı Dokümantasyon:** Kurumsal geliştirici standartlarına uygun mimari, kılavuz ve güvenlik dokümantasyonunun kazandırılması.

---

## 🔄 3. Gerçekleştirilen Başlıca Değişiklikler

| Alan | Orijinal (Pardus) | Pars Linux |
|---|---|---|
| **Paket Adı** | `pardus-gnome-settings` | `parslinux-gnome-settings` |
| **Yazılım Merkezi** | `tr.org.pardus.software.desktop` | `org.parslinux.software.desktop` |
| **İkon Teması** | `pardus-gnome` | `parslinux-gnome` |
| **DConf Profili** | `dconf/20-pardus` | `dconf/20-parslinux` |
| **Başlatıcı Simgesi** | `start-pardus-gnome-25.svg` | `start-parslinux-gnome.svg` (Pars Linux Logo) |
| **Şablon Betiği** | `xdg-pardus-templates-gnome` | `xdg-parslinux-templates-gnome` |
| **Yardımcı Betikler** | Yok | `install.sh`, `uninstall.sh`, `run.sh`, `package.sh` |

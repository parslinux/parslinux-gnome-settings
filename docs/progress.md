# 📊 Geliştirme İlerleme Raporu (progress.md)

Bu belge, `parslinux-gnome-settings` paketinin gelişim sürecini, tamamlanan aşamaları ve gelecek hedeflerini özetler.

---

## 🎯 Tamamlanan Aşamalar (Phase 1: Fork & Adaptation)

- [x] `pardus-gnome-settings` kaynak deposunun klonlanması ve yapısının incelenmesi.
- [x] Tüm dizin ve dosya isimlerinin `parslinux` standartlarına taşınması.
- [x] GSettings overrides dosyasının (`parslinux-gnome-settings.gsettings-override`) düzenlenmesi:
  - [x] `org.parslinux.software.desktop` varsayılan favorilere eklendi.
  - [x] İkon ve yazı tipi tanımları uyarlandı.
  - [x] Duvar kağıdı yolları Pars Linux standartlarına bağlandı.
- [x] DConf profil ve anahtarlarının (`dconf/20-parslinux`, `dconf/user`) hazırlanması:
  - [x] Pars Linux vektörel başlatıcı logosu entegre edildi.
  - [x] Panel şeffaflığı ve gruplama ayarları optimize edildi.
- [x] Şablon betiği (`xdg-parslinux-templates-gnome`) ve gettext çevirilerinin oluşturulması.
- [x] Yönetim araçlarının yazılması ve test edilmesi:
  - [x] `install.sh` (Sistem kurulumu)
  - [x] `uninstall.sh` (Kaldırma)
  - [x] `run.sh` (Test ve oturum uygulama)
  - [x] `package.sh` (Debian .deb üretimi)
- [x] Dokümantasyon setinin (`docs/`, `README.md`) yazılması.
- [x] `.claudeignore` ve GitHub Actions CI iş akışının eklenmesi.
- [x] `git@github.com:parslinux/parslinux-gnome-settings.git` ana dalına ilk sürümün gönderilmesi.

---

## 🔮 Gelecek Planlar (Phase 2 & Roadmap)

- [ ] `parslinux-wallpapers` ve `parslinux-icon-theme` paketleriyle tam entegrasyon testi.
- [ ] Wayland ve X11 oturumlarında panel davranışlarının karşılaştırmalı performans testi.
- [ ] Yeni kullanıcılar için ilk karşılama (greeter) entegrasyonunun genişletilmesi.
- [ ] Launchpad PPA veya Pars Linux resmi APT deposuna otomatik dağıtım pipeline'ı.

# 📝 Değişiklik Günlüğü (CHANGELOG.md)

Bu belgede `parslinux-gnome-settings` paketinin tüm sürümlerine ait değişiklikler ve sürüm notları tutulmaktadır.

---

## [1.0.0] — 2026-10-17

### 🎉 İlk Sürüm (Initial Release)
- **Çatallama (Fork):** `pardus-gnome-settings` temel alınarak bağımsız Pars Linux ortamına uyarlandı.
- **GSettings Tanımları:**
  - `org.parslinux.software.desktop` varsayılan favori uygulamalar arasına eklendi.
  - `parslinux-gnome` simge teması ve Ubuntu font seti varsayılan yapıldı.
  - Açık ve koyu Pars Linux duvar kağıdı yolları tanımlandı.
  - `[org.parslinux.parslinux-gnome-greeter]` yapılandırması uyarlandı.
- **DConf & Panel:**
  - `dconf/20-parslinux` ve `dconf/user` profilleri oluşturuldu.
  - Dash-to-Panel başlatıcı simgesi `/usr/share/parslinux/gnome-settings/start-parslinux-gnome.svg` olarak entegre edildi.
- **Şablonlar (Templates):**
  - `xdg-parslinux-templates-gnome` betiği, autostart girişi ve gettext çevirileri hazırlandı.
  - Türkçe ve uluslararası LibreOffice / Metin şablon desteği eklendi.
- **Yönetim Betikleri:**
  - `install.sh`, `uninstall.sh`, `run.sh` ve `package.sh` araçları eklendi.
- **Dokümantasyon:**
  - Mimari, kurulum, ayar kılavuzu, şartlar ve güvenlik belgelerini içeren `docs/` külliyatı oluşturuldu.

# 🌍 Yerelleştirme ve Çeviri Kılavuzu (TRANSLATION_GUIDE.md)

Bu belge, `parslinux-gnome-settings` içindeki şablon adlarının farklı dillere nasıl çevrileceğini ve gettext dosyalarının nasıl güncelleneceğini açıklar.

---

## 📂 Çeviri Dizin Yapısı

```
usr/share/parslinux/gnome-settings/xdg-parslinux-templates-gnome/
├── po/
│   ├── Makefile                            # Çeviri derleme betiği
│   ├── files                               # Taranacak Python kaynakları
│   ├── tr.po                               # Türkçe çeviriler
│   └── xdg-parslinux-templates-gnome.pot   # Şablon ana gettext dosyası
└── update-translations.sh                  # Çevirileri güncelleme betiği
```

---

## 🛠️ Yeni Dil Ekleme Adımları

1. Çeviriler dizinine geçin:
   ```bash
   cd usr/share/parslinux/gnome-settings/xdg-parslinux-templates-gnome
   ```
2. POT dosyasından yeni dil için PO dosyası oluşturun (örneğin Almanca için `de.po`, Azerbaycan Türkçesi için `az.po`):
   ```bash
   msginit -i po/xdg-parslinux-templates-gnome.pot -o po/az.po -l az
   ```
3. `po/az.po` dosyasını bir metin düzenleyici veya **Poedit** ile açıp çevirileri girin:
   ```po
   #: xdg-parslinux-templates-gnome:29
   msgid "Presentation"
   msgstr "Təqdimat"
   ```
4. `update-translations.sh` betiğindeki `langs` dizisine yeni dil kodunu ekleyin.
5. Değişiklikleri kaydedip Pull Request açın.

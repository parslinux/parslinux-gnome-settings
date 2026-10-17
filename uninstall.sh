#!/usr/bin/env bash
# ==============================================================================
# ParsLinux GNOME Settings — Sistemden Kaldırma Betiği (uninstall.sh)
# ==============================================================================
# Bu betik ParsLinux GNOME masaüstü ayarlarını, dconf yapılandırmalarını ve
# şablon dosyalarını sistemden temizler, veritabanlarını günceller.
# ==============================================================================

set -e

# Renk tanımları
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${YELLOW}${BOLD}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║      🗑️  ParsLinux GNOME Settings — Kaldırma Sihirbazı        ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Root yetkisi kontrolü
if [ "$EUID" -ne 0 ]; then
    echo -e "${YELLOW}ℹ️  Kaldırma işlemi için root ayrıcalığı gerekiyor. Sudo isteniyor...${NC}"
    exec sudo bash "$0" "$@"
fi

echo -e "${BOLD}[1/4] Uygulama dosyaları ve dizinler siliniyor...${NC}"
rm -rf /usr/share/parslinux/gnome-settings
# Eğer /usr/share/parslinux boşaldıysa kaldır
rmdir /usr/share/parslinux 2>/dev/null || true

echo -e "${BOLD}[2/4] Autostart ve şablon kayıtları siliniyor...${NC}"
rm -f /etc/xdg/autostart/xdg-parslinux-templates-gnome.desktop
rm -f /usr/share/locale/*/LC_MESSAGES/xdg-parslinux-templates-gnome.mo

echo -e "${BOLD}[3/4] dconf profili ve kural dosyaları siliniyor...${NC}"
rm -f /etc/dconf/db/local.d/20-parslinux
rm -f /etc/dconf/profile/user
rm -f /etc/dconf/db/local

if command -v dconf &>/dev/null; then
    dconf update || true
    echo -e "${GREEN}✓ dconf veritabanı yenilendi.${NC}"
fi

echo -e "${BOLD}[4/4] GSettings override siliniyor ve şemalar derleniyor...${NC}"
rm -f /usr/share/glib-2.0/schemas/20_parslinux-gnome-settings.gschema.override

if command -v glib-compile-schemas &>/dev/null; then
    glib-compile-schemas /usr/share/glib-2.0/schemas/ || true
    echo -e "${GREEN}✓ GLib şemaları güncellendi.${NC}"
fi

echo -e "\n${GREEN}${BOLD}══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}${BOLD}✓ ParsLinux GNOME Settings sistemden başarıyla kaldırıldı.${NC}"
echo -e "${GREEN}${BOLD}══════════════════════════════════════════════════════════════${NC}\n"

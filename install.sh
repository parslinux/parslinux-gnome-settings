#!/usr/bin/env bash
# ==============================================================================
# ParsLinux GNOME Settings — Sistem Kurulum Betiği (install.sh)
# ==============================================================================
# Bu betik ParsLinux GNOME masaüstü yapılandırmalarını (dconf, gsettings,
# şablonlar, autostart ve varlıklar) sisteme kurar ve veritabanlarını yeniler.
# ==============================================================================

set -e

# Renk tanımları
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${CYAN}${BOLD}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║      🐆 ParsLinux GNOME Settings — Kurulum Sihirbazı         ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Root yetkisi kontrolü
if [ "$EUID" -ne 0 ]; then
    echo -e "${YELLOW}ℹ️  Sistem genelinde kurulum için root ayrıcalığı gerekiyor. Sudo isteniyor...${NC}"
    exec sudo bash "$0" "$@"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo -e "${BOLD}[1/4] Makefile ile dosyalar sisteme yükleniyor...${NC}"
make install DESTDIR=

echo -e "\n${BOLD}[2/4] GSettings override dosyası kopyalanıyor...${NC}"
mkdir -p /usr/share/glib-2.0/schemas/
cp -f debian/parslinux-gnome-settings.gsettings-override /usr/share/glib-2.0/schemas/20_parslinux-gnome-settings.gschema.override

echo -e "\n${BOLD}[3/4] GLib şemaları ve dconf veritabanı derleniyor...${NC}"
if command -v glib-compile-schemas &>/dev/null; then
    glib-compile-schemas /usr/share/glib-2.0/schemas/
    echo -e "${GREEN}✓ GLib şemaları derlendi.${NC}"
fi

if command -v dconf &>/dev/null; then
    rm -f /etc/dconf/db/local
    dconf update
    echo -e "${GREEN}✓ dconf veritabanı güncellendi.${NC}"
fi

echo -e "\n${BOLD}[4/4] İzinler ayarlanıyor...${NC}"
chmod +x /usr/share/parslinux/gnome-settings/xdg-parslinux-templates-gnome/xdg-parslinux-templates-gnome 2>/dev/null || true

echo -e "\n${GREEN}${BOLD}══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}${BOLD}🎉 ParsLinux GNOME Settings başarıyla kuruldu!${NC}"
echo -e "${GREEN}${BOLD}══════════════════════════════════════════════════════════════${NC}"
echo -e "Değişikliklerin geçerli olması için oturumu kapatıp yeniden açabilir veya:"
echo -e "  • ${CYAN}systemctl restart gdm${NC} (veya oturum açma yöneticisi)"
echo -e "  • Şablonları tetiklemek için: ${CYAN}/usr/share/parslinux/gnome-settings/xdg-parslinux-templates-gnome/xdg-parslinux-templates-gnome${NC}\n"

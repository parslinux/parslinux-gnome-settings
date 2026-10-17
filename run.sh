#!/usr/bin/env bash
# ==============================================================================
# ParsLinux GNOME Settings — Çalıştırma ve Test Betiği (run.sh)
# ==============================================================================
# Bu betik gsettings ve dconf tanımlarını test etmek, şablon aracını
# çalıştırmak veya mevcut kullanıcı oturumuna ayarları uygulamak için kullanılır.
# ==============================================================================

set -e

# Renk tanımları
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${CYAN}${BOLD}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║      🐆 ParsLinux GNOME Settings — Yönetim ve Test Aracı     ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

function show_menu() {
    echo -e "${BOLD}Lütfen bir işlem seçin:${NC}"
    echo -e "  ${CYAN}1)${NC} GNOME Şablon Oluşturucusunu Çalıştır (xdg-parslinux-templates)"
    echo -e "  ${CYAN}2)${NC} GSettings Ayarlarını Mevcut Kullanıcıya Uygula"
    echo -e "  ${CYAN}3)${NC} dconf / Dash-to-Panel Ayarlarını Kullanıcıya Uygula"
    echo -e "  ${CYAN}4)${NC} Mevcut Ayarları Kontrol Et (Dry Run)"
    echo -e "  ${CYAN}5)${NC} Çıkış"
    echo ""
}

function run_templates() {
    echo -e "\n${BOLD}📁 Şablon oluşturucu çalıştırılıyor...${NC}"
    python3 "$SCRIPT_DIR/usr/share/parslinux/gnome-settings/xdg-parslinux-templates-gnome/xdg-parslinux-templates-gnome"
    echo -e "${GREEN}✓ Şablonlar kontrol edildi ve uygulandı.${NC}\n"
}

function apply_gsettings() {
    echo -e "\n${BOLD}⚙️  GSettings ayarları mevcut oturuma uygulanıyor...${NC}"
    
    gsettings set org.gnome.shell favorite-apps "['firefox-esr.desktop', 'org.gnome.Nautilus.desktop', 'org.parslinux.software.desktop']" 2>/dev/null || true
    gsettings set org.gnome.desktop.interface font-name 'Ubuntu 11' 2>/dev/null || true
    gsettings set org.gnome.desktop.interface monospace-font-name 'Ubuntu Mono 13' 2>/dev/null || true
    gsettings set org.gnome.desktop.interface document-font-name 'Ubuntu 11' 2>/dev/null || true
    gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3' 2>/dev/null || true
    gsettings set org.gnome.desktop.interface enable-hot-corners false 2>/dev/null || true
    gsettings set org.gnome.desktop.interface icon-theme 'parslinux-gnome' 2>/dev/null || true
    gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close' 2>/dev/null || true
    gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true 2>/dev/null || true
    gsettings set org.gtk.Settings.FileChooser sort-directories-first true 2>/dev/null || true
    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true 2>/dev/null || true

    echo -e "${GREEN}✓ GSettings anahtarları kullanıcı oturumuna yazıldı.${NC}\n"
}

function apply_dconf() {
    echo -e "\n${BOLD}🎛️  Dash-to-panel ve dconf ayarları uygulanıyor...${NC}"
    if command -v dconf &>/dev/null; then
        dconf write /org/gnome/shell/extensions/dash-to-panel/dot-color-dominant true 2>/dev/null || true
        dconf write /org/gnome/shell/extensions/dash-to-panel/dot-style-unfocused "'DASHES'" 2>/dev/null || true
        dconf write /org/gnome/shell/extensions/dash-to-panel/group-apps true 2>/dev/null || true
        dconf write /org/gnome/shell/extensions/dash-to-panel/trans-use-custom-opacity true 2>/dev/null || true
        dconf write /org/gnome/shell/extensions/dash-to-panel/trans-use-dynamic-opacity true 2>/dev/null || true
        dconf write /org/gnome/shell/extensions/dash-to-panel/trans-panel-opacity 0.3 2>/dev/null || true
        dconf write /org/gnome/shell/extensions/dash-to-panel/show-apps-icon-file "'$SCRIPT_DIR/usr/share/parslinux/gnome-settings/start-parslinux-gnome.svg'" 2>/dev/null || true
        echo -e "${GREEN}✓ dconf ayarları kullanıcı profiline yazıldı.${NC}\n"
    else
        echo -e "${YELLOW}dconf komutu bulunamadı.${NC}\n"
    fi
}

function check_settings() {
    echo -e "\n${BOLD}🔍 Mevcut GNOME Shell ve Arayüz Ayarları:${NC}"
    echo -n "  • Favori Uygulamalar : "
    gsettings get org.gnome.shell favorite-apps 2>/dev/null || echo "Okunamadı"
    echo -n "  • İkon Teması        : "
    gsettings get org.gnome.desktop.interface icon-theme 2>/dev/null || echo "Okunamadı"
    echo -n "  • GTK Teması         : "
    gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null || echo "Okunamadı"
    echo -n "  • Buton Yerleşimi    : "
    gsettings get org.gnome.desktop.wm.preferences button-layout 2>/dev/null || echo "Okunamadı"
    echo ""
}

# Parametreli kullanım desteği
case "$1" in
    --templates)
        run_templates
        exit 0
        ;;
    --apply-user)
        apply_gsettings
        apply_dconf
        exit 0
        ;;
    --check)
        check_settings
        exit 0
        ;;
    "")
        show_menu
        read -p "Seçiminiz [1-5]: " choice
        case "$choice" in
            1) run_templates ;;
            2) apply_gsettings ;;
            3) apply_dconf ;;
            4) check_settings ;;
            5) exit 0 ;;
            *) echo -e "${YELLOW}Geçersiz seçim.${NC}" ;;
        esac
        ;;
    *)
        echo "Kullanım: $0 [--templates | --apply-user | --check]"
        exit 1
        ;;
esac

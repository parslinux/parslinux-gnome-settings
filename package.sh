#!/usr/bin/env bash
# ==============================================================================
# ParsLinux GNOME Settings — Debian Paketleme Betiği (package.sh)
# ==============================================================================
# Bu betik parslinux-gnome-settings için Debian ikili (.deb) paketi oluşturur.
# dpkg-buildpackage varsa tam Debian standardında derler, aksi halde
# doğrudan yerel .deb paketi inşa eder.
# ==============================================================================

set -e

# Renk tanımları
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo -e "${CYAN}${BOLD}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║      📦 ParsLinux GNOME Settings — Paketleme Aracı           ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

PKG_NAME="parslinux-gnome-settings"
VERSION=$(head -n 1 debian/changelog | awk -F '[()]' '{print $2}')
ARCH="all"
OUTPUT_DIR="$SCRIPT_DIR/build"

mkdir -p "$OUTPUT_DIR"

echo -e "${BOLD}Paket Adı    :${NC} ${CYAN}$PKG_NAME${NC}"
echo -e "${BOLD}Sürüm        :${NC} ${CYAN}$VERSION${NC}"
echo -e "${BOLD}Mimari       :${NC} ${CYAN}$ARCH${NC}\n"

if command -v dpkg-buildpackage &>/dev/null; then
    echo -e "${BOLD}[1/2] dpkg-buildpackage ile paket inşa ediliyor...${NC}"
    dpkg-buildpackage -us -uc -b
    mv ../${PKG_NAME}_* "$OUTPUT_DIR/" 2>/dev/null || true
    echo -e "\n${GREEN}✓ Paket başarıyla oluşturuldu: $OUTPUT_DIR/${NC}"
    ls -lh "$OUTPUT_DIR/"*.deb 2>/dev/null || true
    exit 0
fi

# dpkg-buildpackage yoksa yerel paket inşa yöntemi (Cross-distro / Standalone)
echo -e "${YELLOW}ℹ️  dpkg-buildpackage bulunamadı, yerel ikili .deb paketleme adımları çalıştırılıyor...${NC}"

BUILD_ROOT="$OUTPUT_DIR/${PKG_NAME}_${VERSION}_${ARCH}"
rm -rf "$BUILD_ROOT"
mkdir -p "$BUILD_ROOT/DEBIAN"

echo -e "${BOLD}[1/4] Makefile ile dosyalar paket köküne yükleniyor...${NC}"
make install DESTDIR="$BUILD_ROOT" >/dev/null

echo -e "${BOLD}[2/4] GSettings override ve Debian dosyaları yerleştiriliyor...${NC}"
mkdir -p "$BUILD_ROOT/usr/share/glib-2.0/schemas/"
cp -f debian/parslinux-gnome-settings.gsettings-override "$BUILD_ROOT/usr/share/glib-2.0/schemas/20_parslinux-gnome-settings.gschema.override"

# DEBIAN kontrol dosyası oluşturuluyor
cat <<EOF > "$BUILD_ROOT/DEBIAN/control"
Package: $PKG_NAME
Version: $VERSION
Architecture: $ARCH
Maintainer: Pars Linux Developers <dev@parslinux.org>
Section: gnome
Priority: optional
Homepage: https://github.com/parslinux/parslinux-gnome-settings
Depends: fonts-ubuntu, adw-gtk3-theme, parslinux-gnome-icon-theme | pardus-gnome-icon-theme
Description: default settings for the Pars Linux GNOME desktop
 This package contains the default settings used by Pars Linux.
EOF

# postinst betiği
cp -f debian/postinst "$BUILD_ROOT/DEBIAN/postinst"
chmod 755 "$BUILD_ROOT/DEBIAN/postinst"

# prerm betiği
cat <<'EOF' > "$BUILD_ROOT/DEBIAN/prerm"
#!/bin/sh
set -e
if [ "$1" = "remove" ]; then
    rm -f /etc/dconf/db/local
    dconf update 2>/dev/null || true
fi
EOF
chmod 755 "$BUILD_ROOT/DEBIAN/prerm"

echo -e "${BOLD}[3/4] İzinler düzenleniyor...${NC}"
find "$BUILD_ROOT" -type d -exec chmod 755 {} +
find "$BUILD_ROOT" -type f -exec chmod 644 {} +
chmod 755 "$BUILD_ROOT/DEBIAN/postinst"
chmod 755 "$BUILD_ROOT/DEBIAN/prerm"
chmod 755 "$BUILD_ROOT/usr/share/parslinux/gnome-settings/xdg-parslinux-templates-gnome/xdg-parslinux-templates-gnome"

echo -e "${BOLD}[4/4] .deb arşivi paketleniyor...${NC}"
DEB_FILE="$OUTPUT_DIR/${PKG_NAME}_${VERSION}_${ARCH}.deb"

if command -v dpkg-deb &>/dev/null; then
    dpkg-deb --build --root-owner-group "$BUILD_ROOT" "$DEB_FILE" >/dev/null
else
    # dpkg-deb yoksa ar/tar ile deb standardı oluştur
    pushd "$BUILD_ROOT" >/dev/null
    tar --numeric-owner --group=0 --owner=0 -czf "$OUTPUT_DIR/control.tar.gz" -C DEBIAN .
    tar --numeric-owner --group=0 --owner=0 -czf "$OUTPUT_DIR/data.tar.gz" --exclude='./DEBIAN' .
    popd >/dev/null
    echo "2.0" > "$OUTPUT_DIR/debian-binary"
    ar rcs "$DEB_FILE" "$OUTPUT_DIR/debian-binary" "$OUTPUT_DIR/control.tar.gz" "$OUTPUT_DIR/data.tar.gz"
    rm -f "$OUTPUT_DIR/debian-binary" "$OUTPUT_DIR/control.tar.gz" "$OUTPUT_DIR/data.tar.gz"
fi

rm -rf "$BUILD_ROOT"

echo -e "\n${GREEN}${BOLD}══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}${BOLD}🎉 Debian paketi başarıyla üretildi!${NC}"
echo -e "${GREEN}${BOLD}══════════════════════════════════════════════════════════════${NC}"
echo -e "Paket Konumu: ${CYAN}$DEB_FILE${NC}"
ls -lh "$DEB_FILE"
echo -e "\nKurulum için (Debian/Pars Linux):"
echo -e "  ${CYAN}sudo dpkg -i $DEB_FILE${NC}"
echo -e "  ${CYAN}sudo apt-get install -f${NC}\n"

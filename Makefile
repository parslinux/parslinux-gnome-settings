#!/usr/bin/make -f

SUBDIRS := usr/share/parslinux/gnome-settings/xdg-parslinux-templates-gnome/po/

all:
	@echo "Nothing to build, call 'make install' instead."

install:
	mkdir -pv $(DESTDIR)
	cp -a etc usr $(DESTDIR)/.
	mkdir -pv $(DESTDIR)/usr/share/locale
	# po generation
	for i in $(SUBDIRS); do \
		make -C $(DESTDIR)/$$i; \
		rm -rf $(DESTDIR)/$$i; \
	done
	mkdir -pv $(DESTDIR)/etc/dconf/profile
	mkdir -pv $(DESTDIR)/etc/dconf/db/local.d
	cp -fr dconf/user $(DESTDIR)/etc/dconf/profile/user
	cp -fr dconf/20-parslinux $(DESTDIR)/etc/dconf/db/local.d/20-parslinux
	# remove some remaining files
	find $(DESTDIR) -type f -iname "*.in" | xargs rm -f

# vim:ts=4

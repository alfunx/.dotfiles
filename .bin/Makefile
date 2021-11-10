DESTDIR ?=
PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
CONFDIR ?= /etc
HOMEDIR ?= /home/amariya

help:
	@echo 'default:         help'
	@echo 'install-root:    Install root scripts'
	@echo 'uninstall-root:  Uninstall root scripts'
	@echo 'install-user:    Install user scripts'
	@echo 'uninstall-user:  Uninstall user scripts'
	@echo 'install-dirs:    Install XDG dirs'

default: help

install-root:
	install -Dm755 lock                 '$(DESTDIR)$(BINDIR)'/lock
	install -Dm755 vimmerge             '$(DESTDIR)$(BINDIR)'/vimmerge
	install -Dm755 update-pkglist       '$(DESTDIR)$(BINDIR)'/update-pkglist
	install -Dm755 update-pacman-widget '$(DESTDIR)$(BINDIR)'/update-pacman-widget
	
	ln -sf /etc/pacman.conf             '$(DESTDIR)'/usr/share/devtools/pacman-aur.conf
	ln -sf /usr/bin/archbuild           '$(DESTDIR)$(BINDIR)'/aur-x86_64-build
	
	install -Dm755 '$(HOMEDIR)'/.config/pacman/hooks/awesome-pacman-widget.hook '$(DESTDIR)$(CONFDIR)'/pacman.d/hooks/awesome-pacman-widget.hook

uninstall-root:
	rm -f '$(DESTDIR)$(BINDIR)'/lock
	rm -f '$(DESTDIR)$(BINDIR)'/vimmerge
	rm -f '$(DESTDIR)$(BINDIR)'/update-pkglist
	rm -f '$(DESTDIR)$(BINDIR)'/update-pacman-widget
	
	rm -f '$(DESTDIR)'/usr/share/devtools/pacman-aur.conf
	rm -f '$(DESTDIR)$(BINDIR)'/aur-x86_64-build
	
	rm -f '$(DESTDIR)$(CONFDIR)'/pacman.d/hooks/awesome-pacman-widget.hook

install-user:
	cp -fs '$(HOMEDIR)'/.config/awesome/themes/blackout/wallpapers/wall.png  '$(HOMEDIR)'/pictures/wall.png
	cp -fs '$(HOMEDIR)'/.config/awesome/themes/blackout/wallpapers/lock.png  '$(HOMEDIR)'/pictures/lock.png
	cp -fs '$(HOMEDIR)'/.config/awesome/themes/blackout/wallpapers/slice.png '$(HOMEDIR)'/pictures/slice.png
	cp -fs '$(HOMEDIR)'/projects/gdb-dashboard/.gdbinit                      '$(HOMEDIR)'/.gdbinit

uninstall-user:
	rm -f '$(HOMEDIR)'/pictures/wall.png
	rm -f '$(HOMEDIR)'/pictures/lock.png
	rm -f '$(HOMEDIR)'/pictures/slice.png
	rm -f '$(HOMEDIR)'/.gdbinit

install-dirs:
	install -d '$(XDG_DESKTOP_DIR)'
	install -d '$(XDG_DOCUMENTS_DIR)'
	install -d '$(XDG_DOWNLOAD_DIR)'
	install -d '$(XDG_MUSIC_DIR)'
	install -d '$(XDG_PICTURES_DIR)'
	install -d '$(XDG_PUBLICSHARE_DIR)'
	install -d '$(XDG_TEMPLATES_DIR)'
	install -d '$(XDG_VIDEOS_DIR)'

DESTDIR ?=
PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

default: install

help:
	@echo 'default:         install'
	@echo 'install:         install-root'
	@echo 'uninstall:       uninstall-root'
	@echo 'install-root:    Install root scripts'
	@echo 'uninstall-root:  Uninstall root scripts'
	@echo 'install-user:    Install user scripts'
	@echo 'uninstall-user:  Uninstall user scripts'
	@echo 'install-dirs:    Install XDG dirs'

install: install-root
uninstall: uninstall-root

install-root:
	install -Dm755 lock '$(DESTDIR)$(BINDIR)'/lock
	install -Dm755 edit-in-vim '$(DESTDIR)$(BINDIR)'/edit-in-vim
	install -Dm755 update-pkglist '$(DESTDIR)$(BINDIR)'/update-pkglist
	install -Dm755 aur-checkupdates '$(DESTDIR)$(BINDIR)'/aur-checkupdates
	install -Dm755 aur-clean '$(DESTDIR)$(BINDIR)'/aur-clean
	install -Dm755 aur-manual '$(DESTDIR)$(BINDIR)'/aur-manual
	install -Dm755 aur-remove '$(DESTDIR)$(BINDIR)'/aur-remove
	install -Dm755 aur-tmpfs '$(DESTDIR)$(BINDIR)'/aur-tmpfs
	install -Dm755 aur-update '$(DESTDIR)$(BINDIR)'/aur-update
	install -Dm755 update-pacman-widget '$(DESTDIR)$(BINDIR)'/update-pacman-widget

uninstall-root:
	rm -f '$(DESTDIR)$(BINDIR)'/lock
	rm -f '$(DESTDIR)$(BINDIR)'/edit-in-vim
	rm -f '$(DESTDIR)$(BINDIR)'/update-pkglist
	rm -f '$(DESTDIR)$(BINDIR)'/aur-checkupdates
	rm -f '$(DESTDIR)$(BINDIR)'/aur-clean
	rm -f '$(DESTDIR)$(BINDIR)'/aur-manual
	rm -f '$(DESTDIR)$(BINDIR)'/aur-remove
	rm -f '$(DESTDIR)$(BINDIR)'/aur-tmpfs
	rm -f '$(DESTDIR)$(BINDIR)'/aur-update
	rm -f '$(DESTDIR)$(BINDIR)'/update-pacman-widget

install-user:
	cp -fs '$(HOME)'/.config/awesome/themes/blackout/wallpapers/wall.png '$(HOME)'/pictures/wall.png
	cp -fs '$(HOME)'/.config/awesome/themes/blackout/wallpapers/lock.png '$(HOME)'/pictures/lock.png
	cp -fs '$(HOME)'/projects/gdb-dashboard/.gdbinit '$(HOME)'/.gdbinit
	cp -fs '$(HOME)'/projects/aurutils/contrib/vercmp-devel '$(HOME)'/.bin/aur-vercmp-devel

uninstall-user:
	rm -f '$(HOME)'/pictures/wall.png
	rm -f '$(HOME)'/pictures/lock.png
	rm -f '$(HOME)'/.gdbinit
	rm -f '$(HOME)'/.bin/aur-vercmp-devel

install-dirs:
	install -d '$(XDG_DESKTOP_DIR)'
	install -d '$(XDG_DOCUMENTS_DIR)'
	install -d '$(XDG_DOWNLOAD_DIR)'
	install -d '$(XDG_MUSIC_DIR)'
	install -d '$(XDG_PICTURES_DIR)'
	install -d '$(XDG_PUBLICSHARE_DIR)'
	install -d '$(XDG_TEMPLATES_DIR)'
	install -d '$(XDG_VIDEOS_DIR)'

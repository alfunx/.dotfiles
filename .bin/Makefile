DESTDIR ?=
PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
CONFDIR ?= /etc
HOMEDIR ?= $(HOME)

help:
	@echo 'default:         help'
	@echo 'install-root:    Install root scripts'
	@echo 'uninstall-root:  Uninstall root scripts'
	@echo 'install-user:    Install user scripts'
	@echo 'uninstall-user:  Uninstall user scripts'
	@echo 'install-dirs:    Install XDG dirs'

default: help

install-root:
	sudo install -Dm755 lock                 '$(DESTDIR)$(BINDIR)'/lock
	sudo install -Dm755 edit-in-vim          '$(DESTDIR)$(BINDIR)'/edit-in-vim
	sudo install -Dm755 update-pkglist       '$(DESTDIR)$(BINDIR)'/update-pkglist
	sudo install -Dm755 vimmerge             '$(DESTDIR)$(BINDIR)'/vimmerge
	sudo install -Dm755 aur-checkupdates     '$(DESTDIR)$(BINDIR)'/aur-checkupdates
	sudo install -Dm755 aur-clean            '$(DESTDIR)$(BINDIR)'/aur-clean
	sudo install -Dm755 aur-manual           '$(DESTDIR)$(BINDIR)'/aur-manual
	sudo install -Dm755 aur-remove           '$(DESTDIR)$(BINDIR)'/aur-remove
	sudo install -Dm755 aur-tmpfs            '$(DESTDIR)$(BINDIR)'/aur-tmpfs
	sudo install -Dm755 aur-update           '$(DESTDIR)$(BINDIR)'/aur-update
	sudo install -Dm755 update-pacman-widget '$(DESTDIR)$(BINDIR)'/update-pacman-widget
	
	sudo install -Dm755 '$(HOMEDIR)'/.config/pacman/hooks/awesome-pacman-widget.hook '$(DESTDIR)$(CONFDIR)'/pacman.d/hooks/awesome-pacman-widget.hook

uninstall-root:
	rm -f '$(DESTDIR)$(BINDIR)'/lock
	rm -f '$(DESTDIR)$(BINDIR)'/edit-in-vim
	rm -f '$(DESTDIR)$(BINDIR)'/update-pkglist
	rm -f '$(DESTDIR)$(BINDIR)'/vimmerge
	rm -f '$(DESTDIR)$(BINDIR)'/aur-checkupdates
	rm -f '$(DESTDIR)$(BINDIR)'/aur-clean
	rm -f '$(DESTDIR)$(BINDIR)'/aur-manual
	rm -f '$(DESTDIR)$(BINDIR)'/aur-remove
	rm -f '$(DESTDIR)$(BINDIR)'/aur-tmpfs
	rm -f '$(DESTDIR)$(BINDIR)'/aur-update
	rm -f '$(DESTDIR)$(BINDIR)'/update-pacman-widget
	
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

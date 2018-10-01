DESTDIR ?=
PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

default: install

help:
	@echo 'default:        install'
	@echo 'install:        install-root'
	@echo 'uninstall:      uninstall-root'
	@echo 'install-root:   Install root scripts'
	@echo 'uninstall-root: Uninstall root scripts'
	@echo 'install-user:   Install user scripts'
	@echo 'uninstall-user: Uninstall user scripts'

install: install-root
uninstall: uninstall-root

install-root:
	install -Dm755 lock $(DESTDIR)$(BINDIR)/lock
	install -Dm755 edit-in-vim $(DESTDIR)$(BINDIR)/edit-in-vim
	install -Dm755 update-pkglist $(DESTDIR)$(BINDIR)/update-pkglist
	install -Dm755 aur-checkupdates $(DESTDIR)$(BINDIR)/aur-checkupdates
	install -Dm755 aur-clean $(DESTDIR)$(BINDIR)/aur-clean
	install -Dm755 aur-rebuild $(DESTDIR)$(BINDIR)/aur-rebuild
	install -Dm755 aur-remove $(DESTDIR)$(BINDIR)/aur-remove
	install -Dm755 aur-tmpfs $(DESTDIR)$(BINDIR)/aur-tmpfs
	install -Dm755 aur-update $(DESTDIR)$(BINDIR)/aur-update
	sudo cp -fs /usr/share/aurutils/contrib/vercmp-devel $(DESTDIR)$(BINDIR)/aur-vercmp-devel
	# install -Dm755 pacman $(DESTDIR)$(BINDIR)/pacman
	# install -Dm755 pacman $(DESTDIR)$(BINDIR)/update-pacman-widget

uninstall-root:
	rm $(DESTDIR)$(BINDIR)/lock
	rm $(DESTDIR)$(BINDIR)/edit-in-vim
	rm $(DESTDIR)$(BINDIR)/update-pkglist
	rm $(DESTDIR)$(BINDIR)/aur-checkupdates
	rm $(DESTDIR)$(BINDIR)/aur-clean
	rm $(DESTDIR)$(BINDIR)/aur-rebuild
	rm $(DESTDIR)$(BINDIR)/aur-remove
	rm $(DESTDIR)$(BINDIR)/aur-tmpfs
	rm $(DESTDIR)$(BINDIR)/aur-update
	rm $(DESTDIR)$(BINDIR)/aur-vercmp-devel
	# rm $(DESTDIR)$(BINDIR)/pacman
	# rm $(DESTDIR)$(BINDIR)/update-pacman-widget

install-user:
	cp -fs $(HOME)/.config/awesome/themes/blackout/wallpapers/wall.png $(HOME)/pictures/wall.png
	cp -fs $(HOME)/.config/awesome/themes/blackout/wallpapers/lock.png $(HOME)/pictures/lock.png
	cp -fs $(HOME)/projects/gdb-dashboard/.gdbinit $(HOME)/.gdbinit
	cp -fs $(HOME)/projects/aurutils/contrib/vercmp-devel $(HOME)/.bin/aur-vercmp-devel

uninstall-user:
	rm $(HOME)/pictures/wall.png
	rm $(HOME)/pictures/lock.png
	rm $(HOME)/.gdbinit
	rm $(HOME)/.bin/aur-vercmp-devel

install-dirs:
	install -d $(XDG_DESKTOP_DIR)
	install -d $(XDG_DOCUMENTS_DIR)
	install -d $(XDG_DOWNLOAD_DIR)
	install -d $(XDG_MUSIC_DIR)
	install -d $(XDG_PICTURES_DIR)
	install -d $(XDG_PUBLICSHARE_DIR)
	install -d $(XDG_TEMPLATES_DIR)
	install -d $(XDG_VIDEOS_DIR)

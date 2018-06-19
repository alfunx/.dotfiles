DESTDIR ?=
PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

default: install

install: install-root

uninstall: uninstall-root

install-root:
	install -Dm755 lock $(DESTDIR)$(BINDIR)/lock
	install -Dm755 edit-in-vim $(DESTDIR)$(BINDIR)/edit-in-vim
	install -Dm755 update-pkglist $(DESTDIR)$(BINDIR)/update-pkglist
	install -Dm755 aur-checkupdates $(DESTDIR)$(BINDIR)/aur-checkupdates
	install -Dm755 aur-remove $(DESTDIR)$(BINDIR)/aur-remove
	install -Dm755 aur-tmpfs $(DESTDIR)$(BINDIR)/aur-tmpfs
	install -Dm755 aur-update $(DESTDIR)$(BINDIR)/aur-update
	sudo cp -fs /usr/share/aurutils/contrib/vercmp-devel $(DESTDIR)$(BINDIR)/aur-vercmp-devel

uninstall-root:
	rm -f $(DESTDIR)$(BINDIR)/lock
	rm -f $(DESTDIR)$(BINDIR)/edit-in-vim
	rm -f $(DESTDIR)$(BINDIR)/update-pkglist
	rm -f $(DESTDIR)$(BINDIR)/aur-checkupdates
	rm -f $(DESTDIR)$(BINDIR)/aur-remove
	rm -f $(DESTDIR)$(BINDIR)/aur-tmpfs
	rm -f $(DESTDIR)$(BINDIR)/aur-update
	rm -f $(DESTDIR)$(BINDIR)/aur-vercmp-devel

install-user:
	cp -fs $(HOME)/.config/awesome/themes/blackout/wallpapers/wall.png $(HOME)/pictures/wall.png
	cp -fs $(HOME)/.config/awesome/themes/blackout/wallpapers/lock.png $(HOME)/pictures/lock.png
	cp -fs $(HOME)/projects/gdb-dashboard/.gdbinit $(HOME)/.gdbinit
	cp -fs $(HOME)/projects/aurutils/contrib/vercmp-devel $(HOME)/.bin/aur-vercmp-devel

uninstall-user:
	rm -f $(HOME)/pictures/wall.png
	rm -f $(HOME)/pictures/lock.png
	rm -f $(HOME)/.gdbinit
	rm -f $(HOME)/.bin/aur-vercmp-devel

#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap


# merge in defaults and keymaps

if [ -f "$sysresources" ]; then
    xrdb -merge "$sysresources"
fi

if [ -f "$sysmodmap" ]; then
    xmodmap "$sysmodmap"
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# these get ingnored for whatever reason
# unclutter -root -reset &
redshift -c .config/redshift.conf &
# xcompmgr &
compton --config .config/compton/compton.conf &
syndaemon -i 0.5 -K -R -d

# select wm/de with: startx ~/.xinitrc session
session=${1:-awesome}

case "$session" in
    awesome)
        exec awesome ;;
    *)
        exec "$session"
esac

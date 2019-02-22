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

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xautolock -detectsleep \
    -time 9 -notify 20 \
    -notifier "notify-send -t 18000 -u critical 'Lock' 'Locking screen in 20 seconds.'" \
    -locker /usr/local/bin/lock &
dropbox &
amixer -c PCH set "Master" mute &
amixer -c PCH cset 'name=Headphone Mic Boost Volume' 1 &
# unclutter -root -reset &
redshift -c .config/redshift.conf &
# xcompmgr &
compton --config .config/compton/compton.conf &

# select wm/de with: startx ~/.xinitrc session
session=${1:-awesome}

case "$session" in
    awesome)
        exec awesome ;;
    awesome-git)
        exec "$HOME"/build/awesome/install.d/bin/awesome ;;
    termite|term)
        exec termite --geometry='1920x1080' ;;
    alacritty)
        exec alacritty --dimensions 213 56 ;;
    i3|i3wm)
        exec i3 ;;
    *)
        exec "$session"
esac

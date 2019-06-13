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

# select wm/de with: startx ~/.xinitrc session
session=${1:-awesome}

# AwesomeWM handles this in rc.lua
if [ "$session" != 'awesome' ]; then
    notifier_cmd="notify-send -t 18000 -u critical 'Lock' 'Locking screen in 20 seconds.'"
else
    notifier_cmd="awesome-client \"n=require('naughty');n.notify{title='Lock',text='Locking screen in 20 seconds.',timeout=18,preset=n.config.presets.critical}\""
fi

# xset s off &
xautolock -detectsleep \
    -time 9 -notify 20 \
    -corners 000- \
    -notifier "$notifier_cmd" \
    -locker /usr/local/bin/lock &

dropbox &
redshift -c .config/redshift.conf &
compton --config .config/compton/compton.conf &

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

#!/bin/bash

# dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / \
#     com.github.chjj.compton.opts_set string:no_fading_openclose boolean:false
# dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / \
#     com.github.chjj.compton.opts_set string:unredir_if_possible boolean:false

lock='/home/amariya/pictures/lock.png'

maim -u \
  | convert png:- -scale 10% -scale 1000% png:- \
  | convert png:- "$lock" -gravity center -composite -matte png:- \
  | i3lock -e -i /dev/stdin \
  --insidecolor=28282899 --ringcolor=EBDBB2FF --line-uses-inside \
  --keyhlcolor=FB4934FF --bshlcolor=FB4934FF --separatorcolor=282828FF \
  --insidevercolor=FABD2F99 --insidewrongcolor=FB493499 \
  --ringvercolor=EBDBB2FF --ringwrongcolor=EBDBB2FF --indpos='x+86:y+1003' \
  --radius=23 --veriftext='' --wrongtext=''

# sleep 0.5
# dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / \
#     com.github.chjj.compton.opts_set string:no_fading_openclose boolean:true
# dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / \
#     com.github.chjj.compton.opts_set string:unredir_if_possible boolean:true

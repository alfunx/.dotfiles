#!/bin/bash

# dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / \
#     com.github.chjj.compton.opts_set string:no_fading_openclose boolean:false
# dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / \
#     com.github.chjj.compton.opts_set string:unredir_if_possible boolean:false

image="/tmp/lock-screen.png"
resolution=$(xrandr | grep '*' | sed -E "s/[^0-9]*([0-9]+)x([0-9]+).*/\1*\2/")
lock="/home/amariya/pictures/lock.png"

# ffmpeg -f x11grab -video_size "$resolution" -y -i $DISPLAY -i "$lock" \
#   -filter_complex "boxblur=2:4,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" \
#   -vframes 1 "$image" -loglevel quiet

maim \
  | convert png:- -scale 10% -scale 1000% png:- \
  | convert png:- "$lock" -gravity center -composite -matte "$image"

i3lock -e -i "$image" \
  --insidecolor=282828FF --ringcolor=EBDBB2FF --line-uses-inside \
  --keyhlcolor=FB4934FF --bshlcolor=FB4934FF --separatorcolor=282828FF \
  --insidevercolor=FABD2FFF --insidewrongcolor=FB4934FF \
  --ringvercolor=EBDBB2FF --ringwrongcolor=EBDBB2FF --indpos="x+86:y+1003" \
  --radius=20 --veriftext="" --wrongtext=""

rm "$image"

# sleep 0.5
# dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / \
#     com.github.chjj.compton.opts_set string:no_fading_openclose boolean:true
# dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / \
#     com.github.chjj.compton.opts_set string:unredir_if_possible boolean:true

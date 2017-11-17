#!/bin/bash

dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / \
    com.github.chjj.compton.opts_set string:no_fading_openclose boolean:false
dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / \
    com.github.chjj.compton.opts_set string:unredir_if_possible boolean:false

IMAGE="/tmp/lock-screen.png"
RESOLUTION=$(xrandr | grep '*' | sed -E "s/[^0-9]*([0-9]+)x([0-9]+).*/\1*\2/")
LOCK="/home/amariya/pictures/lock.png"

ffmpeg -f x11grab -video_size $RESOLUTION -y -i $DISPLAY -i $LOCK \
  -filter_complex "boxblur=2:4,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" \
  -vframes 1 $IMAGE -loglevel quiet

i3lock -e -n -i $IMAGE \
  --insidecolor=282828FF --ringcolor=EBDBB2FF --line-uses-inside \
  --keyhlcolor=FB4934FF --bshlcolor=FB4934FF --separatorcolor=282828FF \
  --insidevercolor=FABD2FFF --insidewrongcolor=FB4934FF \
  --ringvercolor=EBDBB2FF --ringwrongcolor=EBDBB2FF --indpos="x+86:y+1003" \
  --radius=20 --veriftext="" --wrongtext=""

rm $IMAGE

sleep 0.5
dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / \
    com.github.chjj.compton.opts_set string:no_fading_openclose boolean:true
dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / \
    com.github.chjj.compton.opts_set string:unredir_if_possible boolean:true

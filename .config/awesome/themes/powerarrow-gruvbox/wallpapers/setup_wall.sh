#!/bin/bash

if (( $# < 1 )); then
  echo "Usage: setup_wall IMAGE [SHADOW-IMAGE] [BLUR-OPTION]"
  exit 1
fi

originalfile=$1
filename="${originalfile%.*}"
fileextension="${originalfile##*.}"

base_file="${filename}_base.${fileextension}"
blur_file="${filename}_blur.${fileextension}"
shadow_file="$2"
blur_setting='0x16'
[ $3 ] && blur_setting="$3"

cp "$originalfile" "$base_file"
convert "$originalfile" -blur "$blur_setting" "$blur_file"

[ -f $2 ] && convert "$base_file" "$2" -gravity center -composite -matte "$base_file"
[ -f $2 ] && convert "$blur_file" "$2" -gravity center -composite -matte "$blur_file"

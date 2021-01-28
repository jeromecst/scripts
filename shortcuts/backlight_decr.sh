#!/bin/sh

folder="/sys/class/backlight/intel_backlight"
decr=1500
min_br=500
curr_br=$(cat $folder/brightness)
new_br=$(( $curr_br - $decr ))

[ $new_br -gt $min_br ] && echo $new_br > $folder/brightness || echo $min_br > $folder/brightness
echo $curr_br

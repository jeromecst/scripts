#!/bin/sh

folder="/sys/class/backlight/intel_backlight"
incr=1500
max_br=$(cat $folder/max_brightness)
curr_br=$(cat $folder/brightness)
new_br=$(( $curr_br + $incr ))

[ $new_br -lt $max_br ] && echo $new_br > $folder/brightness || echo $max_br > $folder/brightness
echo $curr_br

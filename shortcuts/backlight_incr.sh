#!/bin/sh

folder="/sys/class/backlight/intel_backlight"
incr=1500
max_br=$(cat $folder/max_brightness)
curr_br=$(cat $folder/brightness)
new_br=$(( $curr_br + $incr ))

if [ $new_br -lt $max_br ]
then
	echo $new_br > $folder/brightness
else
	echo $max_br > $folder/brightness
fi
echo $curr_br

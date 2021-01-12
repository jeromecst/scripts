#!/bin/sh

folder="/sys/class/backlight/intel_backlight"
decr=3000
min_br=500
curr_br=$(cat $folder/brightness)
new_br=$(( $curr_br - $decr ))

if [ $new_br -gt $min_br ]
then
	echo $new_br > $folder/brightness
else
	echo $min_br > $folder/brightness
fi
echo $curr_br

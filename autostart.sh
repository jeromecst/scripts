#!/bin/sh

bar.sh&
redshift&
hsetroot -fill $HOME/.wallpaper& 
if [ -f "/sys/class/power_supply/BAT0/status" ]
then
	light -N 1
fi

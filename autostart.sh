#!/bin/sh

bar.sh&
#setxkbmap -option caps:escape
redshift&
hsetroot -fill $HOME/.wallpaper& 
if [ ! -f "/sys/class/power_supply/BAT0/status" ]
then 
	#picom --config $HOME/.config/picom.conf& 
else
	light -N 1
fi

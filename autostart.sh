#!/bin/sh

bar.sh&
setxkbmap -option caps:escape
redshift&
feh --no-fehbg --bg-scale $HOME/.wallpaper& 
if [ ! -f "/sys/class/power_supply/BAT0/status" ];then 
	picom --config $HOME/.config/picom.conf& 
fi

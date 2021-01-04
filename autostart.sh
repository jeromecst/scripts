#!/bin/sh

bar.sh&
redshift&
hsetroot -fill $HOME/.wallpaper& 
if [ -f "/sys/class/power_supply/BAT0/status" ]
then
	sed "s/size: 12/size: 10/" $HOME/.config/alacritty_default.yml > $HOME/.config/alacritty/alacritty.yml
	light -N 1
else
	cp $HOME/.config/alacritty_default.yml $HOME/.config/alacritty/alacritty.yml
fi

#!/bin/sh

bar.sh&
redshift&
hsetroot -fill $HOME/.wallpaper& 
if [ -f "/sys/class/power_supply/BAT0/status" ]
then
	grep size $HOME/.config/alacritty_default.yml | sed -e "s/[0-9]\+/10/" > $HOME/.config/alacritty/alacritty.yml
	light -N 1
else
	cp $HOME/.config/alacritty_default.yml $HOME/.config/alacritty/alacritty.yml
fi

#!/bin/sh

bar.sh&
redshift&
hsetroot -fill $HOME/.wallpaper& 
if [ -f "/sys/class/power_supply/BAT0/status" ]
then
	sed -e "s/size: [0-9]\+/size: 9/" $HOME/.config/alacritty_default.yml  > $HOME/.config/alacritty/alacritty.yml
	light -N 1
else
	cp $HOME/.config/alacritty_default.yml $HOME/.config/alacritty/alacritty.yml
fi

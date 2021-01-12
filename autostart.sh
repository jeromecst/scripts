#!/bin/sh

bar.sh&
redshift&
hsetroot -fill $HOME/.wallpaper& 
if [ ! -d $HOME/.config/alacritty ]
then
	mkdir $HOME/.config/alacritty/
fi
if [ -f "/sys/class/power_supply/BAT0/status" ]
then
	sed -e "s/size: [0-9]\+/size: 8/" $HOME/.config/alacritty_default.yml  > $HOME/.config/alacritty/alacritty.yml
else
	cp $HOME/.config/alacritty_default.yml $HOME/.config/alacritty/alacritty.yml
fi

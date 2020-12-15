#!/bin/sh

for i in 6 5 4 3 2 1
do
	alacritty -e figlet.sh $i&
	sleep .15s
done

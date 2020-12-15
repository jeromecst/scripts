#!/bin/sh

time=10

while true
do
	for file in $HOME/download/wallpaper/ariana/*
	do
		feh --bg-scale $file
		sleep "$time"m
	done
done

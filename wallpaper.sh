#!/bin/sh

time=10

while true
do
	for file in $HOME/download/wallpaper/nocat/*
	do
		hsetroot -fill $file
		sleep "$time"m
	done
done

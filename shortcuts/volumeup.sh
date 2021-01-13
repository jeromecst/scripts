#!/bin/sh

pactl set-sink-volume @DEFAULT_SINK@ +1% 
pkill -10 bar.sh

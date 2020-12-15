#!/bin/sh

pactl set-sink-mute @DEFAULT_SINK@ toggle
pkill -34 bar.sh

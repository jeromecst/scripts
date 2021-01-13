#!/bin/sh

pactl set-source-mute @DEFAULT_SOURCE@ toggle
pkill -35 bar.sh

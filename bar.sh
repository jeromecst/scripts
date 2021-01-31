#!/bin/sh

# dwm status bar
# requirements
#	- dwm
#	- iwd
#	- sending signals 10 & 34 & 35 when changing volume/mute/mic mute

# does improve performance very slightly 
LC_ALL=C
LANG=C

# handle signal
trap "get_volume" 10
trap "mute" 34
trap "mic_status" 35
trap "echo update" 36


get_time () { time=" $( date +"%H:%M" )"; }
get_date () { date=" $( date +"%d %b %Y" )"; }
get_weather () { weather=$(curl wttr.in/?format=3) ; }
set_bar_battery (){ bar=" $mic - $disk - $temp - $volume - $network - $battery - $time - $date " ; }
set_bar_not_battery() { bar=" $mic - $disk - $temp - $volume - $network - $time - $date " ; }
get_disk () { disk=" $(df -h | grep -w / | awk ' { print $4 }')"  ; }


mute () {
	muted=$(pacmd list-sinks | grep mute | awk '{ print $2 }')
	[ $muted = "yes" ] && volume="" || get_volume
}

get_temp () {
	temp=$(( $(cat /sys/class/thermal/thermal_zone$device_temp/temp) / 1000))
	[ $temp -ge 50 ] && temp=" $temp°C" || temp=" $temp°C"
}


get_network () {
	network_name=$( iwctl station wlan0 show | grep "Connected network" | awk '{ print $3 }' )
	network_state=$( iwctl station wlan0 show | grep "State" | awk '{ print $2 }')
	if [ "$network_state" = "disconnected" -o -z "$network_state" ] ; then
		network=" wifi disconnected"
	else
		network=" $network_name"
	fi
}

get_volume () {
	if [ "$muted" = "no" ]; then
		volume=" $(pacmd list-sinks|grep -A 15 '* index'| awk '/volume: front/{ print $5 }' | sed 's/[%|, ]//g')%"
	fi
}

mic_status() {
	if [ -n "$(pactl list sources | grep "Mute: yes")" ] ; then
		mic=""
	else
		mic=""
	fi
}

get_battery () {
	batstatus=$(cat /sys/class/power_supply/BAT0/status)
	batpor=$(cat /sys/class/power_supply/BAT0/capacity)
	battery="$batstatus $batpor%"
	if [ $batpor -ge 90 ]; then 
		battery=" $battery"
	elif [ $batpor -ge 75 ]; then
		battery=" $battery"
	elif [ $batpor -ge 50 ]; then
		battery=" $battery"
	elif [ $batpor -ge 10 ]; then
		battery=" $battery"
	else 
		battery=" $battery"
	fi
}

init () {
	device_temp=$(cat /sys/class/thermal/thermal_zone*/type | grep -n x86 | sed 's/:x86.*//g')
	device_temp=$(($device_temp - 1))

	[ -f "/sys/class/power_supply/BAT0/status" ] && display_battery=1 || display_battery=0

	pactl set-sink-mute @DEFAULT_SINK@ 0
	pactl set-source-mute @DEFAULT_SOURCE@ 1
	mute
}

display () {
	[ $display_battery = "1" ] && get_battery && set_bar_battery || set_bar_not_battery
	xsetroot -name "$bar"
}

init
while true; do
	get_date; get_time; mic_status; get_disk; get_temp; get_network
	display
	sleep 10 & wait $!
done

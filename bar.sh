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
trap "mute_mic" 35
trap "update" 12

update () {
	echo updating...
	update=1
}

mute_mic () {
	mic_status
	update
}


get_network () {
	network_name=$( iwctl station wlan0 show | grep "Connected network" | awk '{ print $3 }' )
	network_state=$( iwctl station wlan0 show | grep "State" | awk '{ print $2 }')
	if [ "$network_state" = "disconnected" -o -z "$network_state" ] 
	then
		network=" wifi disconnected"
	else
		network=" $network_name"
	fi
}

get_time () {
	time=" $( date +"%H:%M" )"
}

get_date () {
	date=" $( date +"%d %b %Y" )"
}

get_volume () {
	echo $muted
	if [ "$muted" = "no" ]
	then
		volume=" $(pacmd list-sinks|grep -A 15 '* index'| awk '/volume: front/{ print $5 }' | sed 's/[%|, ]//g')%"
		update=1
	fi
}

mic_status() {
	if [ -n "$(pactl list sources | grep "Mute: yes")" ]
	then
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

get_weather () {
	weather=$(curl wttr.in/?format=3)
}

mute () {
	muted=$(pacmd list-sinks | grep mute | awk '{ print $2 }')
	if [ $muted = "yes" ]; then
		volume=""
	else
		get_volume
	fi
	update=1
}

get_temp () {
	temp=$(( $(cat /sys/class/thermal/thermal_zone$device_temp/temp) / 1000))
	if [ $temp -ge 50 ] 
	then
		temp=" $temp°C"
	else
		temp=" $temp°C"
	fi
}

get_disk () {
	disk=" $(df -h | grep -w / | awk ' { print $4 }')" 
}


init () {
	device_temp=$(cat /sys/class/thermal/thermal_zone*/type | grep -n x86 | sed 's/:x86.*//g')
	device_temp=$(($device_temp - 1))

	if [ -f "/sys/class/power_supply/BAT0/status" ]
	then 
		display_battery=1
	else
		display_battery=0
	fi

	pactl set-sink-mute @DEFAULT_SINK@ 0
	pactl set-source-mute @DEFAULT_SOURCE@ 1
	update=1
	k=-1

	get_disk
	mic_status
	mute
	get_volume
	get_date
	get_time
}

update_case () {
	k=$(($k+1))
	case $k in 
		0)
			get_date
			update
			;;
		150)
			get_time
			update
			;;
		200)
			mic_status
			update
			;;
		300) 
			get_disk
			update
			;;
		600)
			k=-1
			;;
	esac
}

main_battery (){
	while true; do
		update_case
		if [ $(($k%50)) -eq 0 ]; then
			get_temp
			get_battery
			get_network
			update
		fi
		if [ "$update" -eq 1 ];then
			bar=" $mic - $disk - $temp - $volume - $network - $battery - $time - $date "
			xsetroot -name "$bar"
			update=0
		fi
		sleep .1
	done
}

main_no_battery (){
	while true; do
		update_case
		if [ $(($k%50)) -eq 0 ]; then
			get_temp
			get_network
			update
		fi
		if [ "$update" -eq 1 ];then
			bar=" $mic - $disk - $temp - $volume - $network - $time - $date "
			xsetroot -name "$bar"
			update=0
		fi
		sleep .1
	done
}

init
case $display_battery in
	1)
		main_battery;;
	0)
		main_no_battery;;
esac

#!/bin/sh

# dwm status bar
# see https://github.com/stark/siji for more and free icons
# and https://www.nerdfonts.com/

get_bandwidth () {
	while true
	do
		line=$(grep $1 /proc/net/dev | sed s/.*://)
		down=$(echo $line | awk '{print $1}')
		up=$(echo $line | awk '{print $9}')
		sleeptime=2
		sleep $sleeptime
		line=$(grep $1 /proc/net/dev | sed s/.*://)
		down2=$(echo $line | awk '{print $1}')
		up2=$(echo $line | awk '{print $9}')
		dlspeed=$((($down2 - $down)/(1000*$sleeptime) ))
		upspeed=$((($up2 - $up)/(1000*$sleeptime) ))
		echo $dlspeed > /tmp/dlspeed
		echo $upspeed > /tmp/upspeed
	done&
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

get_network_speed() {
	dlspeed=$(cat /tmp/dlspeed)
	upspeed=$(cat /tmp/upspeed)
	nspeed=" $dlspeed/$upspeed kB/s"
}

get_time () {
	time=$( date +"%H:%M" )
	time=" $time" 
}

get_date () {
	date=$( date +"%d %b %Y" )
	date=" $date" 
}

get_volume () {
	if [ $muted -eq 0 ]
	then
		volume=$(pacmd list-sinks|grep -A 15 '* index'| awk '/volume: front/{ print $5 }' | sed 's/[%|,]//g')
		volume=" $volume%"
	fi
	update=1
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
	if [ $muted -eq 0 ]; then
		muted=1
		volume=""
	else
		muted=0
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


device_temp=$(cat /sys/class/thermal/thermal_zone*/type | grep -n x86 | sed 's/:x86.*//g')
device_temp=$(($device_temp - 1))


if [ -f "/sys/class/power_supply/BAT0/status" ];then 
	display_battery=1
else
	display_battery=0
fi

trap "get_volume" 10
trap "mute" 34

pactl set-sink-mute @DEFAULT_SINK@ 0
muted=0
update=1 # a boolean
k=-1

get_weather
get_disk
get_volume
get_date
get_time

while true; do
	k=$(($k+1))
	case $k in 
		0)
			get_date
			get_time
			update=1
			;;
		200)
			get_weather
			update=1
			;;
		400) 
			get_disk
			update=1
			;;
		600)
			k=-1
			;;
	esac
	if [ $(($k%50)) -eq 0 ]; then
		get_temp
		get_network
		update=1
	fi
	if [ $update -eq 1 ];then
		case $display_battery in 
			1)
				get_battery
				bar=" $weather | $disk | $temp | $volume | $network | $battery | $time | $date "
				;;
			0)
				bar=" $weather | $disk | $temp | $volume | $network | $time | $date "
				;;
		esac
		xsetroot -name "$bar"
		update=0
	fi

	sleep .1
done

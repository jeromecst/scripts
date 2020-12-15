#!/bin/sh -e

# cleanest script I've ever written LMAO

ip=$(curl ifconfig.co -s)
space="false"
if [ ! -d /tmp/ips ] ; then
	mkdir /tmp/ips
fi

while true ; do
	date=$(date +%F@%R:%S)
	sec=$(($(date +%S)+10))
	while [ $(date +%S) -ne $sec ]; do
		ss -atH >> /tmp/jlog
	done
	
	grep 'ssh' /tmp/jlog | grep -v -e "LISTEN" -e "$ip" | grep 'ssh' | sed 's/^.*\(ssh.*\)/\1/g' | cut -d' ' -f2- | sed 's/^[ \t]*//;s/[ \t]*$//' | cut -f1 -d":" | sort -u | sed -r '/^\s*$/d'  > /tmp/jlog.tmp && cat /tmp/jlog.tmp > /tmp/jlog
	rm /tmp/jlog.tmp

	unset check
	while read p; do
		if [ -f "/tmp/ips/$p" ] ; then
			location="$(cat /tmp/ips/$p)"
		else
			curl -s https://freegeoip.app/xml/$p | awk '$1=$1' > /tmp/curl
			country=$(cat /tmp/curl | grep "/CountryName" | sed 's/<\/.*>//g' | sed 's/<.*>//g')
			city=$(cat /tmp/curl | grep "/City" | sed 's/<\/.*>//g' | sed 's/<.*>//g')
	
			#echo '*'$country'*' "*"$city"*"
	
			if [ "$country" = "" ] || [ "$city" = "" ] ; then
				curl -s https://ipapi.co/$p/json/ | sed 's/[",:]//g' | awk '$1=$1'> /tmp/curl
				if [ "$country" = "" ] ; then
					country=$(cat /tmp/curl | grep "country_name" | sed 's/country_name//g' )
				fi
				if [ "$city" = "" ] ; then
					city=$(cat /tmp/curl | grep "city" | sed 's/city//g' )
				fi
				#echo '*'$country'*' "*"$city"*"
	
				if [ "$country" = "" ] || [ "$city" = "" ] ; then
					curl -s ipinfo.io/$p | sed 's/[",:]//g' | awk '$1=$1' > /tmp/curl
					if [ "$country" = "" ] ; then
						country=$(cat /tmp/curl | grep "country" | sed 's/country//g' )
					fi
					if [ "$city" = "" ] ; then
						city=$(cat /tmp/curl | grep "city" | sed 's/city//g' )
					fi
					#echo '*'$country'*' "*"$city"*"
				fi
			fi

			if [ "$country" = "" ] ; then
				echo " " > /tmp/ips/$p
			elif [ "$city" = "" ] ; then
				echo "$country" > /tmp/ips/$p
			else
				echo "$country | $city" > /tmp/ips/$p
			fi
			
			location="$(cat /tmp/ips/$p) <new>"
		fi

		echo "$date --> $p <-- $location" | awk '$1=$1'

		bool="true"
		last=$(date +%S)
		space="false"

	done < /tmp/jlog

	if [ "$bool" = "true" ] && [ "$(($(date +%S)-$last))" -ge 180 ] && [ "$space" = "false" ]
	then
		echo	
		space="true"
	fi

	# if /tmp/ips/file is more than 24hours old, we delete it
	/usr/bin/find /tmp/ips/ -type f -name '*' -mtime +1 -exec rm {} \;
done

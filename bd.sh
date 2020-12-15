#!/bin/sh

awk  '{print $2}' /home/jerome/.jserv/notes/bd.md >> /tmp/bd
for n in '0' '1' '2' '3' '4' '5' '6' '7'
do
	cur_date="$(date -d "+$n days" +%d/%m)"
	if cat /tmp/bd | grep "$cur_date" > /dev/null; then
		line="$(grep -n "$cur_date" /tmp/bd | cut -d : -f 1)"
		name="$(cat /home/jerome/.jserv/notes/bd.md | grep "$cur_date" | cut -d ' ' -f 1)"
		if [ "$n" == "0" ]
		then
			echo "Anniversaire de $name aujourd'hui !!"
		else
			echo "Anniversaire de $name dans $n jours !!"
		fi
	fi
done
rm /tmp/bd

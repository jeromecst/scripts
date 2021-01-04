#!/bin/sh

file=$HOME/archive/notes/bd.md

sed "s/.*|' '?//g" $file > .cache/bd
sed "s/|.*//g" archive/notes/bd.md > .cache/bdname

for n in $(seq 7)
do
	cur_date="$(date -d "+$n days" +%d/%m)"
	if grep "$cur_date" /tmp/bd > /dev/null; then
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

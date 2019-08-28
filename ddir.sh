#!/bin/bash -e

# simple script to decrypt all .gpg files, recursively, in a folder.
# usage : ddir folder/

if [ -z "$1" ]
then
	echo Please specify a folder
else
	rm -f /tmp/gpgfile
	printf "decrypting $1"
	find "$1" -type f -name "*.gpg" -print > /tmp/gpgfile
	sed -i 's/....$//' /tmp/gpgfile &
	for i in 1 2 3
	do
		printf "."
		sleep .3
	done
	wait
	echo
	while read file
	do
		gpg --yes -o "$file" -d "$file".gpg &> /dev/null
		echo [+] "$file".gpg
		rm -f "$file".gpg &> /dev/null
	done < /tmp/gpgfile

	if [ ! -s /tmp/gpgfile ]
	then
		echo no file decrypted
	fi
	
	echo done
fi

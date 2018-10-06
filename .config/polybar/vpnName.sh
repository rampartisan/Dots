#!/bin/sh
line="$(nmcli con show --active | grep -w vpn)"

if [ -z "$line" ]
then
	exit 1
else
	set -- $line
	echo $1
fi

#!/bin/bash
xsetroot -name "Checking for Status"
while(true)
do
	Battery=$( cat /sys/class/power_supply/BAT0/status|grep -Po "^." )
	Capacity=$( cat /sys/class/power_supply/BAT0/capacity )
	Level=$( cat /sys/class/power_supply/BAT0/capacity_level )
	Date=$( date +"%F" )
	Time=$( date +"%T" )
	Free=$( free -m |head -2 |tail -1|awk -F ' ' '{print $3}' )
	Available=$( df -kh / |tail -1|awk -F ' ' '{print $4}' )
	/usr/bin/ping -c 1 8.8.8.8 >> /dev/null
	[[ $? = 0 ]] && Connected="Connected" || Connected="Not Connected"
	Status="$Battery:$Level:$Capacity%|$Free MiB|$Available|$Connected|$Date|$Time"
	xsetroot -name "$Status"
	sleep 1m
done

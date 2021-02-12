#!/bin/bash
xsetroot -name "Checking for Status"
while(true)
do
	Battery=$( sysctl hw.acpi.battery.state |awk '{print $2}')
	Capacity=$( sysctl hw.acpi.battery.life |awk '{print $2}')
	Level=$( sysctl hw.acpi.battery.time |awk '{print $2}' )
	[ $Battery = 1 ] && Battery="D:$Capacity%:$Level" || Battery="C:$Capacity%"
	Date=$( date +"%F" )
	Time=$( date +"%T" )
	Free=$( vmstat -h |tail -1|awk '{print $5}' )
	Available=$( df -kh / |tail -1|awk -F ' ' '{print $4}' )
	$(which ping) -c 1 8.8.8.8 >> /dev/null
	[[ $? = 0 ]] && Connected="Connected" || Connected="Not Connected"
	Status="$Battery|$Free|$Available|$Connected|$Date|$Time"
	xsetroot -name "$Status"
	sleep 5
done

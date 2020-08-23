#!/bin/bash
export DEVICE=$(ip link show |tail -2 |head -1|awk -F ': ' '{print $2}')
sudo wpa_supplicant -BD wext -i $DEVICE -c /etc/wpa_supplicant.conf
sudo dhclient $DEVICE

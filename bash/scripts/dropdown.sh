#!/bin/bash
PID=$(ps -ef |grep alacritty |grep dropdown |awk '{print $2}')
[ -z "$PID" ] && (alacritty --title dropdown --position 0 0 --dimensions 152 20 &) || kill -n 9 $PID

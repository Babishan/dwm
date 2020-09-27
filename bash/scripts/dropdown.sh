#!/bin/bash
PID=$(ps -ef |grep st |grep dropdown |awk '{print $2}')
[ -z "$PID" ] && (st -T dropdown -g 198X20+0+0 &) || kill -n 9 $PID

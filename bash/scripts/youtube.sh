#!/bin/bash
search=$(echo ''|dmenu);
if [ -z "$search" ]
then
    exit 1
else
    firefox https://www.youtube.com/results?search_query=${search// /+}
fi


#!/bin/bash
search=$(echo ''|dmenu);
if [ -z "$search" ]
then
    exit 1
else
    firefox https://www.imdb.com/find?q=${search// /+}
fi


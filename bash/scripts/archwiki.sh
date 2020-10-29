#!/bin/bash
search=$(echo 'dwm'|dmenu);
if [ -z "$search" ]
then
    exit 1
else
    firefox https://wiki.archlinux.org/index.php?search=${search// /+}
fi


#!/bin/bash

function nav {
	while [[ $(ls -ltr|awk '$9=$9') ]]
	#while [ $(ls -d */ 2>/dev/null |wc -l) -ne 0 ]
	do
		select fname in $(ls -ltar | awk '$9=$9 {print $9}')
		do 
			[ -f $fname ] && vi $fname && exit 0 || cd $fname
			break
		done
	done

	echo "$(pwd) is an empty directory"
	select choice in "exit" "cd $(dirname $(pwd))" "cd $HOME"
	do
		$choice
		nav
	done
}

nav


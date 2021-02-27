#!/bin/bash

#Docker shortcuts

function dps {
	docker ps -a
}
function dremove {
	dps
	for i in $(docker ps -a|grep -v 'CONTAINER'|awk '{print$1}');do docker kill $i; docker rm $i ;done
}

function dimages {
	docker images
}

function dpurge {
	dimages
	for i in $(docker images|awk '{print $3}'|grep -v 'IMAGE');do docker image rm $i;done
}

function dclean {
	dremove
	dpurge
}

function dstart {
	sudo systemctl start docker
}

function dstop {
	sudo systemctl stop docker
}

$1

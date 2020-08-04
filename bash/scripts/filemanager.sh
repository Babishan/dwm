#!/bin/bash
function open_file {
    file_name=$1
    file_type=$(file --mime-type $file_name|awk -F ': ' '{print $2}'|awk -F '/' '{print $1}')
    case "$file_type" in
        text)
            program_name='st -e vi'
            ;;
        image)
            program_name=ristretto
            ;;
        video)
            program_name=vlc
            ;;
        audio)
            program_name=vlc
            ;;
        *)
            exit 1
    esac
    $program_name $file_name &
    
}
function main {
    starting_point=$HOME;
    while(true)
    do
    
    new_point=$(ls -a $starting_point|dmenu)
    
    if [ -z "$new_point" ]
    then
		exit 1
	else
		starting_point="$starting_point/$new_point"
    fi

    if [[ -f "$starting_point" ]]
    then
    open_file $starting_point
    exit 0
    fi
    
    done
}

main

exit 0





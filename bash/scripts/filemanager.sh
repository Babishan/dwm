#!/bin/bash
function open_file {
    file_name="$1"
    file_mode="$2"
    file_type=$(file --mime-type "$file_name"|awk -F ': ' '{print $2}'|awk -F '/' '{print $1}')
    file_sub_type=$(file --mime-type "$file_name"|awk -F ': ' '{print$2}'|awk -F '/' '{print $2}')
    case "$file_type" in
	    text)
		    [ "$file_sub_type" = "x-shellscript" ] && modes="read\nwrite\nexecute" || modes="read\nwrite"
		    [ -z "$file_mode" ] && open_file $file_name $(printf "$modes" |dmenu)
		    [ "$file_mode" = "read" ] && program_name='st -e vim -M'
		    [ "$file_mode" = "write" ] && program_name='st -e vim'
		    [ "$file_mode" = "execute" ] && program_name='st -e bash'
		    ;;
            image)
                    program_name=feh
                    ;;
            video)
		    program_name="st -e cvlc -f"
		    ;;
            audio)
		    program_name='st -e cvlc'
	    	    ;;
            application)
		    program_name='st -e'
	    	    ;;
	    inode)
		    sym_file=$(file "$file_name"|awk -F 'symbolic link to ' '{print $2}')
		    sym_dir=$(dirname "$sym_file")
		    [ "$sym_dir" = "." ] && actual_file=$(dirname "$file_name")/"$sym_file" || actual_file="$sym_file"
		    [ "$file_sub_type" = "symlink" ] && open_file "$actual_file" && exit 0 
		    ;;
	    *)
		    exit 1
    esac
    $program_name "$file_name" &
    exit 0
    
}
function main {
    [ -z "$1" ] && starting_point=$HOME || starting_point="$1";
    while(true)
    do
	    new_point=$(ls -a "$starting_point"/|dmenu)
	    ##new_point="${new_point// /\\ }"
	    [ -z "$new_point" ] &&  exit 1 ||starting_point="$starting_point"/"$new_point"
	    [ -f "$starting_point" ] && open_file "$starting_point"
    done
}

main $1


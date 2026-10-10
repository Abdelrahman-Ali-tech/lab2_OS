#!/bin/sh
if [ $# -lt 2 ]
then 
    echo "wrong format -> dir malicious_dir "
    exit 1
fi   
dir = "$1"
malicious_dir = "$2"

if [ ! -d "$malicious_dir" ] || [ $(ls -A "$malicious_dir" wc -l)-eq 0 ]
then 
    echo "No maliciousfiles to review "
    exit 0

while true 
do 
    echo ""
    ehco "        Quarntine Files     "
    count=1
    set -- "$malicious_dir"/*

    if [ ! -e "$1" ]
    then
        echo "No maliciousfiles to review "
        break
    fi

    for file in "$@"
    do 
        echo "$count) $(basename "$file")"
        count=$((count + 1))
    done 
    echo "select number or 0 to exit"
    read choice

    if [ "$choice" -eq 0 ]
    then
       break
    fi

    eval selected_file=\${$choice}
    fname=$(basename "$selected_file")"
    
    echo " option for [$fname]:"
    echo "1.restore file "  
    echo "2.delete file"  
    echo "3.leave this file as-is" 
    read action

    case "$action" in 
    1)
        cp "$selected_file" "$dir/"
        rm "$selected_file"
        echo "restored $fname to $dir "
        ;;
    2)

        rm "$selected_file"
        echo "$fname permanently deleted"
        ;;
    3)      
        echo "left $fname as-is"
        ;;


    esac
done
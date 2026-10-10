#!/bin/sh
if [ $# -lt 3 ]
then 
    echo "wrong format -> dir malicious_dir interval-secs"
    exit 1
fi   

dir="$1"
malicious_dir="$2"
interval="$3"

mkdir -p "$malicious_dir"
ls -l "$dir" >directory-info.last

while true
do
    sleep "$interval"

    ls -l "$dir" >directory-info.new 

    if ! diff -q directory-info.last directory-info.new
    then 
        echo " Change detected scan start "
        for file in "$dir"/*
            do
                if [ -f "$file" ] 
                then
                    filename=$(basename "$file") 
                    malicious=0
                    case "$filename" in
                    *.exe) 
                        malicious=1
                        ;;
                    *.bat) 
                        malicious=1
                        ;;
                    *.vbs) 
                        malicious=1
                        ;;
                    *.scr) 
                        malicious=1
                        ;;
                    *.ps1) 
                        malicious=1                        
                    ;;  
                    esac

                    if [ "$malicious" -eq 0 ]
                    then
                        if grep -q -i -E "virus|trojan|malware|worm|ransomware" "$file"
                            then
                            malicious=1
                        fi
                    fi

                    if [ "$malicious" -eq 1 ]
                    then
                        echo "$filename is malicious and it is DELETED"
                        cp "$file" "$malicious_dir/"
                        rm "$file"
                                         
                    fi
                fi
            done
        cp directory-info.new directory-info.last
    fi
done

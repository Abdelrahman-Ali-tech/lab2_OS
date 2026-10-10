#!/bin/sh
if [ $# -lt 3 ]
then 
    echo "wrong format -> dir malicious_dir interval-secs"
    exit 1
fi   

dir="$1"
malicious_dir="$2"
interval-secs="$3"

mkdir -p "$malicious_dir"
ls -l "$dir" >directory-info.last

while true

sleep "$interval-secs"

ls -l "$dir" >directory-info.new 

if ! diff -p directory-info.last directory-info.new
then 
    echo " Change detected scan start "

    cp directory-info.new directory-info.last
        
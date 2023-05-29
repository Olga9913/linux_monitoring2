#!/bin/bash
. ./brain.sh
# main.sh az az.az 3Mb
export folder_letters=${1}
export file_letters=${2}
export size=${3}

if ! [[ -n $1 ]]; then
    echo "There are no parametres at all. Enter 3 parameters"
    exit 1
else
if [[ -n $4 ]]; then
    echo "The number of arguments provided is more than 3. Please provide 3 parameters."
    exit 1
else
root_free=$(df / | awk 'FNR == 2{printf ("%.0f\n", $4/1024)}')
if [[ $root_free -lt 1024 ]]; then
    echo "/root space is less than 1Gb. the script is stopped (root space - $root_free Mb) "
    exit 1
else
reg='^[a-zA-Z]{1,7}$'
if ! [[ $folder_letters =~ $reg ]]; then
    echo "incorrect name for folders"
    exit 1
else
reg='^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$'
if ! [[ $file_letters =~ $reg ]]; then
    echo "incorrect name for files"
    exit 1
else
if [[ !($size =~ ^[0-9]+(Mb)$) ]]; then
    echo "Invalid input: Parametr 3 (file size) must be in Mb: $3"
    exit 1
else
    size=$(echo $size | awk -F"Mb" '{print $1}')  
fi; fi; fi; fi; fi; fi

start

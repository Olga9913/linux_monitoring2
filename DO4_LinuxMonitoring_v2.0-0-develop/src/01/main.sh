#!/bin/bash
. ./brain.sh
#bash main.sh /media/main.sh 5 abcd 3 try.shd 13kb
export absolute_path=${1}
export number_of_subfolders=${2}
export number_of_files_in_folders=${4}
export letters_used_in_folder_names=${3}
export letters_used_in_files_names=${5}

if ! [[ "$1" = /* ]]; then
    echo "It seems it's a relative path. Enter an absolute path with '/' in the beginning"
else
if ! [[ -n $1 ]]; then
    echo "There are no parametres at all. Enter six parameters" 
else
if [[ -n $7 ]]; then
    echo "The number of arguments provided is more than 6. Please provide 6 parameters."
else
if [[ ! ( -d $1) ]]; then
    echo "Error: Parameter 1 - No such directory: $1"
else
if [[ !($2 =~ ^([0-9]+)$) ]]; then
    echo "Invalid input: Parameter 2 (number of subfolders) must be a number: $2"
else
if [[ $(echo $3 | wc -c) -gt 8 ]]; then
    echo "Invalid input: Parameter 3 (folder name letter list) must be no more than 7 characters: $3"
else
if [[ !($3 =~ ^([a-zA-Z]+)$) ]]; then
    echo "Invalid input: Parameter 3 (folder name letter list) must be only from the English alphabet: $3"
else
if [[ !($4 =~ ^([0-9]+)$) ]]; then
    echo "Invalid input: Parameter 4 (number of files) must be a number: $4"
else
if [[ !($5 =~ ^[a-zA-Z]+\.[a-zA-Z]+$ ) ]]; then
    echo "Invalid input: The parameter must be in the form - [a-zA-Z].[a-zA-Z] no more than 7 letters before the point and no more than 3 letters after the point: $5"
else
filename=$(echo $5 | cut -d. -f1)
if [[ $(echo $filename | wc -c) -gt 8 ]]; then
    echo "Invalid input: Parameter 5 (file name letter list) must be no more than 7 characters before the dot: $filename"
else
if [[ !($filename =~ ^([a-zA-Z]+)$) ]]; then
    echo "Invalid input: Parameter 5 (file name letter list) must be only from the English alphabet: $filename"
else
filext=$(echo $5 | cut -d. -f2)
if [[ $(echo $filext | wc -c) -gt 4 ]]; then
    echo "Invalid input: Parameter 5 (file name letter list) must be no more than 3 characters after the dot: $filext"
else
if [[ !($filext =~ ^([a-zA-Z]+)$) ]]; then
    echo "Invalid input: Parameter 5 (file name letter list) must be only from the English alphabet: $filext"
else
if [[ !($6 =~ ^[0-9]+(kb)$) ]]; then
    echo "Invalid input: Parametr 6 (file size) must be in kilobates (kb): $6"
else
if [[ -n $6 ]]; then
    root_free=$(df / | awk 'FNR == 2{printf ("%.0f\n", $4/1024)}')
    if [[ $root_free -lt 1024 ]]; then
        echo "/root space is less than 1Gb. the script is stopped (root space - $root_free Mb) "
        exit 1
    fi
    file_size_parse $6
    export file_size=${?}
    if ! [[ file_size -gt 100 ]]; then
        check_size
    else
        echo "The size of the files should be not greater than 100kB"
        exit 1
    fi           
    folder_loop $3
fi; fi; fi; fi; fi; fi; fi; fi; fi; fi; fi; fi; fi; fi; fi

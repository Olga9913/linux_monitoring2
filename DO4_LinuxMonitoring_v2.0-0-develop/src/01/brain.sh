#!/bin/bash

function check_size {
    full_filename=$letters_used_in_files_names  
    IFS='.' read -ra my_array <<< "$full_filename"
    devided_filename="${my_array[@]}"
    first=$(echo $devided_filename | awk '{print $1}')
    sec=$(echo $devided_filename | awk '{print $2}')
    export before_dot=$first
    export ext=".$sec"
}

function folder_file_create {
    if [[ ${#before_dot} -lt 4 ]]
    then
        get_four_chars_file
        used_letter_file=$letters_file
    else
        used_letter_file=$before_dot
    fi
    file_name=$used_letter_file
    folder_name=$1
    dirname=$absolute_path/$folder_name$(date +_%d%m%y)
    mkdir $dirname
    echo "Folder created:" $dirname $(date) >> ./generator.log
    local i; local j; local k
    for (( i = 0; i < $number_of_files_in_folders; i++ )); do
        file=""
        for (( j = 0; j < ${#file_name}; j++ )); do
            for (( k = 0; k <= $i; k++ )); do           
                file="$file""${file_name:$j:1}" 
            done
        done
        if [[ ${#file} -ge 4 ]]; then 
            kb="KB"
            truncate -s $file_size$kb $dirname/$file$(date +_%d%m%y)$ext
            echo "File created:" $dirname/$file$(date +_%d%m%y)$ext $(date) $file_size$kb >> ./generator.log
        fi
    done
}

function file_size_parse {
    res=$(echo ${1} | grep -o -E "[0-9]+")
    return $((res))
}

function folder_loop {
    if [[ ${#letters_used_in_folder_names} -lt 4 ]]
    then
        get_four_chars_folder
        used_letter=$letters
    else
        used_letter=$letters_used_in_folder_names
    fi
    local i; local j; local k
    for (( i = 0; i < ${number_of_subfolders}; i++ )); do
        folder=""
        for (( j = 0; j < ${#used_letter}; j++ )); do
            for (( k = 0; k <= $i; k++ )); do          
                folder="$folder""${used_letter:$j:1}" 
            done
        done
        if [[ ${#folder} -ge 4 ]]; then
            folder_file_create $folder
        fi
    done
}

function get_four_chars_folder {
    letters=$letters_used_in_folder_names
    if [[ ${#letters} -eq 1 ]]; then
        add_letters=3
    elif [[ ${#letters} -eq 2 ]]; then
        add_letters=2
    else
        add_letters=1
    fi
    letters=$letters_used_in_folder_names
    last_letter=${letters_used_in_folder_names: -1}
    while [[ $add_letters -gt 0 ]]
    do
        letters+="$last_letter"
        add_letters=$[ $add_letters - 1 ]
    done       
}

function get_four_chars_file {
    letters_file=$before_dot
    if [[ ${#letters_file} -eq 1 ]]; then
        add_letters_file=3
    elif [[ ${#letters_file} -eq 2 ]]; then
        add_letters_file=2
    else
        add_letters_file=1
    fi
    letters_file=$before_dot
    last_letter_file=${before_dot: -1}
    while [[ $add_letters_file -gt 0 ]]
    do
        letters_file+="$last_letter_file"
        add_letters_file=$[ $add_letters_file - 1 ]
    done       
}

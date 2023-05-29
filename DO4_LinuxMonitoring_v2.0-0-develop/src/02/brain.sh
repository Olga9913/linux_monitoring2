#!/bin/bash

function start {
    start_date=$(date +%s.%N)
    start_long=$(date +'%Y-%m-%d %H:%M:%S')
    generator_random
    stop
}

function generator_random {
    dirs_number=$(echo $(( $RANDOM % 100 + 1 )))
    echo "сколько папок сгенерировано: $dirs_number"
    if [[ ${#folder_letters} -lt 5 ]]
    then
        get_five_chars_folder
        used_letter=$letters
    else
        used_letter=$folder_letters
    fi
    for (( count_dirs=0; count_dirs < $dirs_number; count_dirs++ ))
    do 
        cd /
        path="/"
        folder_name=""
        dir_random
    done
    
}

function folder_file_create {
    before_dot="$(echo $file_letters | awk -F "." '{print $1}')"
    ext="$(echo $file_letters | awk -F "." '{print $2}')"
    if [[ ${#before_dot} -lt 5 ]]
    then
        get_five_chars_file
        used_letter_file=$letters_file
    else
        used_letter_file=$before_dot
    fi
    file_name=$used_letter_file
    folder_name=$1

    sudo mkdir $path$folder_name$(date +_%d%m%y) 2>/media/common_files/Mon2/02/error.txt
    echo $path$folder_name$(date +_%d%m%y) $(date +'%Y-%m-%d %H:%M:%S') >> /media/common_files/Mon2/02/generator.log
    create_files
}
  
function create_files {
    count_files=$(echo $(( $RANDOM )))
    echo "сколько файлов сгенерировано: $count_files"
    for (( number_files=0; number_files <$count_files; number_files++ ))
    do
        file=""
        local j; local k
        for (( j = 0; j < ${#file_name}; j++ )); do
            for (( k = 0; k <= $number_files; k++ )); do           
                file="$file""${file_name:$j:1}" 
            done
        done
        if [[ ${#file} -ge 5 ]]; then 
            mb="MB"
            sudo truncate -s $size$mb $path$folder_name$(date +_%d%m%y)/$file$(date +_%d%m%y)"."$ext 2>/media/common_files/Mon2/02/error1.txt #2>/dev/null
            echo "#truncate -s:$size$mb $path$folder_name$(date +_%d%m%y)/$file$(date +_%d%m%y).$ext"
            echo $path$folder_name$(date +_%d%m%y)"/"$file$(date +_%d%m%y)\.$ext $(date +'%Y-%m-%d %H:%M:%S') $size "Mb" >> /media/common_files/Mon2/02/generator.log
        fi
    done   
}

function dir_random {
    do_not_enter='\/[s]?bin'
    count_dirs_in_current_dir=$(echo $(ls -l -d */ 2>/dev/null | wc -l ))
    if [[ $count_dirs_in_current_dir -eq 0 ]]
    then
        random_number=0
    else
        random_number=$(echo $(( $RANDOM % $count_dirs_in_current_dir )))
    fi

    if [[ $random_number -eq 0 ]]
    then
        folder_loop
    else
        path+="$( ls -l -d */ | awk '{print $9}' | sed -n "$random_number"p )"
        if ! [[ $path =~ $do_not_enter ]]
        then
            cd $path 
            folder_loop
        fi
    fi
}

function folder_loop {
    local j; local k
    for (( j = 0; j < ${#used_letter}; j++ )); do
        for (( k = 0; k <= $count_dirs; k++ )); do          
            folder_name="$folder_name""${used_letter:$j:1}" 
        done
    done
    if [[ ${#folder_name} -ge 5 ]]; then
        folder_file_create $folder_name
    fi
}

function get_five_chars_folder {
    letters=$folder_letters
    if [[ ${#letters} -eq 1 ]]; then
        add_letters=4
    elif [[ ${#letters} -eq 2 ]]; then
        add_letters=3
    elif [[ ${#letters} -eq 3 ]]; then
        add_letters=2
    else
        add_letters=1
    fi
    letters=$folder_letters
    last_letter=${folder_letters: -1}
    while [[ $add_letters -gt 0 ]]
    do
        letters+="$last_letter"
        add_letters=$[ $add_letters - 1 ]
    done       
}

function get_five_chars_file {
    letters_file=$before_dot
    if [[ ${#letters_file} -eq 1 ]]; then
        add_letters_file=4
    elif [[ ${#letters_file} -eq 2 ]]; then
        add_letters_file=3
    elif [[ ${#letters_file} -eq 3 ]]; then
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

function stop {
    echo "Script start time is $start_long" >> /media/common_files/Mon2/02/generator.log
    end=$(date +%s.%N)
    end_long=$(date +'%Y-%m-%d %H:%M:%S')
    dur=$(echo "$end - $start_date" | bc); \
    echo "Script stop time is $end_long" >> /media/common_files/Mon2/02/generator.log
    printf "Script execution time (in seconds) = %.1f seconds\n" $dur >> /media/common_files/Mon2/02/generator.log
}

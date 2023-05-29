#!/bin/bash

function log_file_delete {
    logs="$(cat ../../02/generator.log | awk '{print $1}')"
    reg='^\/'
    for i in $logs:
    do  
        if [[ $i =~ $reg ]]
        then
            echo "sudo rm -rf: $i"
            sudo rm -rf $i
        fi
    done
}

function mask_name_delete {
    echo "enter the folder/file name for deleting in the folowing format: aboba_021222 (folder), aboba_021222* (file)"
    read name_patch
    find_patch=""
    find_patch_file=""
    echo "$name_patch - mask for searching"
    if [[ "$name_patch" == *\** ]]; then
        find_patch_file=$(sudo find / -type f -name "$name_patch*" 2>/dev/null)
        for i in $find_patch_file
        do 
            sudo rm -rf $i
            echo $i
        done
    else
        find_patch=$(sudo find / -type d -name "$name_patch" 2>/dev/null)
        for i in $find_patch
        do 
            sudo rm -rf $i
            echo $i
        done
    fi
}

function date_time_delete {
    read -r -p "Укажите дату и время начала поиска в формате ГГГГ-ММ-ДД ЧЧ:ММ:СС " answer_date
    case $answer_date in
    [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]\ [0-9][0-9]:[0-9][0-9]:[0-9][0-9]) export find_start_time=$answer_date ;;
    *)
        echo "Некорректный ввод"
        exit 1
        ;;
    esac
    read -r -p "Укажите время окончания в формате ГГГГ-ММ-ДД ЧЧ:ММ:СС или напишите date чтобы указать текущее время " answer_date
    case $answer_date in
    [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]\ [0-9][0-9]:[0-9][0-9]:[0-9][0-9]) export find_end_time=$answer_date ;;
    date) export find_end_time=$(date +"%Y-%m-%d %H:%M:%S") ;;
    *)
        echo "Incorrect input"
        exit 1
        ;;
    esac
    find_patch_time=$(find /usr -type f -newerct "$find_start_time" ! -newerct "$find_end_time" 2>/dev/null | grep '_[0-9][0-9][0-9][0-9][0-9][0-9].') #лучше искать в конкретной папке /usr, чтобы не удалить системные файлы
    #find_patch_time=$(find / -type d -newerct "$find_start_time" ! -newerct "$find_end_time" 2>/dev/null | grep '_[0-9][0-9][0-9][0-9][0-9][0-9]') #для удаления папок
    for i in $find_patch_time
    do 
        sudo rm -rf $i
        echo $i
    done
}

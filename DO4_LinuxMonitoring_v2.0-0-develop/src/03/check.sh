#!/bin/bash

function check {
    if [[ ${count_var} -ne 1 ]]
    then
        echo "invalid number of arguments"
        exit 1
    fi

    if [[ ${option} -gt 3 || ${option} -lt 1 ]]
    then
        echo "Incorrect parameter entered"
        exit 1
    fi

    if [[ $option -eq 1 ]]; then
        log_file_delete
    elif [[ $option -eq 2 ]]; then
        date_time_delete
    elif [[ $option -eq 3 ]]; then
        mask_name_delete
    fi
}
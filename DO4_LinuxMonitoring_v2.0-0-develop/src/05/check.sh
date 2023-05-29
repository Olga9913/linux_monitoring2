#!/bin/bash

function check {
    if [[ ${args} -ne 1 ]]
    then
	    echo "invalid number of arguments"
        exit 1
    fi

    if [[ ${par} -gt 4 || ${par} -lt 1 ]]; then
        echo "Incorrect parameter entered"
        exit 1
    fi

    if [[ $par -eq 1 ]]; then
        answer_code
    elif [[ $par -eq 2 ]]; then
        unique_ip
    elif [[ $par -eq 3 ]]; then
        error_record
    elif [[ $par -eq 4 ]]; then
        ip_plus_error
    fi
}
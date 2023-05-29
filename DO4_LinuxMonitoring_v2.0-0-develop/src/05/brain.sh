#!/bin/bash

function answer_code {
    for (( i=1; i<6; i++ ))
    do
        sort -k 2 ../04/$i.log -o answer_code_$i.log
        echo "$(pwd)"
    done
}

function unique_ip {
    for (( i=1; i<6; i++ ))
    do
        awk '{print $1}' ../04/$i.log  | uniq > unique_ip_$i.log
    done
}

function error_record {
    for (( i=1; i<6; i++ ))
    do
        awk '$2 ~ /[45][0-9][0-9]/' ../04/$i.log > error_record_$i.log
    done
}

function ip_plus_error {
    for (( i=1; i<6; i++ ))
    do
        awk '$2 ~ /[45][0-9][0-9]/' ../04/$i.log | awk '{print $1}' | uniq > ip_plus_error_$i.log
    done
}
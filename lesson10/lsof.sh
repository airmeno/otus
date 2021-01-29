#!/bin/bash
# lsof

# Format View
frmt="%-15s %-10s %-10s %-10s %-20s\n"

printf "$frmt" COMMAND PID USER NAME 

# Main loop

for pid in `ls  /proc/ | grep "^[0-9]" | sort -n`
    do
# Process User UID 
    if [[ -d "/proc/$pid" ]]
    then
    user=`awk '/Uid/{print $2}' /proc/$pid/status`
# Process - NAME
    comm=`cat /proc/$pid/comm`
    
# UID to UserName
    if [[ user -eq 0 ]]
    then
    username="root"
    else
    username=`grep $user /etc/passwd | awk -F ":" '{print $1}'`
    fi
# Results 
    ls_files=`readlink /proc/$pid/map_files/*`  
    if ! [[ -z "$ls_files" ]]
    then
    for lsf in $ls_files 
    do
    printf "$frmt" $comm $pid $username $lsf  
    done  
    fi
    fi
done
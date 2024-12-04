#!/bin/bash

#Monitoring the free file system space disk

FU=$(df -h | egrep -v "Filesystem|tmpfs" | grep "sda2" | awk '{print $5}' | tr -d %)
TO="puneetkoundal1@gmail.com"
if [[ $FU -ge 80 ]]
then
    echo "Warrning, Disk space is low - $FU %" | mail -s "Disk space ALERT!" $TO
else
    echo "All Good"
fi


#!/bin/bash

IFS=""
if [ $# -ne 0 ];then
        echo "Error: Invalid Number of Arguments!"
        exit 1
fi

sudo find /etc/ -daystart -atime 1 -type f -printf "%p\t%Ab %Ad %AH:%AM\n" > AccessLog

#!/bin/bash

if [ $# -ne 0 ]
then
	echo 'Error: Invalid Number of Arguments!'
	exit 1
fi

IFS=""

while read line
do
	
	file_content=$line
	length=${#file_content}
	length=`expr $length + 1`

	while [ $length -ne -1 ]
	do
		a=${file_content:$length:1}
		length=`expr $length - 1`
		echo -n $a
	done
	echo ""
done < $0

#!/bin/bash

OLDIFS=$IFS
IFS=""

if [ ! -e ~/TRASH ]
then
	mkdir ~/TRASH
fi

while [ "$1" ]
do
	file_name="$1"

	if [ ! -f "$file_name" ]
	then
		echo 'Error: Invalid File!'
	else
		file_type=`file -b $file_name | cut -d " " -f 1`
		if [ $file_type == "gzip" ]
		then
			file_name_gz="$file_name"
		else
			gzip "$file_name"
			file_name_gz="$file_name".gz
		fi
		mv $file_name_gz ~/TRASH/
	fi

	shift
done

IFS=$OLDIFS

for i in `find ~/TRASH -mtime +2 -type f`
do
	rm $i
done

#!/bin/bash

if [ $# -ne 1 ]
then
	echo 'Error: Invalid Number of Arguments!'
	exit 1
fi

if [ ! -d "$1" ]
then
	echo 'Error: Input not a directory '
	exit 1
fi

dir_path="$1"

length=`expr ${#dir_path} - 1`

last_char=${dir_path:$length:1}

if [ $last_char != "/" ]
then
	dir_path="$dir_path"/
fi

for i in "$dir_path"*
do
	file_dir_name="$i"

	file_dir_name_lower="`echo "$i" | tr A-Z a-z`"

	if [ "$file_dir_name" != "$file_dir_name_lower"  ] && ( [ -f "$file_dir_name_lower" ] || [ -d "$file_dir_name_lower" ] )
	then
		echo "Warning: Not overwriting `basename "$file_dir_name_lower"`"

	elif [ "$file_dir_name" != "$file_dir_name_lower" ]
	then
		mv "$file_dir_name" "$file_dir_name_lower"
	fi
done

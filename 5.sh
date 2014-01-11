#!/bin/bash

export EXEC_PATH_DEVILO=`readlink -f $0`

if [ $# -eq 0 ]
then
	bash $EXEC_PATH_DEVILO "."
	exit
fi

while [ "$1" ]
do
	a="$1"
	if [ -f "$a" ]
	then
		echo "$a"
	elif [ -d "$a" ]
	then
		a=`readlink -f "$a"`
		echo $a:
		if [ ! -x "$a" ]
        	then
       	        	shift
			continue
       		fi

		cd "$a"

		for i in *
		do
			if [ "$i" != '*' ] && [ -f "$i" ]
			then
				echo "$i"
			elif [ "$i" != '*' ] && [ -d "$i" ]
			then
				bash $EXEC_PATH_DEVILO "$a/$i"
			elif ([ "$i" != '*' ]) && ([ ! -f "$i" ] || [ ! -d "$i" ])
			then
				echo "Error: Invalid File/Directory!"
			fi
		done
		cd ..
	elif [ ! -f "$a" ] || [ ! -d "$a" ]
	then
		echo 'Error: Invalid File/Directory!'
	fi
	shift
done

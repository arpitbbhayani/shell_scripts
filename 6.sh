#!/bin/bash

if [ $# -ne 1 ]
then
	echo 'Error: Invalid Number of Arguments!';
	exit 1;
fi

if [ ! -d "$1" ]
then
	echo 'Error: Input not a directory' 
	exit 1;
fi
IFS=""
function print_space
{
	local i=0
	local limit=$1

	if [ $2 == "dir" ]
	then
		limit=`echo $limit - 2  | bc`
	else
		limit=`echo $limit - 1  | bc`
	fi

	while [ $i -le $limit ]
	do
		echo -n "|   "
		i=`echo $i + 1 | bc`		
	done

}

function dir_print
{
	local space=$2
	local old_dir=`pwd`

	print_space $space dir

	if [ $3 == "first" ]
	then
		echo -e "$1"
	else
		echo -e "|-- $1"
	fi

	if [ ! -x "$1" ]
	then
		return
	fi

	cd "$1"

	#if [ $? -ne 0 ]
	#then
	#	return
	#fi

	for i in *
	do
		if [ -f "$i" ]
		then
			print_space $space file
			echo "|-- $i"
		elif [ -d "$i" ]
		then
			dir_print "$i" `echo $space + 1 | bc` non-first
		fi
	done
	cd "$old_dir"
}

dir_print $1 0 first

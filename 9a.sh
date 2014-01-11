#!/bin/bash

function strlen
{
	str1="$1"
	echo ${#str1}
}

function strcat
{
	str1="$1"
	str2="$2"
	echo "$str1""$str2"
}

function strcmp
{
	str1="$1"; 	str2="$2"
	l1=${#str1};	l2=${#str2}
	IFS=""
	i=0
	ch1=${str1:$i:1};ch2=${str2:$i:1}

	a=`printf "%d" \'$ch1`
	b=`printf "%d" \'$ch2`

	while [ $a -eq $b ]
	do
		i=`echo $i + 1 | bc`
		ch1=${str1:$i:1}; ch2=${str2:$i:1}
		a=`printf "%d" \'$ch1`
		b=`printf "%d" \'$ch2`

		if [ "$i" -eq "$l1" ] || [ "$i" -eq "$l2" ]
		then
			break
		fi
	done


	echo "$a-$b" | bc

}

function strstr
{
	IFS=""

	str1="$1"
	str2="$2"

	echo "$str1" | grep -bo "$str2" | cut -d ":" -f 1 | head -1
	if [ $? -ne 0 ]
	then
		echo -1
	fi
}

function strtok
{

	str1="$1"
	str2="$2"

	if [ ! -n "$str1" ]
	then
		str1=$buffer
	else
		buffer=$str1
	fi
	v=`echo "$str1" | sed "s:[$str2]:\n:g" | grep -v "^$" | sed -n "1 p"`
	echo $v

	export buffer=`echo "$str1" | sed -n "s:\([$str2]$v[$str2]\)\|\(^$v[$str2]\)::p"`

}

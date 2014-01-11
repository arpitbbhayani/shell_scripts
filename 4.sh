#!/bin/bash

areallnumbers() 
{
	echo "$1" | grep -qE "^\-?[0-9]?\.?[0-9]+$";
	num1=$?
	echo "$2" | grep -qE "^\-?[0-9]?\.?[0-9]+$";
	num2=$?
	echo "$3" | grep -qE "^\-?[0-9]?\.?[0-9]+$";
	num3=$?

	if [ $num1 -ne 0 ] || [ $num2 -ne 0 ] || [ $num3 -ne 0 ]
	then
		echo 'Error: Input not a number'
		exit 1
	fi

	return 0

}

if [ $# -ne 3 ]
then
	echo 'Error: Invalid Number of Arguments!'
	exit 1
fi

a=$1; b=$2; c=$3
areallnumbers $a $b $c

D=`echo "scale=5;$b * $b - 4 * $a * $c" | bc`
COMP=`echo "$D < 0" | bc`
if [ $COMP -eq "1" ]
then
	echo 'No Solutions were found'
else
	root=`echo "scale=5;(-1 * $b + sqrt($D)) / (2 * $a )" | bc`
	echo -n $root
	root=`echo "scale=5;(-1 * $b - sqrt($D)) / (2 * $a )" | bc`
	echo ,$root
fi


#!/bin/bash

if [ $# -ne 1 ]
then
	echo 'Error: Invalid File!'
	exit 1;
fi

file_in="$1"
old_IFS=$IFS
IFS=$'\n'

if [ -f "PasswordTest" ]
then
	rm PasswordTest
fi

for line in $(cat $file_in)
do
	length=${#line}

	if [ $length -lt 8 ]
	then
		echo "WEAK" >> PasswordTest
		continue
	fi

	echo "$line" | grep -Eq "[0-9]"

	if [ $? -eq 0 ]
	then
		echo "$line" | grep -Eq "[-$+*=&%#@]"

		if [ $? -eq 0 ]
		then
			len=${#line}
			len=`echo $len - 4 | bc`
			if [ $len -le 0 ]
			then
				echo "STRONG" >> PasswordTest
			fi
			i=0
			flag=1
			while [ $i -lt $len ]
			do
				str=${line:$i:4}
				grep -Eq "^$str$" /usr/share/dict/words
				if [ $? -eq 0 ]
				then
					flag=0
					break;
				fi

				i=`echo $i + 1 | bc`
			done

			if [ $flag -eq 1 ]
			then
				echo "STRONG" >> PasswordTest
			else
				echo "WEAK" >> PasswordTest
			fi

		else
			echo "WEAK" >> PasswordTest
			continue
		fi


	else
		echo "WEAK" >> PasswordTest
		continue
	fi


done          

IFS=$old_IFS

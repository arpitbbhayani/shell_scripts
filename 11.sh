#!/bin/bash

IP_FILE="$1"

if [ ! -f "$IP_FILE" ]
then
	echo 'Error: Invalid File!'
	exit 1;
fi

OP_FILE="CopyGroups"

if [ -f "$OP_FILE" ]
then
	rm "$OP_FILE"
fi

num_row=0

declare -A array

function add_in_array
{
	roll_nums="$1"
	i=0
	flag="notfound"

	#echo "Adding : " $roll_nums

	while [ $i -lt $num_row ]
	do
		#echo i = $i and num_row = $num_row
		#array[$i]="${array[$i]} $1"

		content=${array[$i]}
		entry1=`echo $roll_nums | cut -d " " -f 1`

		echo $content | grep -qE "$entry1"

		if [ $? -eq 0 ]
		then
			# First roll number found

			#Checking for second

			#echo $entry1 : 1 found

			entry2=`echo $roll_nums | cut -d " " -f 2`
			echo $content | grep -qE "$entry2"

			if [ $? -eq 0 ]
			then
				# Second roll number found
				# do nothing
				#echo $entry2 : 2 found
				flag="found"
			else
				# Add second
				#echo $entry2 : 2 not found
				array[$i]="${array[$i]} $entry2"
				flag="found"
			fi
		else
			# First is not present

			entry2=`echo $roll_nums | cut -d " " -f 2`
			echo $content | grep -qE "$entry2"

			if [ $? -eq 0 ]
			then
				# Second roll number found
				# Add first
				#echo $entry1 : 1 not found
				array[$i]="${array[$i]} $entry1"
				flag="found"
			fi
		fi

		i=`echo $i + 1 | bc`
	done

	if [ $flag == "notfound" ]
	then
		#echo "BOTH_NOT_FOUND so adding @ i = $i"
		array[$i]="$roll_nums"
		num_row=`echo $num_row + 1 | bc`
	fi


}

function print_array
{
	i=0
	while [ $i -lt $num_row ]
	do
		#echo ${array[$i]} >> $OP_FILE
		#sorted=$(printf "%s\n" ${array[$i]} | sort -n)
		#echo $sorted
		v=`sort -n <<< "${array[$i]// /$'\n'}"`
		echo $v >> $OP_FILE
		#echo "END"
		i=`echo $i + 1 | bc`
	done
}

IFS=$'\n'

cat "$IP_FILE" | sort -n > ABC

for line in $(cat "$IP_FILE")
do
	#li=`echo $line | tr " " "\n" | sort -n`
	#echo li = $li
	add_in_array $line
	#echo $line
done
print_array

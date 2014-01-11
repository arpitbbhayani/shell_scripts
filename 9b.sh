#!/bin/bash

if [ $# -ne 2 ]
then
	echo 'Error: Invalid Number of Arguments!'
	exit 1
fi

. ./9a.sh

IFS=""

s1="$1"
s2="$2"

strcmp "$s1" "$s2"
strlen "$s1"
strlen "$s2"
strcat "$s1" "$s2"
strtok "$s1" "$s2"
strstr "$s1" "$s2"

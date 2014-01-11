#!/bin/bash

OLDIFS=$IFS
IFS=""

function delete_file
{
	local file_name_gz=""
	local file_name="$1"
	local file_type=`file -b $file_name | cut -d " " -f 1`
	if [ $file_type == "gzip" ]
	then
		file_name_gz="$file_name"
	else
		gzip "$file_name"
		file_name_gz="$file_name".gz
	fi
	mv $file_name_gz ~/TRASH
}

function delete_dir
{

	return

	#local dir_name="$1"
	#local old_dir=`pwd`
	#cd "$dir_name"
	#for i in *
	#do
	#	if [ -f "$i" ]
	#	then
	#		delete_file $i
	#	fi
	#	if [ -d "$i" ]
	#	then
	#		delete_dir $i
	#	fi
	#done
	#cd $old_dir

}

if [ ! -e ~/TRASH ]
then
	mkdir ~/TRASH
fi

while [ "$1" ]
do
	file_name="$1"
	if [ ! -f "$file_name" ] && [ ! -d "$file_name" ]
	then
		echo 'Error: Invalid File/Directory!'
	else
		if [ -f "$file_name" ]
		then
			delete_file "$file_name"
		fi

		if [ -d "$file_name" ]
		then

			OLD_IFS=$IFS
			IFS=""
			dir_name="$file_name"
			length=`expr ${#dir_name} - 1`
			last_char=${dir_name:$length:1}
			if [ $last_char == "/" ]
			then
				length=`expr ${#dir_name} - 1`
        			dir_name=${dir_name:0:$length}
			fi
			
			tar -zcf "$dir_name".tar.gz "$dir_name"
			mv "$dir_name.tar.gz" ~/TRASH
			rm -rf "$dir_name"
			IFS=$OLD_IFS

			#delete_dir "$file_name"
		fi

	fi

	shift
done

IFS=$OLDIFS

for i in `find ~/TRASH -mtime 2`
do
	rm $i
done

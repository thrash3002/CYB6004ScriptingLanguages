#!/bin/bash

if (( $#>=1 )); then
	content=$( cat $1 )
	for ln in $content
	do
		if (( ${#ln} > 0 )); then
			if [ -d $ln ]; then
				echo "$ln - That's a directory"
			elif [ -f $ln ]; then
				echo "$ln - That file exists"
			else
				echo "$ln - I don't know what that is!"
			fi
		fi
	done
else
	echo "no arg no action"
fi

exit 0

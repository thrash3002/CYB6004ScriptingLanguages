#!/bin/bash

#run passwordCheck.sh
./passwordCheck.sh

# check that password check succeeded
if [ $? -eq 0 ] ; then
	echo "Enter the number corresponding to the menu action you would like to perform:"
	echo "1. Create a folder"
	echo "2. Copy a folder"
	echo "3. Set a password"
	read -p ">" cmd
	case "$cmd" in
		1)
			# create a folder
			./foldermaker.sh
			;;
		2)	# copy a folder
			./foldercopier.sh
			;;
		3)	# set a new password
			./setPassword.sh
			;;
		*)	echo "you have not chosen from the list"
			;;
	esac
fi
exit 0

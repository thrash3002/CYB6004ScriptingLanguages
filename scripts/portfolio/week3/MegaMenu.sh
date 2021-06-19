#!/bin/bash

### MegaMenu.sh
### - call another script within a script
### - use 'case' conditional
### - use '*)' for default case in 'case' conditional


#run passwordCheck.sh
./passwordCheck.sh

# check that password check succeeded
if [ $? -eq 0 ] ; then
	echo "Enter the number corresponding to the menu action you would like to perform:"
	echo "1. Create a folder"
	echo "2. Copy a folder"
	echo "3. Set a password"
	echo "4. Calculator"
	echo "5. Create Week Folders"
	echo "6. Check Filenames"
	echo "7. Download a File"
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
		4)	# calculator
			./bashCalc.sh
			;;
		5)	# create week folders
			read -p "enter the two arguments required: " weeks
			./megafoldermaker.sh weeks
			;;
		*)	echo "you have not chosen from the list"
			;;
	esac
fi
exit 0

#!/bin/bash

### MegaMenu.sh
### - call another script within a script and pass arguments
### - use 'case' conditional
### - use '*)' for default case in 'case' conditional

#run passwordCheck.sh
./passwordCheck.sh

# check that password check succeeded
if [ $? -eq 0 ] ; then
	cmd=10
	until [ $cmd == 8 ]
	do
		echo "Enter the number corresponding to the menu action you would like to perform:"
		echo "1. Create a folder"
		echo "2. Copy a folder"
		echo "3. Set a password"
		echo "4. Calculator"
		echo "5. Create Week Folders"
		echo "6. Check Filenames"
		echo "7. Download a File"
		echo "8. Exit"
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
				read -p "enter the starting and ending week numbers separated by a space: " weeks
				./megafoldermaker.sh $weeks
				;;
			6)	# check filenames
				read -p "enter the file containing the names: " filename
				./filenames.sh $filename
				;;
			7)	# download a file
				./InternetDownloader.sh
				;;
			8)	# exit
				# do nothing - the 'until' loop will take care of it
				;;
			*)	echo "you have not chosen from the list"
				;;
		esac
	done
fi
exit 0

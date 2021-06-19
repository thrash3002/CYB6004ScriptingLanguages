#!/bin/bash

### MegaMenu.sh
### - call another script within a script and pass arguments
### - use 'case' conditional
### - use '*)' for default case in 'case' conditional
### - a basic command history implementation
### - convert a string into an array of words - 'weekargs=($weeks)'

#run passwordCheck.sh
./passwordCheck.sh

purpTxt='\033[1;35m'
blueTxt='\033[0;34m'
cyanTxt='\033[0;36m'
noCol='\033[0m'

# adding the ability to view history because I thought it'd be cool
# won't be super complex due to time constraints
# ideally would be good to be able to also capture inputs to the 
#	scripts being called, but I'll leave that for later
historyFile=".megaMenuHistory"

# check that password check succeeded
if [ $? -eq 0 ] ; then
	cmd=10
	until [ $cmd == 8 ]
	do
		echo -e "${blueTxt}Enter the number corresponding to the menu action you would like to perform:"
		echo -e "${cyanTxt}1. Create a folder"
		echo "2. Copy a folder"
		echo "3. Set a password"
		echo "4. Calculator"
		echo "5. Create Week Folders"
		echo "6. Check Filenames"
		echo -e "7. Download a File${noCol}"
		echo -e "${purpTxt}8. View command history${noCol}"
		echo "9. Exit"
		read -p ">" cmd
		case "$cmd" in
			1)	# create a folder
				echo "1. Create a folder" >> $historyFile
				./foldermaker.sh
				;;
			2)	# copy a folder
				echo "2. Copy a folder" >> $historyFile
				./foldercopier.sh
				;;
			3)	# set a new password
				echo "3. Set a password" >> $historyFile
				./setPassword.sh
				;;
			4)	# calculator
				echo "4. Calculator" >> $historyFile
				./bashCalc.sh
				;;
			5)	# create week folders
				read -p "enter the starting and ending week numbers separated by a space: " weeks
				weekArgs=($weeks)
				#TODO - sanitize input
				#	- check that both inputs are numbers
				#	- check that first number is lower than second number
				echo "5. Create Week folders for weeks ${weekArgs[0]} to ${weekArgs[1]}" >> $historyFile
				./megafoldermaker.sh $weeks
				;;
			6)	# check filenames
				read -p "enter the file containing the names: " filename
				echo "6. Check filenames in $filename" >> $historyFile
				./filenames.sh $filename
				;;
			7)	# download a file
				echo "7. Download a file" >> $historyFile
				./InternetDownloader.sh
				;;
			8)	# history
				cat $historyFile
				echo "8. View command history" >> $historyFile
				;;
			9)	# exit
				echo "9. Exit" >> $historyFile
				# do nothing - the 'until' loop will take care of it
				;;
			*)	echo "you have not chosen from the list"
				echo "Unknown option: $cmd" >> $historyFile
				;;
		esac
	done
fi
exit 0

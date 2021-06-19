#!/bin/bash

### InternetDownloader.sh
### - use basename to get the filename from a url
### - use wget to download a file into a specific directory
### - use until loop to look for exit command or keep looking through commands
### - generate a timestamp

read -p "Please type the URL of a file to download or type 'exit' to quit: " url

until [ $url == "exit" ]
do
	read -p "Please type the location to which the file should be saved: " loc
	wget -q -P $loc $url
	if [ $? -eq 0 ]; then # download success
		timestamp=$(date +"%Y-%m-%d %T")
		filename=$(basename $url)
		echo "$timestamp URL:$url -> $loc/$filename"
	fi
#	locExists=0
#	if [ -d $loc ]; then
#		echo "$loc is a directory"
#		locExists=1
#	else
#		read -p "Location does not exist. would you like to create? [y/n]" createLoc
#		if [ $createLoc == "y" ]; then
#			mkdir -p $loc
#			if [ $? -eq 0 ]; then # directory creation succesful.
#				locExists=1
#			fi
#		fi
#	fi
#	if [ $locExists==1 ]; then # Proceed with download
		
#	else
#		echo "Download request cancelled"
#	fi
	# next loop
	read -p "Please type the URL of a file to download or type 'exit' to quit: " url
done
exit 0

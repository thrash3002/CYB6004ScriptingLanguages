#!/bin/bash

### foldercopier.sh
### - use 'if' conditional along with 'else'
### - use '[' test directive with 'if'
### - use '-d' test to check that a variable is a directory

read -p "enter the name of the folder you would like to copy: " folderName

#if the name is a valid directory

if [ -d "$folderName" ]; then

	#copy it to a new location

	read -p "enter the name of the destination folder: " newFolderName

	cp -r "$folderName" "$newFolderName"

# else print an error

else

	echo "That folder could not be found"

fi

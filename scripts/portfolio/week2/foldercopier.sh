#!/bin/bash

read -p "enter the name of the folder you would like to copy: " folderName

#if the name is a valid directory

if [ -d "$folderName" ]; then

	#copy it to a new location

	read -p "enter the name of the destination folder: " newFolderName

	cp -r "$folderName" "$newFolderName"

# else print an errory

else

	echo "That folder could not be found"

fi

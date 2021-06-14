#!/bin/bash

### foldermaker.sh
### - prompt basic user input
### - enter user input into a variable
### - use a variable

read -p "type the name of the folder you would like to create:" folderName
mkdir "$folderName"

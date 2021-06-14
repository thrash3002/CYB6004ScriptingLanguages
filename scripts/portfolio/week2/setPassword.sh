#!/bin/bash

### setPassword.sh
### - prompt user for hidden input using read -s
### - pipe a variable into a script
### - use sha256sum to input a hash into a file

read -p 'folder name:' folder
read -sp 'password:' password
mkdir $folder
cd $folder
echo $password | sha256sum > secret.txt


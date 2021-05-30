#!/bin/bash

read -p 'folder name:' folder
read -sp 'password:' password
mkdir $folder
cd $folder
echo $password | sha256sum > secret.txt


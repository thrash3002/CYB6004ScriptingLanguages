#!/bin/bash

# Download main page
debug "Downloading data.."
mainPage="https://linuxsecurity.expert/security-tools/top-100"
# -L flag is necessary because otherwise curl jst saves the http301 redirect page
data=$(curl -s -L $mainPage)
if [ $? -eq 0 ]; then # download success
	echo "$data"
	exit 0
fi
exit 1

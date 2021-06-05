#!/bin/bash

# prompt user to enter in password
# -s flag for silent entry
read -sp "Please enter in your password: " pwd

#compare hash of password offered to that of the one kept in the secret.txt file
echo $pwd | sha256sum -c --status secret.txt

#store the  exit status of the previous line in the result  variable
result=$?

#new line
echo

#set the return code to default to 1 - i.e. something has gone wrong
exitCode=1

#if the password hashes match, print "Access Granted" and change the exit code to success
if [ 0 -eq $result ]; then
	echo "Access Granted"
	exitCode=0
else
	#  authentication failed
	echo "Access Denied"
fi

exit $exitCode

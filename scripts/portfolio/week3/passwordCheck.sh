#!/bin/bash

### passwordCheck.sh
### - pipe a variable to sha256sum to compare to a stored hash
### - query exit status of previous line from $?
### - use '-eq' test within 'if' conditional
### - return an exit code

redTxt='\033[0;31m'
grnTxt='\033[0;32m'
ltRdTxt='\033[1;31m'
noCol='\033[0m'

# prompt user to enter in password
# -s flag for silent entry
read -sp "$(echo -e ${ltRdTxt}Enter Password: ${noCol})" pwd

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
	echo -e "${grnTxt}Access Granted${noCol}"
	exitCode=0
else
	#  authentication failed
	echo -e "${redTxt}Access Denied${noCol}"
fi

exit $exitCode

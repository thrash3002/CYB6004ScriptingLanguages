#!/bin/bash

### UserAccounts.sh
### - use of awk functions, including returns
### - use of awk variables
### - use of awk field separator FS inbuilt function
### - use of awk output record separator ORS inbuilt function
###	to allow multiple print calls to print on the same line
### - use of * within printf to specify a variable length
#	reference: https://stackoverflow.com/questions/25407549/using-variables-in-printf-format
### - use of NR==FNR condition in awk, along with next command and running 
###	through the same file twice to perform pre-processing steps
###	(note that this has been commented out but left for reference)
#	reference: https://stackoverflow.com/questions/28544105/awk-go-through-the-file-twice-doing-different-tasks
### - reading awk output into bash variables
#	reference: https://stackoverflow.com/questions/14505026/set-variable-in-current-shell-from-awk

# pre-process file to extract column widths
read usernameColWidth userIDColWidth groupIDColWidth homeColWidth shellColWidth <<< $(awk -F: '
BEGIN {
	# initialise column widths to the column titles
	usernameColWidth=length("Username")
	userIDColWidth=length("UserID")
	groupIDColWidth=length("GroupID")
	homeColWidth=length("Home")
	shellColWidth=length("Shell")
}
{
	# update each width to the longest width
        if(length($1) > usernameColWidth) {
                usernameColWidth=length($1)
        }
	if(length($3) > userIDColWidth) {
		userIDColWidth=length($3)
	}
	if(length($4) > groupIDColWidth) {
		groupIDColWidth=length($4)
	}
	if(length($6) > homeColWidth) {
		homeColWidth=length($6)
	}
	if(length($7) > shellColWidth) {
		shellColWidth=length($7)
	}
}
END {
	print usernameColWidth" "userIDColWidth" "groupIDColWidth" "homeColWidth" "shellColWidth
}' /etc/passwd)

# the first line passing in variables with -v is a bit too long
# but i haven't looked for a way to spread this over multiple lines.. yet..
awk -v usernameColWidth=$usernameColWidth -v userIDColWidth=$userIDColWidth -v groupIDColWidth=$groupIDColWidth -v homeColWidth=$homeColWidth -v shellColWidth=$shellColWidth '
#ideally these functions could be in a separate file
function ColumnSeparator() {
	print "|"
}
function NoColour() {
	print "\033[0m"
}
function UserColour() {
	return "\033[33m"
}
function DetailColour() {
	return "\033[35m"
}
# the above functions could just be variables
# but I have left them as functions with returns
# for my own reference

function PrintfSection(string, len, colour) {
	ColumnSeparator()
	print colour
	printf(" %*s ", len, string)
	NoColour()
}

function PrintTitleDivider(len) {
	ColumnSeparator()
	# add 2 to length to cater to leading and trailing space
	for(i=0; i<len+2; i++) {
		print "_"
	}
}

# this is no longer in use, but have left this in as a learning exercise for myself
#NR==FNR {
#        if(length($1) > usernameColWidth) {
#                usernameColWidth=length($1)
#        }
#        next
#}

BEGIN {
	FS=":";
	titleColour="\033[34m"

	# left align things
	usernameColWidth=usernameColWidth*-1
	userIDColWidth=userIDColWidth*-1
	groupIDColWidth=groupIDColWidth*-1
	homeColWidth=homeColWidth*-1
	shellColWidth=shellColWidth*-1

	# print everything on the same line
	ORS=""

	PrintfSection("Username", usernameColWidth, titleColour)
	PrintfSection("UserID"  , userIDColWidth  , titleColour)
	PrintfSection("GroupID" , groupIDColWidth , titleColour)
	PrintfSection("Home"    , homeColWidth    , titleColour)
	PrintfSection("Shell"   , shellColWidth   , titleColour)
	ORS="\n"
	ColumnSeparator()

	# the following need positive numbers again
	ORS=""
	PrintTitleDivider(usernameColWidth*-1)
	PrintTitleDivider(userIDColWidth*-1)
	PrintTitleDivider(groupIDColWidth*-1)
	PrintTitleDivider(homeColWidth*-1)
	PrintTitleDivider(shellColWidth*-1)
	ORS="\n"
	ColumnSeparator()
}
{
	ORS=""
	PrintfSection($1, usernameColWidth, UserColour())   # Username
	PrintfSection($3, userIDColWidth  , DetailColour()) # UserID
	PrintfSection($4, groupIDColWidth , DetailColour()) # GroupID
	PrintfSection($6, homeColWidth    , DetailColour()) # Home
	PrintfSection($7, shellColWidth   , DetailColour()) # Shell
	ORS="\n"
	ColumnSeparator()
}' /etc/passwd #/etc/passwd

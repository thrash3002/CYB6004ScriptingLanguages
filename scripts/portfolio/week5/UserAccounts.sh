#!/bin/bash

### UserAccounts.sh
### - use of awk functions, including returns
### - use of awk variables
### - use of awk field separator FS inbuilt function
### - use of awk output record separator ORS inbuilt function
###	to allow multiple print calls to print on the same line

awk '
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
function PrintSection(string, colour) {
	ColumnSeparator()
	print colour
	print string
	NoColour()
}

BEGIN {
	FS=":";
	titleColour="\033[34m"
	print "________________________________";
	ORS=""
	PrintSection(" Username ", titleColour)
	PrintSection(" UserID "  , titleColour)
	PrintSection(" GroupID " , titleColour)
	PrintSection(" Home "    , titleColour)
	PrintSection(" Shell "   , titleColour)
	ORS="\n"
	ColumnSeparator()
}
{
	ORS=""
	PrintSection($1, UserColour())   # Username
	PrintSection($3, DetailColour()) # UserID
	PrintSection($4, DetailColour()) # GroupID
	PrintSection($6, DetailColour()) # Home
	PrintSection($7, DetailColour()) # Shell
	ORS="\n"
	ColumnSeparator()
	#printf("| \033[33m%-11s\033[0m | \033[35m%-14s\033[0m |\n", $1, $2);
}
END {
	print("________________________________");
}' /etc/passwd

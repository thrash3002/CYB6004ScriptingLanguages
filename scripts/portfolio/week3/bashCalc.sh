#!/bin/bash

#colours of operations
additionCol='\033[0;34m'
subtractCol='\033[0;32m'
multiplyCol='\033[0;31m'
divisionCol='\033[0;35m'
noCol='\033[0m'

#TODO bodmas stack

read -p "What is your arithmetic operation? " request

#echo "$request" | grep -q [+]
#if test $? -eq 0 ; then
	#echo "$request" | grep -b -o + | awk 'BEGIN {FS=":"}{print $1}'>operandIndex
	#first=${request:0:operandIndex}
	#second=${request:operandIndex+1}
	#echo $operandIndex
	#echo $first
	#echo $second
	#echo $first + $second
#fi

result=$(echo "$request" | bc)
intResult=$(echo "$result / 1" | bc)

echo "$request" | grep -q +
if test $? -eq 0 ; then
	echo -e "${additionCol}$result${noCol}"
	exit 0
fi

echo "$request" | grep -q -
if test $? -eq 0 ; then
	echo -e "${subtractCol}$result${noCol}"
	exit 0
fi

echo "$request" | grep -q [*]
if test $? -eq 0 ; then
	echo -e "${multiplyCol}$result${noCol}"
	exit 0
fi

echo "$request" | grep -q /
if test $? -eq 0 ; then
	echo -e "${divisionCol}$result${noCol}"
	exit 0
fi

echo "Operation failed"

exit 1

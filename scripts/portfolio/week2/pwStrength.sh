#!/bin/bash

### pwStrength.sh
### - use read without text prompt on the same line
### - use '${#}' to obtain the  length of a variable
### - use 'test' instead of '[' with 'if conditional
### - pipe a variable into grep with a range
### - use grep in quiet mode
### - use nested 'if' conditionals

echo "enter the password"
read pw
len="${#pw}"

if test $len -ge 8 ; then
	echo "$pw" | grep -q [0-9]
	if test $? -eq 0 ; then
		echo "$pw" | grep -q [A-Z]
		if test $? -eq 0 ; then
			echo "$pw" | grep -q [a-z]
			if test $? -eq 0 ; then
				echo "$pw" | grep -q [$@#%]
				if test $? -eq 0 ; then
					echo "Strong password"
				else
					echo "Weak password include special chars"
				fi
			else
				echo "Weak password include lower case char"
			fi
		else
			echo "Weak password include capital char"
		fi
	else
		echo "Weak password include numbers"
	fi
else
	echo "Password length should be greater than or equal to 8"
fi

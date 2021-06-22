#!/bin/bash

rm -f sedStatements.txt
rm -f linesStartingWithm.txt
rm -f linesWith3Digits.txt
rm -f echoWith3OrMoreWords.txt
rm -f goodPasswords.txt

cd ..

# all sed statements
# not using the '-' at the end matches words like 'used' and 'rebased'
# all sed statements used so far include an option, so the '-' is
# sufficient.  Regex not needed - just a literal match
grep -r -s "sed -" > ./week4/sedStatements.txt

# all lines that start with the letter m
grep -r -s -E "^m" >./week4/linesStartingWithm.txt

# all lines that contain 3 digit numbers
grep -r -s -E "\d\d\d" > ./week4/linesWith3Digits.txt

# all echo statements with at least 3 words
# echo will always have a space after it, and then.* to match anything
# both before and after the 3 words
grep -r -s -E "echo .*\b[A-Za-z].*? \b[A-Za-z].*? \b[A-Za-z].*?.*" > ./week4/echoWith3OrMoreWords.txt

# all lines that would make a good password
# should have at least 
	# 1 number
	# 1 upper case
	# 1 lower case
	# 8 characters in length
	# no whitespace
# note that while this criteria is still commonly accepted,
# it is no longer considered a sufficiently strong password
# in cyber security.
# useful information found at:
# https://stackoverflow.com/questions/4213453/bash-regex-for-strong-password
# more rules could be added, such as excluding dots and quotes.
grep -r -s -P '(?=(.*[0-9]))(?=(.*[A-Z]))(?=(.*[a-z]))(?!(.* ))(?!(.*\t))^.{8,}$' > ./week4/goodPasswords.txt

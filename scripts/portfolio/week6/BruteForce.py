#!/usr/bin/python3.9

import time
import hashlib
from itertools import product
# the above was learned from https://stackoverflow.com/questions/11367553/brute-force-script-in-python-3-2

#hidden password hash

passwordHash = "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824"

characterList="abcdefghijklmnopqrstuvwxyz0123456789" # all the different characters to try

sha256hash = lambda txt: hashlib.sha256(txt.encode("utf-8")).hexdigest()

# start timer
startTime = round(time.time() * 1000) # to get milliseconds

print("Starting brute force attempt..")
# try up to 15 characters in length
passwordFound = 0
for length in range(1, 16):
	print(f"trying passwords of length {length}")
	tuples = product(characterList, repeat=length)
	for tuple in tuples:
		word = "".join(tuple)
		wordHash = sha256hash(word)
		# WARNING: uncommenting the following line will cause the script to take almost a half hour to run
		#print(f"Trying password {word}:{wordHash}")
		if(wordHash == passwordHash):
			print(f"Password has been cracked! It is {word}")
			passwordFound = 1
			break
	if(passwordFound == 1):
		break
endTime = round(time.time() * 1000)
timeTaken=endTime-startTime
print(f"Brute force time: {timeTaken} milliseconds")

print("confirming with dictionary attack..")
startTime = round(time.time() * 1000)
with open("wordlist.txt", "r") as wordlist:
	#repeart for each word
	for word in wordlist.readlines():
		word = word.rstrip()
		## the word (see what I did there?)
		wordlistHash = sha256hash(word)
		#print(f"Trying password {word}:{wordlistHash}")
		#if the hash is the same as the correct password's hash then we have cracked the password!
		if(wordlistHash == passwordHash):
			print(f"Password is confirmed as {word}")
			break
endTime = round(time.time() * 1000)
timeTaken=endTime-startTime
print(f"Dictionary time: {timeTaken} milliseconds")

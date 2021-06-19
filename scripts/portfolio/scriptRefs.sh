#!/bin/bash

#scriptList=$(tree | grep .sh)
treeJson=$(tree -iJ | jq -r '.[]')
isType=0
isName=0
isDirectory=0
isFile=0
showDir=0

for ln in $treeJson
do
	if [ 1 -eq $isName ]; then # if this line is a name
		if [ 1 -eq $isDirectory ]; then
			ln="${ln%,}"	# remove trailing comma
			ln="${ln%\"}"	# remove trailing quote
			ln="${ln#\"}"	# remove leading quote
			cd $ln
			echo $ln | grep -q 'week'
			if [ $? -eq 0 ]; then
				showDir=1
				dir=$ln
			fi
		elif [ 1 -eq $isFile ]; then
			ln="${ln%\"}"	# remove trailing quote
			ln="${ln#\"}"	# remove leading quote
			if [[ $ln == *".sh" ]]; then
				if (( $#==1 )); then # an arg has been passed.  only find files relating to this arg
					cat $ln | grep '###' | grep -v 'cat $ln | grep' | grep -q $1
					if [ $? -eq 0 ]; then
						if [ 1 -eq $showDir ]; then # show the directory on the first entry
							echo "$dir:"
							echo
							showDir=0
							dir=""
						fi
						cat $ln | grep '###' | grep -v 'cat $ln | grep'
						echo
					fi
				else
					if [ 1 -eq $showDir ]; then # show the directory name on the first entry
						echo "$dir:"
						echo
						showDir=0
						dir=""
					fi
					# output the description comment lines of the 
					# script and ignore this line itself 
					cat $ln | grep '###' | grep -v 'cat $ln | grep'
					if [ $? -eq 0 ]; then
						echo # break up the output with spaces
							# but only if the previous line
							# output something
					fi
				fi
			# else file is not a script
			fi
		fi
		#reset
		isDirectory=0
		isFile=0
		isName=0
	elif [ "\"name\":" = $ln ]; then # next line is the name
		isName=1
	elif [ 1 -eq $isType ]; then # if this line is a type
		if [ "\"directory\"," = $ln ]; then
			isDirectory=1
		elif [ "\"file\"," = $ln ]; then
			isFile=1
		# else we're not interested
		fi
		isType=0
	elif [ "\"type\":" = $ln ]; then # next line is a type
		isType=1
	elif [[ $ln == *"]" ]]; then # end of a directory
		cd ..
	# else ignore the line
	fi
done

exit 0

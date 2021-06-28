#!/bin/bash
source "./parameterFunctions.sh"

handleParams $*

# if we get to this point after handleParams, --help has not been specified
debug "help not requested.  proceeding"

cyanTxt='\033[0;36m'
redTxt='\033[1;31m'
grnTxt='\033[1;32m'
blueTxt='\033[1;34m'
noCol='\033[0m'

# Download main page
data=$(./downloadMainPage.sh)

if [ $? -eq 0 ]; then # download success

	# Parse main page
		debug "Main page downloaded.  Parsing.."
		regex='<div class="box box-100.*</a></div></div></div></div>'
		data=$(echo $data | grep -o -E "$regex")
		if [ $debug -eq 1 ]; then
			data=$(echo $data | ./parser.py -d)
		else
			data=$(echo $data | ./parser.py)
		fi
	# Parse main page complete

	# Convert parsed data from a single string into an array
		# reference: https://stackoverflow.com/questions/24628076/convert-multiline-string-to-array
		debug "Converting from single string to array"
		SAVEIFS=$IFS
		IFS=$'\n'
		dataArray=($data)
		IFS=$SAVEIFS
	# Convert parsed data from a single string into an array complete

	# Pad main page to align data
		debug "Padding entries that have not changed rank"
		# if an entry has not moved in ranking, add 0 to the first column of data
		index=0
		for dataLine in "${dataArray[@]}"
		do
			echo "$dataLine" | grep -q -E "^debug:"
			if [ $? -ne 0 ]; then # this is not a debug line
				# the following line will require more work - sed does not do lookahead.  more research required
				#dataArray[$index]=$(echo "$dataLine" | sed 's/(?!▾)(?!▴)/0^&/')
				echo "$dataLine" | grep -q "▴" # &#9662;
				if [ $? -ne 0 ]; then # value NOT found
					echo "$dataLine" | grep -q "▾" # &#9652;
					if [ $? -ne 0 ]; then # value NOT found
						debug "Found entry with no rank change"
						debug $dataLine
						dataArray[$index]="0^$dataLine"
					fi
				fi
			fi
			index=$(($index + 1))
		done

		debug "Padding entries that do not have 'Main Uses' information"
		# count the number of '^' separators in each line, and if the number is low, then chances are low, then the "Main Uses" section needs to be padded
		index=0
		for dataLine in "${dataArray[@]}"
		do
			echo "$dataLine" | grep -q -E ".*\^.*\^.*\^.*\^.*\^.*\^.*\^.*"
			if [ $? -ne 0 ]; then # this does not have the required number of caret separators
				#separate string out into array
				SAVEIFS=$IFS
				IFS=$'^'
				columns=($dataLine)
				IFS=$SAVEIFS

				#rejoin string with added caret
				mainUsesPosition=5
				rejoined=${columns[0]}
				for ((columnIndex = 1; columnIndex < $mainUsesPosition; columnIndex++))
				do
					rejoined="$rejoined^${columns[$columnIndex]}"
				done
				rejoined="$rejoined"+"^"
				for ((restIndex = $mainUsesPosition; restIndex < ${#columns[@]}; restIndex++))
				do
					rejoined="$rejoined^${columns[$restIndex]}"
				done
				dataArray[$index]="$rejoined"
			fi
			index=$(($index + 1))
		done
	# Pad main page to align data complete
	if [ $filterOn -eq 1 ]; then # use the filter string
		for i in "${dataArray[@]}"
		do
			echo $i | sed -n "/$filter/ p"
			#if [ $? -eq 0 ]; then
			#	echo "$line"
			#fi
		done
	elif [ $csv -eq 1 ]; then # output text as csv format
		for i in "${dataArray[@]}"
		do
			echo $i
		done
	else
		#display 10 at a time
		cmd=-1
		startNumToShow=0
		displayData=-1
		quitCommand="q"
		error=""
		until [ $cmd == $quitCommand ]
		do
			clear
			echo -e "${redTxt}$error${noCol}"
			error=""
			echo -e "Enter the ${cyanTxt}number${noCol} of the tool you'd like to view"
			echo -e "or type ${cyanTxt}f${noCol} to go forward"
			echo -e "or type ${cyanTxt}b${noCol} to go back"
			echo -e "or type ${cyanTxt}$quitCommand${noCol} to exit"
			echo
			endNum=$(($startNumToShow + 10))
			if [ $endNum -gt ${#dataArray[@]} ]; then # prevent index array out of bounds
				endNum=$((${#dataArray[@]}))
			fi

			# Will need to split up the data again
			# This process is the ideal candidate for a function..
			SAVEIFS=$IFS
			IFS=$'^'
			i=1
			for (( index = $startNumToShow; index < $endNum; index++ ))
			do
				# would be more efficient to be store this stuff in a 2d array ror similar
				arrayToDisplay=(${dataArray[$index]})
				name="${arrayToDisplay[3]}"
				rank="${arrayToDisplay[1]}"
				echo "$i. $name (Rank $rank)"
				if [ $displayData -eq $i ]; then # show additional info
					rankChange="${arrayToDisplay[0]}"
					link="${arrayToDisplay[2]}"
					description="${arrayToDisplay[6]}"
					echo "$rankChange" | grep -q "▴"
					if [ $? -eq 0 ]; then
						echo -e "\tRank Change: ${grnTxt}$rankChange${noCol}"
					else
						echo "$rankChange" | grep -q "▾"
						if [ $? -eq 0 ]; then
							echo -e "\tRank Change: ${redTxt}$rankChange${noCol}"
						else
							echo -e "\tRank Change: $rankChange"
						fi
					fi
					echo -e "\tDescription: $description"
					echo -e "\tMore information: ${blueTxt}$link${noCol}"
					echo
				fi
				i=$(($i+1))
			done
			IFS=$SAVEIFS

			# obtain user input
			echo
			displayData=-1
			read -p ">" cmd
			#sanitize input at least somewhat
			echo "$cmd" | grep -q -E "^[0-9]*$"
			if [ $? -eq 0 ]; then #cmd is a number
				if [ ${#cmd} -gt 0 ]; then # something was entered
					if [ $cmd -ge $i ]; then # number is larger than list
						error="Invalid Entry"
					else
						displayData=$cmd
					fi
				else
					error="No Command Given"
					cmd=-1 # prevent error in until comparison
				fi
			else
				case "$cmd" in
					f)
						maxAllowed=$(( ${#dataArray[@]}))
						if [ $endNum -ge $maxAllowed ]; then
							error="No more to Show"
						else
							startNumToShow=$(($endNum))
						fi
						;;
					b)
						if [ $startNumToShow -eq 0 ]; then
							error="Already at the start of the list"
						else
							startNumToShow=$(($startNumToShow-10))
							if [ $startNumToShow -lt 0 ]; then
								startNumToShow=0
							fi
						fi
						;;
					q)
						#do nothing - until loop will take care of it
						;;
					*)
						error="Unknown Command"
						;;
				esac
			fi
		done
	fi
else
	echo "Download failed.  exiting"
	exit 1
fi

exit 0

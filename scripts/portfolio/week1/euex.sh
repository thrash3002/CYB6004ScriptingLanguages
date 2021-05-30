#!/bin/bash
apiPath="https://api.exchangerate-api.com/v4/latest/EUR"
fileName="index.html" #output file
Browsers="google-chrome firefox"
delay=1s

# create browser object
#if $Browsers
#then
#google-chrome $fileName&
#else
#firefox $filename&
#fi

#parse API data
while :;
do
echo "Obtaining exchange information..."
JSON=$(curl -s $apiPath)
GBP=$(echo $JSON | jq -r '.rates.GBP')
AUD=$(echo $JSON | jq -r '.rates.AUD')
USD=$(echo $JSON | jq -r '.rates.USD')
echo "One Euro = $GBP british pounds"
echo "One Euro = $USD US dollars"
echo "One Euro = $AUD Australian dollars"
TIME="10"
while [ $TIME -gt 0 ]
do
echo "                            "
tput cuu1
echo "Next update in $TIME seconds"
sleep $delay
tput cuu1
TIME=$[$TIME-1]
done
tput cuu 4
echo "                                  "
echo "                                  "
echo "                                  "
echo "                                  "
echo "                                  "
tput cuu 5
done

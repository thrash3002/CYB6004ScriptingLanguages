#!/bin/bash

#UV index recommendations:
	#0-2 Low - Minimal protection required
	#3-7 Moderate to high - Standard protection required
	# 8+ Very high to extreme - Full  protective measures required

read -p "Enter the current UV index (between 0 and 11): " uv

if [ "$uv" -le 2 ]; then
	echo "UV is low.  Minimal protection will suffice."
elif [ "$uv" -le 7 ]; then
# video in 2.3.1 shows the use of [[ $uv -ge 3 ]] && [[ "$uv -le 7 ]] here, but testing shows this is not required.  elif behaves as expected
	echo "UV is moderate to high.  Standard protection is needed."
elif [ "$uv" -le 11 ]; then
	echo "UV is very high, maybe even extreme.  Please ensure the use of full protection."
else
	echo "Invalid entry."
fi

#!/bin/bash
#If there aren't two arguments to the script

fruits=("Apple" "Mango" "Strawberry" "Orange" "Banana")

for ((i = 0; i < ${#fruits}; i++))
do
    echo "FRUIT: ${fruits[$i]}"
done
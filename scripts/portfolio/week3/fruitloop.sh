#!/bin/bash

### fruitloop.sh
### - hard initialise an array
### - use a for loop with an array

fruits=("Apple" "Mango" "Strawberry" "Orange" "Banana")

for ((i = 0; i < ${#fruits}; i++))
do
    echo "FRUIT: ${fruits[$i]}"
done

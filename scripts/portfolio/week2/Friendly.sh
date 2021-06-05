#!/bin/bash
echo "please enter your name"

read name

if [ "$name" = "rob" ]; then
    echo "Rob is a very cool name"
else
    echo "Hi $name"
fi
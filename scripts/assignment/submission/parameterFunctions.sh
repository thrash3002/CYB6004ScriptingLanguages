#!/bin/bash

# handling of bash arguments reference:
# https://superuser.com/questions/186272/check-if-any-of-the-parameters-to-a-bash-s>

# set up debugging statement output
debug=0
filterOn=0
filter=""
csv=0

function handleParams () {
        while test $# -gt 0
        do
                case "$1" in
                        --debug)
                                debug=1
                                ;;
                        --help)
                                debug "showing help"
                                echo "$(cat help)"
                                exit 0
                                ;;
			-f)
				filterOn=1
				filter=$2
				debug "filter set to $2"
				shift
				;;
			-c)
				csv=1
				debug "output in csv format"
				;;
                        *)
                                #do nothing
                                ;;
                esac
                shift
        done
}
export -f handleParams

function debug () {
        if [[ $debug == 1 ]]; then
                echo "debug: $1"
        fi
}
export -f debug

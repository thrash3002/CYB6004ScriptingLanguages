#!/bin/bash

### IpInfo.sh
### - use sed with a filter
### - use sed with multiple replacements using curly braces
### - use '-n' option for sed to hide everything except the lines affected
### - use 'p' within sed intput to print the affected line.  Useful when
###   used in conjunction with '-n'

#get info about networking from the ifconfig command
net_info="$(ifconfig)"

#parse out the ip address lines using sed
#filter on 'inet '
#group multiple replacements together in { }
addresses=$(echo "$net_info" | sed -n '/inet / {
s/inet/IP Address:/
s/netmask/\n\t\tSubnet Mask:/
s/broadcast/\n\t\tBroadcastAddress:/
p
}')

#format output

echo -e "IP addresses on this computer are:\n$addresses"

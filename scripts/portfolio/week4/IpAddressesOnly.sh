#!/bin/bash

# originally attempted filtering on 'Ip Address:' instead of 'Ip Address'
# because I thought the first line would not get filtered.
# However, the first line contains 'Ip addresses', not 'Ip Addresses',
# and so the colon within the filter wasn't necessary
./IpInfo.sh | sed -n '/IP Address/ p'

exit 0

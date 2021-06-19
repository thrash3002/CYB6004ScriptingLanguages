#!/bin/bash

ipInfo=$(./IpInfo.sh)

# filtering using 'IpAddress:' rather than 'IP Address' to filter 
# out the first line of output as well
#echo $ipInfo | sed -n '/IP Address:/ p'
echo $ipInfo

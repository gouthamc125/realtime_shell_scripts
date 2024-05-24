#!/bin/bash
#Network connectivity
HOST="czechav.com"
#Output file
output_file="/home/goutham/output.txt"

#Check the host is reachable
if ping -c 1 $HOST > /dev/null
then
	echo "$HOST is reachable" >> output.txt	
else
	echo "$HOST is not reachable" >> output.txt
fi

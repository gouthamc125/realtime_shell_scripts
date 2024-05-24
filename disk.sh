#!/bin/bash
#Disk Usage script
#
THERSHOLD=80
#Check the disk usage and print a warning message
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' |
while read output;
do 
  usage=$(echo $output | awk '{ print $1 }' | cut -d'%' -f1)
  partition=$(echo $partition | awk '{ print $2 }')
  if [ $usage -ge $THERSHOLD ];then
	  echo "Warning: Disk usage on $partition is at ${usage}%"
  fi
done
	  

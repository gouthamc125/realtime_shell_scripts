#!/bin/bash
#create a backup script

SOURCE="/home/goutham/scripts"
DESTINATION="/home/goutham/opt/backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

mkdir -p $DESTINATION/$DATE
cp -r $SOURCE $DESTINATION/$DATE
echo "Backup completed on $DATE"

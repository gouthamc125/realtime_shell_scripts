#!/bin/bash
#Backing up the directory

source_dir="/etc/passwd"

backup_dir="/tmp/backups"

backup_filename="backup_$( date +%Y%m%d_%H%M%S ).tar.gz"

mkdir -p "$backup_dir"

tar -czvf "$backup_dir/$backup_filename" "$source_dir"

if [ $? -eq 0 ]; then
	echo "Backup successful: $backup_filename created in $backup_dir"
else
	echo "Backup has been failed"
fi

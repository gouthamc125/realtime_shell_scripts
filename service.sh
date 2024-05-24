#!/bin/bash
#Check the service
SERVICE="nginx"
if systemctl is-active --quiet  $SERVICE; then
	echo "$SERVICE is running"
else
	echo "$SERVICE is not running"
	systemctl status $SERVICE
	systemctl restart $SERVICE
fi

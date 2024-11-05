#!/bin/bash
#Automation User Management with Shell Script

#Define Variables
ACTION="$1" #First arguement: create, modify, delete
USERNAME="$2" #Second argument: username

# Function to create a new user
create_user() {
	if [ -z "$USERNAME" ]; then
		echo "Usage: $0 create <username>"
		exit 1
	fi

	useradd -m -s /bin/bash "$USERNAME"
	echo "User $USERNAME created"
}

# Function to modify the user
modify_user() {
	if [ -z "$USERNAME" ]; then
		echo "Usage: $0 modify <username>"
		exit 1
	fi
	usermod -s /bin/bash "$USERNAME"
	echo "User $USERNAME modified"
}

# Function to delete the user
delete_user() {
	if [ -z "$USERNAME" ]; then
		echo "Usage: $0 delete <username>"
		exit 1
	fi
	userdel --remove /bin/bash "$USERNAME"
	echo "User $USERNAME deleted"
}

## Main Script
case "$ACTION" in
    create)
	create_user
	;;
    modify)
	modify_user
	;;
    delete)
	delete_user
	;;
    *)
	echo "Usage: $0 {create|modify|delete} <username>"
	exit 1
esac


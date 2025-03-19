#!/bin/bash

# Create a new EC2 instance when the script is executed with create argument
# Terminate the instance when the script is executed with terminate argument

# Launch in the eu-west-1 region
export AWS_DEFAULT_REGION=eu-west-1
#create a new ec2 instance with amazon linux 2 ami image and t2.micro instance type along with the security group called cicd_sg
if [ "$1" == "create" ]; then
    aws ec2 run-instances --image-id ami-08f9a9c699d2ab3f9 --count 1 --instance-type t2.micro --key-name ireland --security-groups cicd_sg --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=cicd}]'
fi
if [ "$1" == "terminate" ]; then
    # Get the instance id of the instance with the tag Name=cicd
    instance_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=cicd" --query "Reservations[*].Instances[*].InstanceId" --output text)
    # Terminate the instance
    aws ec2 terminate-instances --instance-ids $instance_id
fi

# create a new user called goutham with password goutham and add the user to the sudoers file
if [ "$1" == "create_user" ]; then
    useradd goutham
    echo "goutham:goutham" | chpasswd
    usermod -aG wheel goutham
fi
# Add the user to the sudoers file
if [ "$1" == "add_user_to_sudoers" ]; then
    echo "goutham ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
fi
# Remove the user from the sudoers file
if [ "$1" == "remove_user_from_sudoers" ]; then
    sed -i '/goutham/d' /etc/sudoers
fi

# Get the public IP address of the EC2 instance
instance_ip=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=cicd" --query "Reservations[*].Instances[*].PublicIpAddress" --output text)
echo "The public IP address of the EC2 instance is $instance_ip"



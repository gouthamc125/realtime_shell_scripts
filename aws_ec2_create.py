# Create a new ec2 instance
# Usage: python aws_ec2_create.py with t2.micro instance type and amazon linux 2 image
# Usage: python aws_ec2_create.py t2.micro ami-0c3fd0f5d33134a76
# Use the security group called cicd_sg and keypair called ireland.pem in the default VPC
# Create a new user goutham and password goutham and add to sudoers group
# Get the public IP address of the new instance
# With command line arguments like create and terminate
# Author: Goutham
# Instance type: t2.micro
# Image ID: ami-08f9a9c699d2ab3f9
# region: eu-west-1


import boto3
import sys
import time

# Create a new ec2 instance and region is eu-west-1
def create_instance(ec2, instance_type, image_id):
    instance = ec2.create_instances(
        ImageId=image_id,
        InstanceType=instance_type,
        MinCount=1,
        MaxCount=1,
        SecurityGroups=['cicd_sg'],
        KeyName='ireland.pem',
        UserData='''
            #!/bin/bash
            useradd goutham
            echo "goutham:goutham" | chpasswd
            usermod -aG wheel goutham
        '''
    )[0]
    return instance

# Get the public IP address of the new instance
def get_public_ip(instance):
    instance.wait_until_running()
    instance.load()
    return instance.public_ip_address

# Terminate the ec2 instance
def terminate_instance(instance):
    instance.terminate()
    instance.wait_until_terminated()
    print('Instance terminated')

# Main function
def main():
    # Check the command line arguments
    if len(sys.argv) != 3:
        print('Usage: python aws_ec2_create.py <instance_type> <image_id>')
        sys.exit(1)

    # Get the instance type and image id from the command line arguments
    instance_type = sys.argv[1]
    image_id = sys.argv[2]

    # Create a new ec2 instance
    ec2 = boto3.resource('ec2')
    instance = create_instance(ec2, instance_type, image_id)
    print('Instance created')

    # Get the public IP address of the new instance
    public_ip = get_public_ip(instance)
    print('Public IP address:', public_ip)

    # Terminate the ec2 instance
    terminate_instance(instance)
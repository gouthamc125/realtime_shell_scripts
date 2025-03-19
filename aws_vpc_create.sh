#!/bin/bash

##############
# Description: Create VPC in AWS
# -create VPC
# -create a public subnet
# when you run this script, it will create a VPC and a public subnet in the VPC
# when you run the parameters create-vpc, create-subnet, modify-subnet-attribute, create-tags
# when you run the parameters delete-vpc, delete-subnet, delete-security-group

# - verify if user has awscli installed, user must have awscli installed
# - verify aws cli is configured

# variables
vpc_cidr_block="10.0.0.0/16"
subnet_cidr_block="10.0.1.0/24"
subnet_availability_zone="us-west-1a"
vpc_name="shell_vpc"
subnet_name="shell_subnet-1a"
dns_support="true"
dns_hostnames="true"
security_group_name="shell_sg"
security_group_description="shell_sg_description"
port=22
protocol="tcp"
cidr="0.0.0.0/0"
port_http=80
protocol_http="tcp"
port_https=443  
key_name="ireland.pem"
##############
# verify if aws cli is installed
if ! [ -x "$(command -v aws)" ]; then
  echo 'Error: aws cli is not installed.' >&2
  exit 1
fi

# verify if aws cli is configured
aws sts get-caller-identity
if [ $? -ne 0 ]; then
  echo "Error: aws cli is not configured"
  exit 1
fi

# create vpc
vpc_id=$(aws ec2 create-vpc --cidr-block $vpc_cidr_block --query 'Vpc.VpcId' --output text)

# add name tag to vpc  
aws ec2 create-tags --resources $vpc_id --tags Key=Name,Value=$vpc_name

# create a public subnet
subnet_id=$(aws ec2 create-subnet --vpc-id $vpc_id --cidr-block $subnet_cidr_block --availability-zone $subnet_availability_zone --query 'Subnet.SubnetId' --output text)

# add name tag to subnet
aws ec2 create-tags --resources $subnet_id --tags Key=Name,Value=$subnet_name

# enable public ip on subnet
aws ec2 modify-subnet-attribute --subnet-id $subnet_id --map-public-ip-on-launch

echo "VPC ID '$vpc_id' and Subnet ID '$subnet_id' created successfully"

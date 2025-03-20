#!/bin/bash

# Create a bucket in AWS S3 with the name provided in environment variable in .env file
# Usage: ./aws_s3_create.sh

# Load environment variables
source .env

# Create a bucket in AWS S3 when the command line argument is provided as create-bucket
aws s3api create-bucket --bucket $AWS_S3_BUCKET_NAME --region $AWS_REGION --create-bucket-configuration LocationConstraint=$AWS_REGION

# Verify the bucket creation
aws s3api list-buckets --query "Buckets[].Name" | grep $AWS_S3_BUCKET_NAME

# When the command line argument is provided as delete-bucket, delete the bucket and add if statement to check if the bucket exists

# Delete the bucket in AWS S3 when the command line argument is provided as delete-bucket
# Check if the bucket exists before deleting
if aws s3api list-buckets --query "Buckets[].Name" | grep -q $AWS_S3_BUCKET_NAME; then
    echo "Bucket exists"
else
    echo "Bucket does not exist"
fi

# Delete the bucket
aws s3api delete-bucket --bucket $AWS_S3_BUCKET_NAME



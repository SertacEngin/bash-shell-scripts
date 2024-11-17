#!/bin/bash

#########################
# Author: Sertac Engin
# Date: 17.11.2024
# Version: v1
#
# This script will report the AWS resource usage.
# #######################

# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM Users

set -x

# list S3 buckets
echo "print list of S3 buckets"
aws s3 ls >> resourceTracker

# list EC2 instances
echo "print list of EC2 instances"
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId' >> resourceTracker

# list AWS Lambda Functions
echo "print list of Lambda Functions"
aws lambda list-functions >> resourceTracker

# list IAM users
echo "print list of IAM users"
aws iam list-users >> resourceTracker

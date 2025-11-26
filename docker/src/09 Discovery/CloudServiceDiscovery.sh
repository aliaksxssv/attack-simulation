#!/bin/bash

# Define colors
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# aws services enumeration 
echo -e "\n${YELLOW}>>> [Discovery] Cloud Service Discovery Technique ${RESET}"
echo "Let's simulate the case when an attacker enumerates AWS services with IAM user credentials"

echo "Discovering AWS EC2, S3, IAM, RDS, and Lambda using aws cli ... "

# Validate AWS credentials before attempting enumeration
if identity_output=$(aws sts get-caller-identity --output text 2>&1); then
    :
else
    echo -e "${RED}Error! Ensure Access Key ID, Secret Access Key, and region are set and valid in the Helm values${RESET}"
    exit 1
fi

# Execute AWS CLI commands
aws ec2 describe-instances --region us-east-1
aws s3 ls
aws iam list-users
aws rds describe-db-instances --region us-east-1
aws lambda list-functions --region us-east-1

# Display success message
echo -e "${GREEN}Success! AWS service enumeration completed ${RESET}"

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

# initialize error variable
error=""

# Validate AWS credentials before attempting enumeration
if identity_output=$(aws sts get-caller-identity --output text 2>&1); then
    aws ec2 describe-instances --region us-east-1 > /dev/null 2>&1
    aws s3 ls > /dev/null 2>&1
    aws iam list-users > /dev/null 2>&1
    aws rds describe-db-instances --region us-east-1 > /dev/null 2>&1
    aws lambda list-functions --region us-east-1 > /dev/null 2>&1
else
    error="${RED}Ensure Access Key ID, Secret Access Key, and region are set and valid in the Helm values${RESET}"
fi

# display results
if [[ -n "$error" ]]; then
    echo -e "${RED}Error! ${error} ${RESET}"
else
    echo -e "${GREEN}Success! AWS services enumeration completed ${RESET}"
fi



#!/bin/bash

# Define colors
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# aws services enumeration 
echo -e "\n${YELLOW}>>> [Discovery] Cloud Service Discovery Technique ${RESET}"
echo "Let's simulate the case when an attacker enumerates AWS services using valid credentials"

echo "Attempting to discover AWS services using AWS CLI (EC2, S3, IAM, RDS, Lambda) ... "

# Initialize error variable
error=""

# EC2 - List instances and security groups
if ! aws ec2 describe-instances --region us-east-1 > /dev/null 2>&1; then
    error="EC2 discovery failed"
elif ! aws ec2 describe-security-groups --region us-east-1 > /dev/null 2>&1; then
    error="EC2 security groups discovery failed"
fi

# S3 - List buckets and objects
if [[ -z "$error" ]]; then
    echo "Discovering S3 buckets..."
    if ! aws s3 ls > /dev/null 2>&1; then
        error="S3 buckets discovery failed"
    elif ! aws s3api list-buckets > /dev/null 2>&1; then
        error="S3 API discovery failed"
    fi
fi

# IAM - List users and roles
if [[ -z "$error" ]]; then
    echo "Discovering IAM users and roles..."
    if ! aws iam list-users > /dev/null 2>&1; then
        error="IAM users discovery failed"
    elif ! aws iam list-roles > /dev/null 2>&1; then
        error="IAM roles discovery failed"
    fi
fi

# RDS - List databases
if [[ -z "$error" ]]; then
    echo "Discovering RDS databases..."
    if ! aws rds describe-db-instances --region us-east-1 > /dev/null 2>&1; then
        error="RDS instances discovery failed"
    elif ! aws rds describe-db-clusters --region us-east-1 > /dev/null 2>&1; then
        error="RDS clusters discovery failed"
    fi
fi

# Lambda - List functions
if [[ -z "$error" ]]; then
    echo "Discovering Lambda functions..."
    if ! aws lambda list-functions --region us-east-1 > /dev/null 2>&1; then
        error="Lambda functions discovery failed"
    elif ! aws lambda list-layers --region us-east-1 > /dev/null 2>&1; then
        error="Lambda layers discovery failed"
    fi
fi

if [[ -n "$error" ]]; then
    echo -e "${RED}Error! ${error}. Check Helm chart values for AWS credentials ${RESET}"
else 
    echo -e "${GREEN}Success! AWS service enumeration completed ${RESET}"
fi

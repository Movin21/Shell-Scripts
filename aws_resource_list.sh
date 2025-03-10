#!/bin/bash

###############################################################################
# Author: Abhishek Veeramalla
# Version: v0.0.1

# Script to automate the process of listing all the resources in an AWS account
#
# Below are the services that are supported by this script:
# 1. EC2
# 2. RDS
# 3. S3
# 4. CloudFront
# 5. VPC
# 6. IAM
# 7. Route53
# 8. CloudWatch
# 9. CloudFormation
# 10. Lambda
# 11. SNS
# 12. SQS
# 13. DynamoDB
# 14. VPC
# 15. EBS
#
# The script will prompt the user to enter the AWS region and the service for which the resources need to be listed.
#
# Usage: ./aws_resource_list.sh  <aws_region> <aws_service>
# Example: ./aws_resource_list.sh us-east-1 ec2
#############################################################################

# Check if the user has provided the required number of arguments
if [$# -ne 2]; then
echo "Usage: ./aws_resource_list.sh  <aws_region> <aws_service>"
echo "Example: ./aws_resource_list.sh us-east-1 ec2"
exit 1
fi

aws_region = $1
aws_service = $2

if ! command -v aws &> /dev/null; then
echo "AWS CLI is not installed. Please install it before running this script."
exit 1
fi

if [ ! -d ~/.aws ]; then
    echo "AWS CLI is not configured. Please configure the AWS CLI and try again."
    exit 1
fi

# List all the resources in the specified region and service

case $aws_service in
    ec2)
        aws ec2 describe-instances --region $aws_region
        ;;
    rds)
        aws rds describe-db-instances --region $aws_region
        ;;
    s3)
        aws s3 ls --region $aws_region
        ;;
    cloudfront)
        aws cloudfront list-distributions --region $aws_region
        ;;
    vpc)
        aws ec2 describe-vpcs --region $aws_region
        ;;
    iam)
        aws iam list-users --region $aws_region
        ;;
    route53)
        aws route53 list-hosted-zones --region $aws_region
        ;;
    cloudwatch)
        aws cloudwatch list-metrics --region $aws_region
        ;;
    cloudformation)
        aws cloudformation list-stacks --region $aws_region
        ;;
    lambda)
        aws lambda list-functions --region $aws_region
        ;;
    sns)
        aws sns list-topics --region $aws_region
        ;;
    sqs)
        aws sqs list-queues --region $aws_region
        ;;
    dynamodb)
        aws dynamodb list-tables --region $aws_region
        ;;
    vpc)
        aws ec2 describe-vpcs --region $aws_region
        ;;
    ebs)
        aws ec2 describe-volumes --region $aws_region
        ;;
    *)
        echo "Invalid service. Supported services are: ec2, rds, s3, cloudfront, vpc, iam, route53, cloudwatch, cloudformation, lambda, sns, sqs, dynamodb, vpc, ebs"
        exit 1
        ;;
esac
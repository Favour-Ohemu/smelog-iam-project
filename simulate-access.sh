#!/bin/bash

#############################################################################
###################################################################
# simulate-access.sh
# AWS IAM + S3 demo project for SMEs
# Demonstrates user, role and group permissions in a real world scenario
###########################################################################
####################################################################

# Set variables
SME_BUCKET="smelog-bucket"
DEV_BUCKET="developer-demo-bucket123"
FINANCE_BUCKET="finance-logs-bucket"
TEST_FILE="testfile.txt"

echo "===== Testing SME user access ====="
# List SME bucket contents
aws s3 ls s3://$SME_BUCKET
# Upload test file to SME bucket
aws s3 cp $TEST_FILE s3://$SME_BUCKET/ 
echo "===== END SME user access test ====="
echo

echo "===== Testing DeveloperTemporaryRole access ====="
# Assume Developer role
echo "Assuming DeveloperTemporaryRole..."
CREDENTIALS=$(aws sts assume-role \
    --role-arn arn:aws:iam::4**********4:role/DeveloperTemporaryRole \
    --role-session-name DevSession)

export AWS_ACCESS_KEY_ID=$(echo $CREDENTIALS | jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(echo $CREDENTIALS | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo $CREDENTIALS | jq -r '.Credentials.SessionToken')

# Try to create developer bucket
aws s3 mb s3://$DEV_BUCKET
# Try to list SME bucket (should fail)
aws s3 ls s3://$SME_BUCKET
echo "===== END DeveloperTemporaryRole access test ====="
echo

echo "===== Testing Ben's write permission on Finance Reports bucket ====="
echo "Attempting to write as Ben to FINANCE_BUCKET..."

# Run real s3 copy using Ben profile  
aws s3 cp $TEST_FILE s3://$FINANCE_BUCKET/ --profile ben-profile 2>&1 | tee ben-write-output.txt

echo "Check 'ben-write-output.txt' for AccessDenied or success message."
echo  "Result: Ben was denied write access to $FINANCE_BUCKET (as expected)."
echo "===== END Ben write test ====="

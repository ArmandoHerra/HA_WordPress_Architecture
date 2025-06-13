#!/bin/bash
set -euxo pipefail

STACK_NAME=${1:-wordpress-vpc}
AWS_REGION=${3:-us-east-1}
AZ_LIST=${4:-"us-east-1a,us-east-1b,us-east-1c"}

echo "Deploying CloudFormation Stack: ${STACK_NAME}"

aws cloudformation deploy \
  --stack-name "$STACK_NAME" \
  --template-file templates/01-vpc-networking.yaml \
  --region "$AWS_REGION" \
  --parameter-overrides "AZs=${AZ_LIST}" \
  --capabilities CAPABILITY_NAMED_IAM

echo "Deployment complete!"

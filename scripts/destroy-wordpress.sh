#!/bin/bash
set -euxo pipefail

STACK_NAME=${1:-wordpress-app}
AWS_REGION=${2:-us-east-1}

echo "Deleting WordPress CloudFormation Stack: ${STACK_NAME}"

aws cloudformation delete-stack \
  --stack-name "$STACK_NAME" \
  --region "$AWS_REGION"

echo "Waiting for WordPress stack deletion..."

aws cloudformation wait stack-delete-complete \
  --stack-name "$STACK_NAME" \
  --region "$AWS_REGION"

echo "WordPress stack deletion complete!"

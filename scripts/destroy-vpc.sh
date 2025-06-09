#!/bin/bash
set -euo pipefail

STACK_NAME=${1:-wordpress-vpc}
AWS_REGION=${2:-us-east-1}

echo "Deleting CloudFormation Stack: ${STACK_NAME}"

aws cloudformation delete-stack \
  --stack-name "$STACK_NAME" \
  --region "$AWS_REGION"

echo "Waiting for stack deletion..."

aws cloudformation wait stack-delete-complete \
  --stack-name "$STACK_NAME" \
  --region "$AWS_REGION"

echo "Stack deletion complete!"

#!/bin/bash
set -euxo pipefail

STACK_NAME=${1:-wordpress-alb}
AWS_REGION=${2:-us-east-1}

echo "Deleting ALB CloudFormation Stack: ${STACK_NAME}"

aws cloudformation delete-stack \
  --stack-name "$STACK_NAME" \
  --region "$AWS_REGION"

echo "Waiting for ALB stack deletion..."

aws cloudformation wait stack-delete-complete \
  --stack-name "$STACK_NAME" \
  --region "$AWS_REGION"

echo "ALB stack deletion complete!"

#!/bin/bash
set -euxo pipefail

STACK_NAME=${1:-wordpress-db}
AWS_REGION=${2:-us-east-1}

aws cloudformation delete-stack \
  --stack-name "$STACK_NAME" \
  --region "$AWS_REGION"

aws cloudformation wait stack-delete-complete \
  --stack-name "$STACK_NAME" \
  --region "$AWS_REGION"

echo "Database stack $STACK_NAME has been deleted."

#!/bin/bash
set -euxo pipefail

STACK_NAME=${1:-wordpress-db}
VPC_STACK=${2:-wordpress-vpc}
DB_NAME=${3:-wordpress}
DB_USER=${4:-wpadmin}
DB_PASSWORD=${5:?DB password required}
DB_INSTANCE_TYPE=${6:-db.t3.medium}
AWS_REGION=${7:-us-east-1}

aws cloudformation deploy \
  --stack-name "$STACK_NAME" \
  --template-file templates/04-rds-database.yaml \
  --region "$AWS_REGION" \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    VPCStackName="$VPC_STACK" \
    DBName="$DB_NAME" \
    DBUsername="$DB_USER" \
    DBPassword="$DB_PASSWORD" \
    DBInstanceClass="$DB_INSTANCE_TYPE"

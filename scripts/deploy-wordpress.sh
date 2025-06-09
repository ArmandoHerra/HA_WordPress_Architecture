#!/bin/bash
set -euxo pipefail

STACK_NAME=${1:-wordpress-app}
VPC_STACK=${2:-wordpress-vpc}
ALB_STACK=${3:-wordpress-alb}
AMI_ID=${4:?Provide AMI ID}
KEY_PAIR=${5:?Provide EC2 KeyPair name}
INSTANCE_TYPE=${6:-t3.medium}

aws cloudformation deploy \
  --stack-name "$STACK_NAME" \
  --template-file templates/03-wordpress-app.yml \
  --parameter-overrides \
    VPCStackName="$VPC_STACK" \
    ALBStackName="$ALB_STACK" \
    AMIId="$AMI_ID" \
    KeyPairName="$KEY_PAIR" \
    InstanceType="$INSTANCE_TYPE" \
  --capabilities CAPABILITY_NAMED_IAM

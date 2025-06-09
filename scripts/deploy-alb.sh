#!/bin/bash
set -euxo pipefail

STACK_NAME=${1:-wordpress-alb}
VPC_STACK=${2:-wordpress-vpc}
DOMAIN_NAME=${3:?Provide your domain name}
HOSTED_ZONE_ID=${4:?Provide Hosted Zone ID}

aws cloudformation deploy \
  --stack-name "$STACK_NAME" \
  --template-file templates/02-load-balancer.yml \
  --parameter-overrides \
    VPCStackName="$VPC_STACK" \
    DomainName="$DOMAIN_NAME" \
    HostedZoneId="$HOSTED_ZONE_ID" \
  --capabilities CAPABILITY_NAMED_IAM

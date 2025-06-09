# Load environment variables from .env file
include .env
export

# Deploy Commands
deploy-vpc:
	./scripts/deploy-vpc.sh $(VPC_STACK) templates/01-vpc-networking.yml $(AWS_REGION)

deploy-alb:
	./scripts/deploy-alb.sh $(ALB_STACK) $(VPC_STACK) $(DOMAIN_NAME) $(HOSTED_ZONE_ID)

deploy-app:
	./scripts/deploy-wordpress.sh $(APP_STACK) $(VPC_STACK) $(ALB_STACK) $(AMI_ID) $(KEY_PAIR) $(INSTANCE_TYPE)

deploy-all: deploy-vpc deploy-alb deploy-app

# Destroy Commands
destroy-app:
	./scripts/destroy-wordpress.sh $(APP_STACK) $(AWS_REGION)

destroy-alb:
	./scripts/destroy-alb.sh $(ALB_STACK) $(AWS_REGION)

destroy-vpc:
	./scripts/destroy-vpc.sh $(VPC_STACK) $(AWS_REGION)

destroy-all: destroy-app destroy-alb destroy-vpc

# Lint
lint:
	cfn-lint templates/*.yml

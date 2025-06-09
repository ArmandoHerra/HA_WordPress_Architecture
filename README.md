# 🛠️ HA WordPress Architecture

 WordPress on AWS: Modular CloudFormation Infrastructure

This repository provides an Infrastructure-as-Code (IaC) setup using AWS CloudFormation to deploy a **highly available WordPress application** across 3 modular stacks:

1. **VPC Stack** – Networking (VPC, subnets, routing, NAT)
2. **ALB Stack** – Load Balancer, SSL via ACM, Route53 DNS
3. **WordPress Stack** – EC2 Auto Scaling Group with WordPress instances

The project also includes:

- A `.env`-based configuration
- Modular shell scripts for deploying and destroying each stack
- A `Makefile` to orchestrate deployments and linting
- GitHub Actions for Sustainability Report (WIP)

---

## 📁 Project Structure

```text
.
├── .env                          # Configuration values for stacks
├── Makefile                      # Automation entrypoint
├── templates/
│   ├── 01-vpc-networking.yml     # VPC + Subnets
│   ├── 02-load-balancer.yml      # ALB + ACM + Route53
│   └── 03-wordpress-app.yml      # WordPress EC2 + Auto Scaling
├── scripts/
│   ├── deploy-vpc.sh
│   ├── deploy-alb.sh
│   ├── deploy-wordpress.sh
│   ├── destroy-vpc.sh
│   ├── destroy-alb.sh
│   └── destroy-wordpress.sh
└── README.md
```
---

## ⚙️ Prerequisites

- AWS CLI configured
- cfn-lint installed:

```sh
pip install cfn-lint
```
---
## 📄 .env Configuration

Create a .env file at the root of the repo:

```sh
VPC_STACK=wordpress-vpc
ALB_STACK=wordpress-alb
APP_STACK=wordpress-app
AWS_REGION=us-east-1

DOMAIN_NAME=yourdomain.com
HOSTED_ZONE_ID=Z123456789EXAMPLE

AMI_ID=ami-xxxxxxxxxxxxxxxxx
KEY_PAIR=your-ec2-keypair
INSTANCE_TYPE=t3.medium
```

> ⚠️ Replace the values with your actual AWS resources.

---

## 🧰 Makefile Commands

Run all these commands from the project root.

### 🔼 Deploy Stacks

```sh
make deploy-vpc         # Step 1: VPC
make deploy-alb         # Step 2: ALB + SSL + DNS
make deploy-app         # Step 3: WordPress EC2 ASG

make deploy-all         # Deploy all 3 stacks
```

### 🔽 Destroy Stacks

```sh
make destroy-app        # Delete WordPress Stack
make destroy-alb        # Delete ALB Stack
make destroy-vpc        # Delete VPC Stack

make destroy-all        # Destroys all stacks (reverse order)
```

### ✅ Lint Templates

```sh
make lint
```
#!/bin/bash
# *** Set up AWS CLI and AWS keys first! *** #

export TEAM_NAME=hackathon1
export VPC=vpc-69b9a70c
export DEFAULT_SEC_GROUP=sg-ec5a518b

# Create subnet. Make sure to set CIDR correctly.
export SUBNET_ID="$( \
    aws ec2 create-subnet \
    --vpc-id $VPC \
    --cidr-block 172.31.92.0/28 \
    | awk '{print $6}' )"

echo SUBNET CREATED=$SUBNET_ID

# Auto-assign public IP. Create security group.
aws ec2 modify-subnet-attribute $SUBNET_ID --map-public-ip-on-launch
export SECGRP_ID="$( \
    aws ec2 create-security-group \
    --group-name $TEAM_NAME \
    --description $TEAM_NAME \
    --vpc-id $VPC \
    | awk '{print $1}' )"
aws ec2 authorize-security-group-ingress \
    --group-id $SECGRP_ID \
    --source-group $SECGRP_ID \
    --port 0-65535

# Creates 2x Ubuntu, 2x Amazon Linux 
aws ec2 run-instances \
    --image-id ami-0d4cfd66 \
    --instance-type t2.micro \
    --key-name wjackson \
    --subnet-id $SUBNET_ID \
    --security-group-ids "$DEFAULT_SEC_GROUP" "$SECGRP_ID"

# To add more vpcs, copy the two lines above (the '-' takes the vpc-id 
# from stdin, because AWS won't let you assign a tag/name with a call
# to ec2-create-vpc.


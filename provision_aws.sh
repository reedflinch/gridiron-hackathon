#!/bin/bash

# Set up ec2-api-tools and AWS keys first!

# Make sure to set CIDR/Name correctly.

ec2-create-vpc 172.31.0.0/28 | awk '{print $2}' | \
    ec2-create-tags - --tag Name=hackathon_vpc_1

# To add more vpcs, copy the two lines above (the '-' takes the vpc-id 
# from stdin, because AWS won't let you assign a tag/name with a call
# to ec2-create-vpc.


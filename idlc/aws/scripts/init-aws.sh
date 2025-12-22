#!/bin/bash

# How To use:
# Create your first AWS Access Key with root privileges
# ./scripts/init-aws.sh
# Input AWS Access Key ID and Secret Access Key when prompted

aws configure --profile root-bootstrap

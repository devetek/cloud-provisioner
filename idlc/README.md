## Description

This directory contains the Terraform configuration files for managing Cloud Infrastructure related to IDLC (Infrastructure Development Life Cycle) projects.


### The folder is structured as follows:   

```sh
aws/                # AWS Terraform codebase
    modules/
    ├── networking/     # VPC, subnets, endpoints
    ├── eks/            # Base EKS cluster (Support GPU nodes / Karpenter)
    ├── bedrock/        # Bedrock generative AI
    ├── lambda/         # Lambda functions
    ├── ecs/            # ECS cluster for LLM hosting
    ├── iam/            # IAM roles / policies
    ├── s3/             # S3 buckets for data storage
    ├── glue/           # Glue catalog & crawlers
    ├── sagemaker/      # Training & hosting
    environments/
    ├── shared/         # Shared infra
        ├── staging/
            ├── networking/
                ├── main.tf
                ├── versions.tf
                ├── backend.tf
                └── providers.tf
        └── production/
            ├── networking/
                ├── main.tf
                ├── versions.tf
                ├── backend.tf
                └── providers.tf
    ├── team-frontend/        # Team frontend workloads
        ├── staging/
            ├── cloudfront/
                ├── main.tf
                ├── versions.tf
                ├── backend.tf
                └── providers.tf
        └── production/
            ├── cloudfront/
                ├── main.tf
                ├── versions.tf
                ├── backend.tf
                └── providers.tf
    ├── team-backend/        # Team backend workloads
        ├── staging/
            ├── eks/
                ├── main.tf
                ├── versions.tf
                ├── backend.tf
                └── providers.tf
        └── production/
            ├── eks/
                ├── main.tf
                ├── versions.tf
                ├── backend.tf
                └── providers.tf
    └── team-mlops/        # Team mlops workloads
        ├── staging/
            ├── bootstrap/
                ├── main.tf
                ├── versions.tf
                ├── backend.tf
                └── providers.tf
        └── production/
            ├── bootstrap/
                ├── main.tf
                ├── versions.tf
                ├── backend.tf
                └── providers.tf
```


### Key Components

1. Networking (Shared Account)
    - VPC (per region)
    - Private subnets only
    - VPC Endpoints:
        - S3
        - ECR
        - CloudWatch
        - STS

2. Identity & Security
    - AWS Organizations + SCPs
    - Per-team AWS account
    - IAM Roles via IRSA only
    - No static credentials
    - Key Guardrails
    - GPU instance restrictions
    - Mandatory cost tags
    - Region allow-list

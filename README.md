# Background

This repository contains Terraform code to provision and manage a multi-tenant infrastructure for teams working on large language model (LLM) projects. The goal is to provide isolated environments for each team while leveraging shared platform components to optimize resource usage and operational efficiency.

# Core Design Principles

Introduce core principles before moving forward to the implementation details.

| Layer           | Isolation            |
| --------------- | -------------------- |
| AWS Account     | **Hard isolation**   |
| VPC             | Optional shared      |
| EKS             | Namespace or cluster |
| Terraform State | Per team             |
| IAM             | Per workload         |


## Team Isolation
Each team:
- Has its own AWS account (best practice)
- Owns its Terraform state
- Can deploy independently


## Platform vs Product Split
Separate:
- Platform (shared infra) → VPCs, EKS, IAM, networking
- Team workloads → LLM endpoints, RAG stacks, pipelines

## Immutable & Reproducible
- No terraform apply from laptops in prod
- Everything via CI/CD
- Environments = code + variables only


# Practice

Before we go to how to operate it, we need to define what can or cannot do in the process. So you can understand structure, policies and responsibility in the processes:

```sh
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
├── shared/         # Shared infra (VPC, EKS base)
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


Now you can follow steps below to operate the infra codebase:
PR opened, will trigger CI/CD pipeline:
- → terraform fmt
- → terraform validate
- → terraform plan
- → OPA / tfsec / checkov
- → approval
- → terraform apply


# Todo

- [ ] Completing the modules for LLM workloads (ECS, SageMaker, Bedrock, s3 buckets, IAM, etc.)
- [ ] Setting up CI/CD pipelines for automated deployments
- [ ] Documenting best practices for team usage and management
- [ ] Implementing monitoring and alerting for infrastructure health and performance
- [ ] Creating cost management strategies and tagging policies
- [ ] Rearchitecting for scalability and future growth
- [ ] Adding examples and templates for common LLM workloads
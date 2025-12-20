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
├── eks/            # Base EKS cluster
├── eks-gpu/        # GPU node groups / Karpenter
├── llm-inference/  # vLLM / TGI / Ray Serve
├── rag/            # End-to-end RAG stack
├── vector-store/   # OpenSearch / pgvector / DynamoDB
├── sagemaker/      # Training & hosting
├── observability/  # Prometheus, Grafana, CW
├── security/       # IAM, IRSA, KMS, SCP helpers
└── ci-cd/          # OIDC roles, pipelines
environments/
├── shared/         # Shared infra (VPC, EKS base)
    |__ staging/
    |   ├── main.tf
    |   ├── variables.tf
    |   └── outputs.tf
    └── production/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
├── team-frontend/        # Team frontend workloads
    |__ staging/
    |   ├── main.tf
    |   ├── variables.tf
    |   └── outputs.tf
    └── production/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
├── team-backend/        # Team backend workloads
    |__ staging/
    |   ├── main.tf
    |   ├── variables.tf
    |   └── outputs.tf
    └── production/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
└── team-mlops/        # Team mlops workloads
    |__ staging/
    |   ├── main.tf
    |   ├── variables.tf
    |   └── outputs.tf
    └── production/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
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
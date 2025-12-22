# Background

This repository contains IDLC (Infrastructure Development Life Cycle) Terraform codebase for provisioning and managing cloud infrastructure, specifically designed to support teams working on large language model (LLM) projects. The infrastructure is architected to provide isolated environments for different teams while leveraging shared platform components to optimize resource usage and operational efficiency.

And also controller of SDLC (Software Development Life Cycle) Kubernetes manifests for deploying applications and services on top of the provisioned infrastructure.

The goal is to provide isolated environments for each team while leveraging shared platform components to optimize resource usage and operational efficiency. And also to ensure best practices in infrastructure management, security, and scalability. Make all of the provisioning and deployment processes automated via GitOps and CI/CD pipelines.

# Core Design Principles

Introduce core principles before moving forward to the implementation details.

| Layer           | Isolation            |
| --------------- | -------------------- |
| Account         | **Hard isolation**   |
| VPC             | Optional shared      |
| EKS             | Namespace or cluster |
| Terraform State | Per team             |
| IAM             | Per workload         |


## Team Isolation
Each team:
- Has its own account (best practice)
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
idlc/                       # Root folder for IDLC (Infrastructure Development Life Cycle) codebase with Terraform
├── gcp/                    # GCP specific Terraform codebase
├── aws/                    # AWS specific Terraform codebase
│   ├── modules/            # Reusable Terraform modules
│   ├── environments/       # Per-environment and per-team Terraform configurations (Controlled by GitOps)
sldc/                       # Root folder for SDLC (Software Development Life Cycle) infra codebase with Kubernetes manifests
├── platform/               # Platform is all service controlled by Helm charts
├── teams/                  # Teams is all team kubernetes manifests (Controlled by GitOps)
├── README.md               # Describe high level overview of the folder
```


# Todo

- [ ] Completing the modules for LLM workloads (ECS, SageMaker, Bedrock, s3 buckets, IAM, etc.)
- [ ] Setting up CI/CD pipelines for automated deployments
- [ ] Documenting best practices for team usage and management
- [ ] Implementing monitoring and alerting for infrastructure health and performance
- [ ] Creating cost management strategies and tagging policies
- [ ] Rearchitecting for scalability and future growth
- [ ] Adding examples and templates for common LLM workloads
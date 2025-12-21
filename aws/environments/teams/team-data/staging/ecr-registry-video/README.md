## Description

This directory contains the Terraform configuration files for managing the Amazon Elastic Container Registry (ECR) for the "team-data" team in the staging environment. The ECR is used to store and manage Docker container images for video processing applications.

## How To Create/Update the ECR Registry

1. **Navigate to the Directory**: Open your terminal and navigate to the `aws/environments/teams/team-data/staging/ecr-registry-video` directory.

2. **Initialize Terraform**: Run the following command to initialize the Terraform configuration. This will set up the backend and download necessary provider plugins.
```sh
terraform init
terraform plan
```

3. **Apply Changes**: Review the plan output and if everything looks good, apply the changes by running:

```sh
terraform apply
```

#### How To Destroy the ECR Registry
To destroy the ECR registry and all associated resources, run the following command in the same directory:

```sh
terraform destroy
```
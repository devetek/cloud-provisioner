data "terraform_remote_state" "shared_vpc" {
  backend = "s3"

  config = {
    bucket = "dpanel-tf-state-staging"
    key    = "shared/staging/vpc/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

data "terraform_remote_state" "iam_eks_admin" {
  backend = "s3"

  config = {
    bucket = "dpanel-tf-state-staging"
    key    = "team-data/staging/iam-eks-admin/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

module "eks_ollama" {
  source = "./../../../../../modules/eks"

  kubernetes_version = "1.33"
  cluster_name       = "team-data-simple-staging"
  region             = "ap-southeast-1" # GPU-safe region

  vpc_id     = data.terraform_remote_state.shared_vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.shared_vpc.outputs.private_subnets

  enable_irsa         = true
  admin_principal_arn = data.terraform_remote_state.iam_eks_admin.outputs.eks_admin_role_arn

  eks_managed_node_groups = {
    # Normal node group for non-GPU workloads
    nongpu = {
      instance_types = ["t3.medium"]
      ami_type       = "AL2023_x86_64_STANDARD"

      min_size     = 2
      max_size     = 10
      desired_size = 2

      labels = {
        workload = "general"
        app      = "simple"
        team     = "team-data"
      }
    }
  }

  tags = {
    team = "team-data"
    app  = "simple"
    env  = "staging"
  }
}

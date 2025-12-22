data "terraform_remote_state" "shared_vpc" {
  backend = "s3"

  config = {
    bucket = "dpanel-terraform-state-staging"
    key    = "shared/staging/vpc/terraform.tfstate"
    region = "ap-southeast-3"
  }
}

data "terraform_remote_state" "iam_eks_admin" {
  backend = "s3"

  config = {
    bucket = "dpanel-terraform-state-staging"
    key    = "team-data/staging/iam-eks-admin/terraform.tfstate"
    region = "ap-southeast-3"
  }
}

module "eks_ollama" {
  source = "./../../../../../modules/eks"

  cluster_name = "team-data-ollama-staging"
  region       = "ap-southeast-3" # GPU-safe region

  vpc_id     = data.terraform_remote_state.shared_vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.shared_vpc.outputs.private_subnets

  enable_irsa         = true
  admin_principal_arn = data.terraform_remote_state.iam_eks_admin.outputs.eks_admin_role_arn

  eks_managed_node_groups = {
    gpu = {
      instance_types = ["g5.xlarge"]
      ami_type       = "AL2_x86_64_GPU"

      min_size     = 0
      max_size     = 2
      desired_size = 1

      labels = {
        workload = "ollama"
        gpu      = "true"
      }

      taints = {
        gpu = {
          key    = "nvidia.com/gpu"
          value  = "true"
          effect = "NO_SCHEDULE"
        }
      }
    }
  }

  tags = {
    team = "team-data"
    app  = "ollama"
    env  = "staging"
  }
}

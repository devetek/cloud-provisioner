data "terraform_remote_state" "shared_vpc" {
  backend = "s3"

  config = {
    bucket = "dpanel-terraform-state-staging"
    key    = "shared/staging/vpc/terraform.tfstate"
    region = "ap-southeast-3"
  }
}

module "eks_ollama" {
  source = "./../../../../../modules/eks"

  cluster_name = "team-data-ollama-staging"
  region       = "ap-southeast-3"

  eks_managed_node_groups = {
    ollama_gpu = {
      instance_types = ["g5.xlarge"]
      ami_type       = "AL2_x86_64_GPU"

      min_size     = 0
      max_size     = 2
      desired_size = 1
    }

    cpu = {
      instance_types = ["m6i.large"]
      desired_size   = 2
    }
  }

  vpc_id = data.terraform_remote_state.shared_vpc.outputs.vpc_id
  private_subnet_ids = data.terraform_remote_state.shared_vpc.outputs.private_subnets

  tags = {
    team = "team-data"
    env  = "staging"
    app  = "ollama"
  }
}

module "vpc" {
  source = "./../../../../modules/vpc"

  name         = "vpc-sg-shared-staging"
  cluster_name = "vpc-sg-shared-staging"

  cidr = "10.0.0.0/16"
  azs  = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]

  public_subnets = [
    "10.0.0.0/20",
    "10.0.16.0/20"
  ]

  private_subnets = [
    "10.0.32.0/20",
    "10.0.48.0/20"
  ]

  tags = {
    owner = "platform"
    env   = "staging"
  }
}

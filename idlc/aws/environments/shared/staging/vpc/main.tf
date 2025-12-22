module "vpc" {
  source = "./../../../../modules/vpc"

  name         = "platform-staging"
  cluster_name = "platform-staging"

  cidr = "10.0.0.0/16"
  azs  = ["ap-southeast-3a", "ap-southeast-3b", "ap-southeast-3c"]

  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]

  tags = {
    owner = "platform"
    env   = "staging"
  }
}

module "cpu_nodes" {
  source  = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  version = "20.11.0"

  cluster_name    = module.eks.cluster_name
  cluster_version = var.kubernetes_version

  name = "cpu-base"

  subnet_ids = var.private_subnet_ids

  instance_types = ["m6i.large"]

  min_size     = 2
  max_size     = 5
  desired_size = 2

  tags = merge(var.tags, {
    "node-type" = "cpu"
  })
}

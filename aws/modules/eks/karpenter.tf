module "karpenter" {
  count = var.enable_karpenter ? 1 : 0

  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "20.11.0"

  cluster_name = module.eks.cluster_name

  enable_irsa = true

  tags = var.tags
}

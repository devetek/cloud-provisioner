module "gpu_nodes" {
  count = var.enable_gpu ? 1 : 0

  source  = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  version = "20.11.0"

  cluster_name    = module.eks.cluster_name
  cluster_version = var.kubernetes_version

  name = "gpu-nodes"

  subnet_ids = var.private_subnet_ids

  instance_types = var.gpu_instance_types

  min_size     = var.gpu_min_size
  max_size     = var.gpu_max_size
  desired_size = var.gpu_min_size

  ami_type = "AL2_x86_64_GPU"

  labels = {
    "accelerator" = "nvidia"
  }

  taints = [{
    key    = "nvidia.com/gpu"
    value  = "true"
    effect = "NO_SCHEDULE"
  }]

  tags = merge(var.tags, {
    "node-type" = "gpu"
  })
}

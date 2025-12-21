variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "region" {
  type = string
  description = "AWS region to deploy the EKS cluster"
}

variable "vpc_id" {
  type = string
  description = "The VPC ID where the EKS cluster will be deployed"
}

variable "private_subnet_ids" {
  type = list(string)
  description = "A list of private subnet IDs for the EKS cluster"
}

variable "kubernetes_version" {
  type    = string
  default = "1.34"
  description = "Kubernetes version for the EKS cluster"
}

variable "enable_gpu" {
  type    = bool
  default = true
  description = "Whether to enable GPU node group for the EKS cluster"
}

variable "gpu_instance_types" {
  type    = list(string)
  default = ["g5.2xlarge"]
  description = "List of GPU instance types for the GPU node group"
}

variable "gpu_min_size" {
  type    = number
  default = 0
  description = "Minimum number of GPU nodes"
}

variable "gpu_max_size" {
  type    = number
  default = 5
  description = "Maximum number of GPU nodes"
}

variable "enable_karpenter" {
  type    = bool
  default = true
  description = "Whether to enable Karpenter for the EKS cluster"
}

variable "tags" {
  type = map(string)
  description = "A map of tags to assign to the EKS resources"
}

variable "cluster_endpoint_public_access" {
  type    = bool
  default = false
  description = "Whether the EKS cluster endpoint is publicly accessible"
}

variable "cluster_endpoint_private_access" {
  type    = bool
  default = true
  description = "Whether the EKS cluster endpoint is privately accessible"
}
variable "eks_managed_node_groups" {
  type    = map(any)
  default = {}
  description = "A map of EKS managed node groups configurations"
}
variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "kubernetes_version" {
  type    = string
  default = "1.29"
}

variable "enable_gpu" {
  type    = bool
  default = true
}

variable "gpu_instance_types" {
  type    = list(string)
  default = ["g5.2xlarge"]
}

variable "gpu_min_size" {
  type    = number
  default = 0
}

variable "gpu_max_size" {
  type    = number
  default = 5
}

variable "enable_karpenter" {
  type    = bool
  default = true
}

variable "tags" {
  type = map(string)
}

variable "cluster_name" {
  type = string
}

variable "endpoint_private_access" {
  type = bool
  default = false
  description = "Enable or disable private access to the EKS cluster endpoint."
}

variable "endpoint_public_access" {
  type    = bool
  default = true
  description = "Enable or disable public access to the EKS cluster endpoint."
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "enable_irsa" {
  type    = bool
  default = true
}

variable "admin_principal_arn" {
  type = string
}

variable "eks_managed_node_groups" {
  description = "Managed node groups (CPU / GPU)"
  type = map(object({
    instance_types = list(string)
    ami_type       = string

    # configureable scaling config for node groups
    min_size     = number
    max_size     = number
    desired_size = number

    # configurable disk size for node group instances
    disk_size    = optional(number)

    # optional labels and taints
    labels = optional(map(string))
    taints = optional(list(object({
      key    = string
      value  = string
      effect = string
    })), [])
  }))
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
variable "kubernetes_version" {
  type    = string
  default = "1.27"
}

variable "enable_deletion_protection" {
  type    = bool
  default = false
  description = "Enable or disable deletion protection for the EKS cluster."
}

variable "admin_role_arns" {
  description = "List of IAM role ARNs to grant cluster administrator access."
  type        = list(string)
  default     = []
}
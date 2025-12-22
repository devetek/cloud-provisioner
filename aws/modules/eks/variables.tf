variable "cluster_name" {
  type = string
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

    min_size     = number
    max_size     = number
    desired_size = number

    labels = optional(map(string))
    taints = optional(map(object({
      key    = string
      value  = string
      effect = string
    })))
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

variable "admin_role_arns" {
  description = "List of IAM role ARNs to grant cluster administrator access."
  type        = list(string)
  default     = []
}
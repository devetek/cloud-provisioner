variable "name" {
  description = "IAM user name"
  type        = string
}

variable "path" {
  description = "IAM user path"
  type        = string
  default     = "/"
}

variable "policy_arns" {
  description = "List of IAM policy ARNs to attach"
  type        = list(string)
  default     = []
}

variable "create_access_key" {
  description = "Whether to create access keys"
  type        = bool
  default     = false
}

variable "pgp_key" {
  description = "PGP key for encrypting access secret"
  type        = string
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "name" {
  type = string
  description = "The name of the IAM role to create."
}

variable "assume_role_policy" {
  type = string
  description = "The policy that grants an entity permission to assume the role."
}

variable "managed_policy_arns" {
  type    = list(string)
  default = []
  description = "A list of ARNs of IAM managed policies to attach to the role."
}

variable "inline_policy" {
  type    = string
  default = null
  description = "An inline policy document to attach to the role."
}

variable "tags" {
  type    = map(string)
  default = {}
  description = "A map of tags to assign to the role."
}

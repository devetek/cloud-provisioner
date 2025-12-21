variable "name" {
  type        = string
  description = "ECR repository name"
}

variable "image_tag_mutability" {
  type        = string
  default     = "IMMUTABLE"
  description = "The tag mutability setting for the repository. Valid values are 'MUTABLE' and 'IMMUTABLE'."
}

variable "scan_on_push" {
  type        = bool
  default     = true
  description = "Whether to enable image scanning on push."
}

variable "encryption_type" {
  type        = string
  default     = "AES256"
  description = "The encryption type to use for the repository. Valid values are 'AES256' and 'KMS'."
}

variable "lifecycle_policy" {
  type        = string
  default     = null
  description = "The lifecycle policy for the repository in JSON format."
}

variable "repository_policy" {
  type        = string
  default     = null
  description = "The repository policy for the repository in JSON format."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the repository."
}

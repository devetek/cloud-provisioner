variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the bucket."
}

variable "attach_policy" {
  type        = bool
  default     = false
  description = "Whether to attach a bucket policy to the S3 bucket."
}

variable "bucket_policy" {
  type        = string
  default     = null
  description = "The bucket policy to attach to the S3 bucket."
}

variable "lifecycle_rules" {
  type = list(object({
    id              = string
    status          = string
    noncurrent_days = number
  }))
  default     = []
  description = "A list of lifecycle rules for the S3 bucket."
}
variable "versioning" {
  type        = bool
  default     = false
  description = "Whether versioning is enabled for the S3 bucket."
}
variable "server_side_encryption_enabled" {
  type        = bool
  default     = false
  description = "Whether server-side encryption is enabled for the S3 bucket."
}
variable "sse_algorithm" {
  type        = string
  default     = "AES256"
  description = "The server-side encryption algorithm to use. Valid values are 'AES256' and 'aws:kms'."
}
variable "kms_master_key_id" {
  type        = string
  default     = null
  description = "The KMS master key ID to use for server-side encryption with AWS KMS-managed keys. Required if sse_algorithm is 'aws:kms'."
}
variable "public_access_block" {
  type        = bool
  default     = true
  description = "If true, all public access to the bucket is blocked."
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "Whether to force destroy the bucket. If true, the bucket will be deleted even if it contains objects."
}

variable "bucket_name" {
  description = "Terraform state S3 bucket name"
  type        = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB table for state locking"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

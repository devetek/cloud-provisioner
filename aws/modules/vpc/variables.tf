variable "name" {
  type = string
  description = "The name of the VPC"
}

variable "cidr" {
  type = string
  description = "The CIDR block for the VPC"
}

variable "azs" {
  type = list(string)
  description = "A list of availability zones in the region"
}

variable "public_subnets" {
  type = list(string)
  description = "A list of CIDR blocks for the public subnets"
}

variable "private_subnets" {
  type = list(string)
  description = "A list of CIDR blocks for the private subnets"
}

variable "tags" {
  type    = map(string)
  default = {}
  description = "A map of tags to assign to the resources"
}
variable "cluster_name" {
  type        = string
  description = "Shared EKS cluster name"
}
variable "map_public_ip_on_launch" {
  type        = bool
  default     = false
  description = "Whether to map public IP on launch for public subnets"
}
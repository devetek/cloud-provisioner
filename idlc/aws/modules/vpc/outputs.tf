output "vpc_id" {
  value = aws_vpc.this.id
  description = "The ID of the VPC"
}

output "public_subnets" {
  value = [for s in aws_subnet.public : s.id]
  description = "List of IDs of the public subnets"
}

output "private_subnets" {
  value = [for s in aws_subnet.private : s.id]
  description = "List of IDs of the private subnets"
}

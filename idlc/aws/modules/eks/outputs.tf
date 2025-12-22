output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "oidc_provider_arn" {
  value = try(aws_iam_openid_connect_provider.this[0].arn, null)
}
output "node_group_names" {
  value = [for ng in aws_eks_node_group.this : ng.node_group_name]
}
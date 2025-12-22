output "eks_admin_role_arn" {
  description = "The ARN of the EKS admin IAM role"
  value       = module.eks_admin_iam_role.role_arn
}

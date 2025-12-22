module "ci_user" {
  source = "./../../../../../modules/iam-user"

  name = "ci-terraform-staging"

  # Recommendation: Create custom role with least privilege access instead of using AdministratorAccess policy
  # You can check example in aws/environments/teams/team-data/staging/iam-eks-admin/main.tf
  policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]

  create_access_key = true

  tags = {
    env  = "staging"
    type = "ci"
    team = "team-data"
  }
}

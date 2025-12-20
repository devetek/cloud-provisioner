module "terraform_state" {
  # TODO: It must replace with fixed version from git tag for production usage
  source = "./../../../../../modules/terraform-state"

  bucket_name         = "dpanel-terraform-state-staging"
  dynamodb_table_name = "terraform-state-lock"

  tags = {
    Owner       = "platform"
    Environment = "staging"
  }
}

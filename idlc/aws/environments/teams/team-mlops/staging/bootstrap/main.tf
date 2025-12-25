module "terraform_state" {
  # TODO: It must replace with fixed version from git tag for production usage
  source = "./../../../../../modules/terraform-state"

  bucket_name         = "dpanel-tf-state-staging"
  dynamodb_table_name = "dpanel-tf-state-lock"

  tags = {
    Owner       = "platform"
    Environment = "staging"
  }
}

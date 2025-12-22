terraform {
  backend "s3" {
    bucket         = "dpanel-terraform-state-staging"
    key            = "staging/bootstrap/terraform.tfstate"
    region         = "ap-southeast-3"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

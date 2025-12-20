terraform {
  backend "s3" {
    bucket         = "dpanel-terraform-state-staging"
    key            = "team-data/staging/bucket-rag-video/terraform.tfstate"
    region         = "ap-southeast-3"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

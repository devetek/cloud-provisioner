terraform {
  backend "s3" {
    bucket         = "dpanel-tf-state-staging"
    key            = "team-data/staging/bucket-rag-video/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "dpanel-tf-state-lock"
    encrypt        = true
  }
}

module "terraform_state_bucket" {
  source = "./../../../../../modules/s3"

  bucket_name = "dpanel-rag-video-staging"

  lifecycle_rules = [
    {
      id              = "expire-old-versions"
      status          = "Disabled"
      noncurrent_days = 90
    }
  ]

  tags = {
    purpose = "llm-rag-video-storage"
    env     = "staging"
  }
}

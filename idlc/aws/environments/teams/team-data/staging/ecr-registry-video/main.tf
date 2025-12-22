module "team_data_app_ecr" {
  source = "./../../../../../modules/ecr"

  name = "team-data/app"

  lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 30 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 30
        }
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    team = "team-data"
    env  = "staging"
  }
}

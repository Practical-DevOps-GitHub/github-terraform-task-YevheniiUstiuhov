terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "5.32.0"
    }
  }
}

provider "github" {
  token = "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"
}

resource "github_repository" "github-terraform-task-YevheniiUstiuhov" {
  name        = "github-terraform-task-YevheniiUstiuhov"
  description = "1"
  auto_init   = true
  owner       = "Practical-DevOps-GitHub"
}
resource "github_repository_collaborator" "collaborator" {
  repository = "github-terraform-task-YevheniiUstiuhov"
  username   = "softservedata"
  permission = "admin"
}
resource "github_branch_default" "develop"{
  repository = "github-terraform-task-YevheniiUstiuhov"
  branch     = "develop"
}
resource "github_branch_protection" "main" {
  repository_id = "github-terraform-task-YevheniiUstiuhov"
  pattern = "main"
  required_pull_request_reviews {
    dismiss_stale_reviews          = false
    require_code_owner_reviews     = true
    required_approving_review_count = 1
  }
}
resource "github_branch_protection" "develop" {
  repository_id = "github-terraform-task-YevheniiUstiuhov"
  pattern = "develop"
  required_pull_request_reviews {
    dismiss_stale_reviews          = false
    require_code_owner_reviews     = false
    required_approving_review_count = 2
  } 
}
resource "github_repository_file" "codeowners" {
  repository = "github-terraform-task-YevheniiUstiuhov"
  file       = "CODEOWNERS"
  content    = "main/* @softservedata\n"
}
resource "github_repository_file" "pull_request_template" {
  repository = github_repository.github-terraform-task-YevheniiUstiuhov.name
  file       = ".github/pull_request_template.md"
  content = <<-EOT
    Describe your changes

    Issue ticket number and link

    Checklist before requesting a review
    - [ ] I have performed a self-review of my code
    - [ ] If it is a core feature, I have added thorough tests
    - [ ] Do we need to implement analytics?
    - [ ] Will this be part of a product update? If yes, please write one phrase about this update
  EOT
}


resource "github_repository_deploy_key" "DEPLOY_KEY" {
  title      = "DEPLOY_KEY"
  repository = "github-terraform-task-YevheniiUstiuhov"
  key        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGoZ2CvnCSnlRhjSiEOMsorzXkkSVryyKTxD7uFQN/5i7EDFel00D4WLcbeS7cgna8VYhdU91q0u7zJiBHbh0P1oxMfocYrVgQgyWGn8c3xzPb+dWxk553Cz5xHg/2BPDVrP6Z5qMY1vxwoE3CjpWmUWJbsoIhOwgMx0gqkTR/TKFuZDMXWJwE2j7K5DYFOHdZsv+Pic+bSa6RJy55cELDCVogoF8doBF9yB+rq/kuvTfA+3teoulYKyAmEkwgJ39kYiP0kDZRzb2YgRnQV7s5XG9tnJy/c+F/fkhmHuxP2jI8fd7UmHQ3AnY4R6Fty5Rq/lpLdpLZmMOJXgS1z5WDFZihFWjvP96g6nsWkDA4t01ypQFTGNZuYZVL6667g/V/b0uR5paD4BTWCBSEXCJz4EgzEQACvMmAzig+t++ANY70jFL+M8A6qbHFpKHd+IVME4OvhsjrbScN+vbfFUy8OkJX5RYtvBSkzToIxZFH7Wd2BfZagZH/JL+YMsdGzjs= carlz@0258"
  read_only  = "false"
}
resource "github_actions_secret" "discord_webhook" {
  repository = "github-terraform-task-YevheniiUstiuhov"
  secret_name = "DISCORD_WEBHOOK_URL"
  plaintext_value = "https://discord.com/api/webhooks/1137341759391793193/JRBN3KxxVZOn73Fp9_cCUfyeNYLm8r2kWxeaLKLn3OZn1A-nBotvDVv8BnWsoQ1VMBN7"
}
resource "github_actions_secret" "github_pat" {
  repository    = "github-terraform-task-YevheniiUstiuhov"
  secret_name   = "PAT"
  plaintext_value = "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"
}
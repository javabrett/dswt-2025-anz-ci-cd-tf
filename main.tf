terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "6.6.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.96.0"
    }
  }
}

provider "github" {
  token = var.github_token
  owner = var.github_owner
}

provider "aws" {
  region = var.aws_region
}

locals {
  default_branch = "main"
}

resource "github_repository" "this" {
  name        = var.github_repository_name
  visibility  = "public"

  template {
    owner                = "javabrett"
    repository           = "dswt-2025-anz-ci-cd-template"
    include_all_branches = false
  }

  has_issues  = true
  has_wiki    = false
}

resource "github_branch_default" "main" {
  repository = github_repository.this.name
  branch     = local.default_branch
}

resource "github_branch_protection" "main" {
  repository_id = github_repository.this.node_id
  pattern       = github_branch_default.main.branch

  required_status_checks {
    strict   = true
    contexts = ["terraform-plan", "unit-tests"]
  }
  enforce_admins = true
  required_pull_request_reviews {
    dismiss_stale_reviews = true
  }
}

resource "github_actions_secret" "aws_role" {
  repository       = github_repository.this.name
  secret_name      = "AWS_ROLE_ARN"
  plaintext_value  = var.aws_role_arn
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.aws_s3_state_bucket_name
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.aws_dynamodb_lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

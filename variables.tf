variable "github_owner" {
  description = "GitHub organization or user that owns the repository"
  type        = string
}

variable "github_token" {
  description = "GitHub auth token"
  type        = string
}

variable "github_repository_name" {
  description = "GitHub repository name to create"
  type        = string
  default     = "dswt-2025-anz-ci-cd"
}

variable "aws_role_arn" {
  description = ""
  type        = string
}

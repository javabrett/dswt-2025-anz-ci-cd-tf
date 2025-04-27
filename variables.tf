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

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "aws_s3_state_bucket_name" {
  type    = string
  default = "dswt-2025-anz-ci-cd-terraform-state"
}

variable "aws_dynamodb_lock_table_name" {
  type    = string
  default = "dswt-2025-anz-ci-cd-terraform-locks"
}

variable "aws_role_arn" {
  description = ""
  type        = string
}

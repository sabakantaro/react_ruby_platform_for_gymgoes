variable "aws_access_key" {
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "database_name" {
  description = "RDS database name"
  type        = string
  default     = "gym_platform_db"
}

variable "database_username" {
  description = "RDS database username"
  type        = string
}

variable "database_password" {
  description = "RDS database password"
  type        = string
  sensitive   = true
}

variable "r_prefix" {
  description = "Resource prefix for naming"
  type        = string
  default     = "gym-platform"
}

variable "environment" {
  description = "Environment name (e.g., production, staging)"
  type        = string
  default     = "production"
}

variable "secret_key_base" {
  description = "Rails secret key base"
  type        = string
  sensitive   = true
  default     = ""
}

resource "random_password" "secret_key_base" {
  length  = 128
  special = false
}

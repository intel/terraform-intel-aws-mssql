variable "region" {
  description = "Target AWS region to deploy workloads in."
  type        = string
  default     = "us-west-1"
}

variable "db_password" {
  description = "Password for the master database user."
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.db_password) >= 8
    error_message = "The db_password value must be at least 8 characters in length."
  }
}


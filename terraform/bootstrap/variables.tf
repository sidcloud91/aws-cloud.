# Variables for Bootstrap Configuration

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "ap-south-1"
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.aws_region))
    error_message = "AWS region must be a valid region identifier."
  }
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
  default     = "sid-clouc-user"
}

variable "project_name" {
  description = "Name of the project (used for resource naming)"
  type        = string
  default     = "aws-learning"
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name)) && length(var.project_name) <= 20
    error_message = "Project name must be lowercase alphanumeric with hyphens, max 20 characters."
  }
}

variable "owner_email" {
  description = "Email of the project owner (for tagging)"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.owner_email))
    error_message = "Owner email must be a valid email address."
  }
}

variable "cost_center" {
  description = "Cost center code for billing (for tagging)"
  type        = string
  default     = "learning"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "bootstrap"
  validation {
    condition     = contains(["bootstrap", "dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: bootstrap, dev, staging, prod."
  }
}

variable "enable_versioning" {
  description = "Enable versioning on the S3 bucket"
  type        = bool
  default     = true
}

variable "enable_encryption" {
  description = "Enable encryption on the S3 bucket"
  type        = bool
  default     = true
}

variable "lifecycle_expiration_days" {
  description = "Number of days after which to expire old versions"
  type        = number
  default     = 30
  validation {
    condition     = var.lifecycle_expiration_days >= 1 && var.lifecycle_expiration_days <= 365
    error_message = "Lifecycle expiration days must be between 1 and 365."
  }
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 1
  validation {
    condition     = contains([1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653], var.log_retention_days)
    error_message = "Log retention days must be a valid CloudWatch retention period."
  }
}

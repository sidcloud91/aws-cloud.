# Variables for Development Environment

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "ap-south-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
  default     = "sid-clouc-user"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "aws-learning"
}

variable "owner_email" {
  description = "Email of the project owner"
  type        = string
  # No default - must be provided via tfvars file
}

variable "cost_center" {
  description = "Cost center code for billing"
  type        = string
  default     = "learning"
}

# Environment-specific variables
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type        = bool
  default     = false # Cost optimization for dev
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

# Backend configuration variables (for reference/documentation)
# Note: These cannot be used in backend block due to Terraform limitations
variable "backend_bucket" {
  description = "S3 bucket for Terraform state (reference only)"
  type        = string
  default     = "aws-learning-tfstate-603506755677-c977cb49"
}

variable "backend_dynamodb_table" {
  description = "DynamoDB table for state locking (reference only)"
  type        = string
  default     = "aws-learning-terraform-locks"
}

variable "backend_kms_key_id" {
  description = "KMS key for state encryption (reference only)"
  type        = string
  default     = "arn:aws:kms:ap-south-1:603506755677:key/812f82ab-7d2a-4a23-b3b7-51a2f3274a46"
}

# S3 Storage Module Variables
variable "s3_bucket_purpose" {
  description = "Purpose of the S3 bucket"
  type        = string
  default     = "application-data"
}

variable "s3_enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}

variable "s3_enable_encryption" {
  description = "Enable encryption for the S3 bucket"
  type        = bool
  default     = true
}

variable "s3_kms_key_id" {
  description = "KMS key ID for S3 encryption (null for AES256)"
  type        = string
  default     = null
}

variable "s3_block_public_access" {
  description = "Block public access to the S3 bucket"
  type        = bool
  default     = true
}

variable "s3_lifecycle_enabled" {
  description = "Enable lifecycle policy for the S3 bucket"
  type        = bool
  default     = true
}

variable "s3_expiration_days" {
  description = "Number of days after which objects expire"
  type        = number
  default     = 30
}

variable "s3_noncurrent_version_expiration_days" {
  description = "Number of days after which noncurrent versions expire"
  type        = number
  default     = 30
}

variable "s3_abort_incomplete_multipart_upload_days" {
  description = "Number of days after which incomplete multipart uploads are aborted"
  type        = number
  default     = 7
}

variable "s3_additional_tags" {
  description = "Additional tags for the S3 bucket"
  type        = map(string)
  default = {
    Purpose      = "Development Application Data"
    BackupPolicy = "Standard"
    DataClass    = "Internal"
  }
}

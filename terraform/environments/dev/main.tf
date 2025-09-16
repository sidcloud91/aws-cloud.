# Development Environment Configuration

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Backend configuration - configured via backend.hcl file
  # Run: tofu init -backend-config=backend.hcl
  backend "s3" {
    # Configuration provided via backend.hcl file during init
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = "dev"
      ManagedBy   = "Terraform"
      Owner       = var.owner_email
      CostCenter  = var.cost_center
    }
  }
}

# S3 Storage Module
module "storage" {
  source = "../../modules/storage"

  project_name   = var.project_name
  environment    = "dev"
  bucket_purpose = var.s3_bucket_purpose

  # Development-specific overrides
  enable_versioning = var.s3_enable_versioning
  enable_encryption = var.s3_enable_encryption
  kms_key_id        = var.s3_kms_key_id

  # Public access blocking (always true for security)
  block_public_access = var.s3_block_public_access

  # Lifecycle configuration
  lifecycle_enabled                      = var.s3_lifecycle_enabled
  expiration_days                        = var.s3_expiration_days
  noncurrent_version_expiration_days     = var.s3_noncurrent_version_expiration_days
  abort_incomplete_multipart_upload_days = var.s3_abort_incomplete_multipart_upload_days

  # Additional tags specific to development
  tags = var.s3_additional_tags
}

# Example: Use networking module
# module "networking" {
#   source = "../../modules/networking"
#
#   project_name = var.project_name
#   environment  = "dev"
#   vpc_cidr     = "10.0.0.0/16"
#
#   # Development-specific overrides
#   enable_nat_gateway = false  # Cost optimization for dev
#   single_nat_gateway = true   # Single NAT for dev
# }

# Example: Use compute module
# module "compute" {
#   source = "../../modules/compute"
#
#   project_name = var.project_name
#   environment  = "dev"
#
#   # Reference networking outputs
#   vpc_id     = module.networking.vpc_id
#   subnet_ids = module.networking.private_subnet_ids
#
#   # Development-specific configuration
#   instance_type = "t3.micro"  # Smaller instance for dev
#   min_size      = 1
#   max_size      = 2
# }

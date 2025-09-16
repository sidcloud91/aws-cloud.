# Outputs for Bootstrap Configuration

output "s3_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  value       = aws_s3_bucket.terraform_state.id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket for Terraform state"
  value       = aws_s3_bucket.terraform_state.arn
}

output "s3_bucket_region" {
  description = "Region of the S3 bucket"
  value       = aws_s3_bucket.terraform_state.region
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  value       = aws_dynamodb_table.terraform_locks.name
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table for state locking"
  value       = aws_dynamodb_table.terraform_locks.arn
}

output "kms_key_id" {
  description = "ID of the KMS key used for encryption"
  value       = aws_kms_key.terraform_state.key_id
}

output "kms_key_arn" {
  description = "ARN of the KMS key used for encryption"
  value       = aws_kms_key.terraform_state.arn
}

output "kms_alias_name" {
  description = "Alias name of the KMS key"
  value       = aws_kms_alias.terraform_state.name
}

output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group for Terraform operations"
  value       = aws_cloudwatch_log_group.terraform_operations.name
}

# Backend Configuration Template
output "backend_config" {
  description = "Backend configuration to use in other Terraform projects"
  value = {
    bucket         = aws_s3_bucket.terraform_state.id
    key            = "example/terraform.tfstate" # This should be customized per environment
    region         = var.aws_region
    encrypt        = true
    kms_key_id     = aws_kms_key.terraform_state.arn
    dynamodb_table = aws_dynamodb_table.terraform_locks.name

    # Optional: specify profile if using named profiles
    profile = var.aws_profile
  }
}

# Environment-specific backend configurations
output "dev_backend_config" {
  description = "Backend configuration for development environment"
  value = {
    bucket         = aws_s3_bucket.terraform_state.id
    key            = "environments/dev/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    kms_key_id     = aws_kms_key.terraform_state.arn
    dynamodb_table = aws_dynamodb_table.terraform_locks.name
    profile        = var.aws_profile
  }
}

output "staging_backend_config" {
  description = "Backend configuration for staging environment"
  value = {
    bucket         = aws_s3_bucket.terraform_state.id
    key            = "environments/staging/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    kms_key_id     = aws_kms_key.terraform_state.arn
    dynamodb_table = aws_dynamodb_table.terraform_locks.name
    profile        = var.aws_profile
  }
}

output "prod_backend_config" {
  description = "Backend configuration for production environment"
  value = {
    bucket         = aws_s3_bucket.terraform_state.id
    key            = "environments/prod/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    kms_key_id     = aws_kms_key.terraform_state.arn
    dynamodb_table = aws_dynamodb_table.terraform_locks.name
    profile        = var.aws_profile
  }
}

# Instructions for using the backend
output "setup_instructions" {
  description = "Instructions for setting up backend in other projects"
  value       = <<-EOT

    To use this backend in other Terraform projects, add this to your terraform block:

    terraform {
      backend "s3" {
        bucket         = "${aws_s3_bucket.terraform_state.id}"
        key            = "path/to/your/terraform.tfstate"
        region         = "${var.aws_region}"
        encrypt        = true
        kms_key_id     = "${aws_kms_key.terraform_state.arn}"
        dynamodb_table = "${aws_dynamodb_table.terraform_locks.name}"
        profile        = "${var.aws_profile}"
      }
    }

    Then run:
    terraform init

  EOT
}

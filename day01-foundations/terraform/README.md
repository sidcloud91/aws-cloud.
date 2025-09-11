# Day 01 - Foundations & Remote State

## Terraform Backend Configuration

This directory contains the foundational Terraform configuration for remote state management.

### Files to be created:
- `backend.tf` - S3 + DynamoDB backend configuration
- `iam.tf` - IAM roles and policies for Terraform execution
- `variables.tf` - Input variables
- `outputs.tf` - Output values
- `terraform.tfvars.example` - Example variable values

### Usage:
```bash
# Initialize backend
terraform init

# Plan changes
terraform plan

# Apply configuration
terraform apply
```

### Prerequisites:
- AWS CLI configured with appropriate permissions
- S3 bucket and DynamoDB table names decided
- KMS key for encryption

*This file will be replaced with actual Terraform configuration during Day 01 execution.*

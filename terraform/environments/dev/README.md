# Development Environment

This directory contains the Terraform configuration for the development environment.

## Prerequisites

1. **AWS CLI configured** with the profile specified in `dev.tfvars`
2. **OpenTofu installed** (version >= 1.0)
3. **Backend infrastructure deployed** using the bootstrap configuration

## File Structure

- `main.tf` - Main Terraform configuration with module calls
- `variables.tf` - Variable definitions
- `outputs.tf` - Output values
- `dev.tfvars` - Development-specific variable values
- `backend.hcl` - Backend configuration for remote state
- `.terraform.lock.hcl` - Provider version lock file

## Usage

### Initialize the environment
```bash
# Initialize with backend configuration
tofu init -backend-config=backend.hcl
```

### Plan and Apply
```bash
# Plan with development variables
tofu plan -var-file=dev.tfvars

# Apply with development variables
tofu apply -var-file=dev.tfvars
```

### Destroy resources
```bash
# Destroy with development variables
tofu destroy -var-file=dev.tfvars
```

## Configuration

### Required Variables
Edit `dev.tfvars` to customize the following:

- `owner_email` - **REQUIRED** - Update with your actual email
- `aws_region` - AWS region for resources
- `aws_profile` - AWS CLI profile to use
- `project_name` - Name of the project

### S3 Configuration
The S3 module is configured with development-appropriate settings:
- Versioning enabled
- AES256 encryption (no KMS for cost optimization)
- Lifecycle policy with 30-day expiration
- Public access blocked

### Cost Optimization
Development environment is configured for cost optimization:
- No NAT Gateway
- Small instance types (t3.micro)
- Shorter retention periods

## Modules Used

- **Storage Module** (`../../modules/storage`) - S3 bucket with security best practices

## Remote State

State is stored remotely in S3 with:
- DynamoDB locking
- KMS encryption
- Versioning enabled

Backend configuration is in `backend.hcl` and initialized during `tofu init`.

## Security

- All S3 buckets have public access blocked
- Default encryption enabled
- Provider-level default tags applied
- State encrypted with KMS

## Next Steps

1. Update `owner_email` in `dev.tfvars`
2. Review and customize other variables as needed
3. Run `tofu plan -var-file=dev.tfvars` to see planned changes
4. Apply with `tofu apply -var-file=dev.tfvars`

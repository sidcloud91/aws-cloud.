# Terraform Backend Bootstrap Guide

This guide walks you through setting up a secure Terraform backend with S3 state storage and DynamoDB state locking.

## Prerequisites

### 1. Required Tools
- AWS CLI v2 (installed and configured)
- Terraform >= 1.0
- Bash shell (for automation scripts)

### 2. AWS Permissions
Ensure your IAM user has the following permissions:
- S3: Full access for backend bucket management
- DynamoDB: Full access for state locking
- KMS: Key management for encryption
- IAM: Required for Terraform operations

### 3. AWS CLI Configuration
```bash
# Verify your AWS configuration
aws sts get-caller-identity --profile sid-clouc-user
aws configure list --profile sid-clouc-user
```

## Quick Setup (Automated)

### 1. Run Bootstrap Script
```bash
cd terraform-project/bootstrap
chmod +x ../scripts/bootstrap-setup.sh
../scripts/bootstrap-setup.sh
```

The script will:
- Check prerequisites
- Validate AWS permissions
- Create `terraform.tfvars` from example
- Initialize and apply Terraform configuration
- Display backend configuration for other projects

## Manual Setup (Step by Step)

### 1. Navigate to Bootstrap Directory
```bash
cd terraform-project/bootstrap
```

### 2. Create Terraform Variables
```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` and update:
```hcl
owner_email = "your-email@example.com"  # Replace with your email
```

### 3. Initialize Terraform
```bash
terraform init
```

### 4. Review the Plan
```bash
terraform plan
```

This will show you the resources that will be created:
- S3 bucket for state storage (with versioning and encryption)
- DynamoDB table for state locking
- KMS key for encryption
- IAM policies for bucket access

### 5. Apply Configuration
```bash
terraform apply
```

Review the output and type `yes` to confirm.

### 6. Note the Outputs
After successful apply, note the outputs:
```bash
terraform output
```

You'll see:
- `s3_bucket_name`: Your state bucket name
- `dynamodb_table_name`: State locking table name
- `kms_key_arn`: Encryption key ARN

## Backend Configuration for Other Projects

After bootstrap setup, use this configuration in other Terraform projects:

```hcl
terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket         = "<s3_bucket_name_from_output>"
    key            = "environments/dev/terraform.tfstate"  # Customize path
    region         = "ap-south-1"
    encrypt        = true
    kms_key_id     = "<kms_key_arn_from_output>"
    dynamodb_table = "<dynamodb_table_name_from_output>"
    profile        = "sid-clouc-user"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```

## Environment-Specific Setup

### Development Environment
```bash
cd terraform-project/environments/dev
```

Edit `backend.tf`:
```hcl
terraform {
  backend "s3" {
    bucket         = "<your-bucket-name>"
    key            = "environments/dev/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    kms_key_id     = "<your-kms-key-arn>"
    dynamodb_table = "<your-dynamodb-table>"
    profile        = "sid-clouc-user"
  }
}
```

Initialize the environment:
```bash
terraform init
terraform workspace new dev  # Optional: use workspaces
```

### Staging Environment
```bash
cd terraform-project/environments/staging
```

Follow the same process but use:
```hcl
key = "environments/staging/terraform.tfstate"
```

### Production Environment
```bash
cd terraform-project/environments/prod
```

Follow the same process but use:
```hcl
key = "environments/prod/terraform.tfstate"
```

## State Locking Verification

### Test State Locking
1. Start a Terraform operation in one terminal:
   ```bash
   terraform plan
   ```

2. Try to run another operation in a different terminal:
   ```bash
   terraform plan
   ```

You should see a message about state being locked.

### Check DynamoDB Lock Table
```bash
aws dynamodb scan \
  --table-name <your-dynamodb-table> \
  --profile sid-clouc-user
```

## Security Best Practices

### 1. Bucket Security
- ✅ Versioning enabled
- ✅ Server-side encryption (KMS)
- ✅ Public access blocked
- ✅ Lifecycle policies configured

### 2. Access Control
- ✅ Least privilege IAM policies
- ✅ MFA requirements for sensitive operations
- ✅ Separate environments with different keys

### 3. State File Security
- ✅ Encrypted at rest and in transit
- ✅ Access logging enabled
- ✅ Regular backups via versioning

## Troubleshooting

### Common Issues

#### 1. Permission Denied
```bash
# Check your AWS credentials
aws sts get-caller-identity --profile sid-clouc-user

# Verify IAM permissions
aws iam get-user --profile sid-clouc-user
```

#### 2. State Lock Issues
```bash
# Force unlock if needed (use carefully)
terraform force-unlock <lock-id>

# Check DynamoDB table
aws dynamodb describe-table \
  --table-name <your-table> \
  --profile sid-clouc-user
```

#### 3. Bucket Access Issues
```bash
# Test bucket access
aws s3 ls s3://<your-bucket> --profile sid-clouc-user

# Check bucket policy
aws s3api get-bucket-policy \
  --bucket <your-bucket> \
  --profile sid-clouc-user
```

### 4. KMS Key Issues
```bash
# List KMS keys
aws kms list-keys --profile sid-clouc-user

# Describe key
aws kms describe-key \
  --key-id <your-key-id> \
  --profile sid-clouc-user
```

## Cleanup (If Needed)

⚠️ **Warning**: This will destroy your backend infrastructure!

```bash
cd terraform-project/bootstrap
terraform destroy
```

## Next Steps

1. **Set up environments**: Configure dev, staging, and prod environments
2. **Create modules**: Build reusable Terraform modules
3. **Implement CI/CD**: Set up automated deployments
4. **Add monitoring**: Implement state file monitoring and alerts

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Review Terraform and AWS documentation
3. Ensure all prerequisites are met
4. Verify IAM permissions are correctly configured

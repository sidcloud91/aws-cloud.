# Quick Start: Terraform Backend Setup

Follow these steps to set up your Terraform backend with S3 state storage and DynamoDB locking.

## 🚀 Quick Setup (5 minutes)

### 1. Bootstrap the Backend Infrastructure

```bash
cd bootstrap
../scripts/bootstrap-setup.sh
```

This automated script will:
- ✅ Check all prerequisites
- ✅ Validate AWS permissions
- ✅ Create and apply Terraform configuration
- ✅ Display backend configuration for other projects

### 2. Use Backend in Your Projects

Copy the backend configuration displayed by the script and add it to your Terraform projects:

```hcl
terraform {
  backend "s3" {
    bucket         = "your-bucket-name"
    key            = "path/to/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    kms_key_id     = "your-kms-key-arn"
    dynamodb_table = "your-table-name"
    profile        = "sid-clouc-user"
  }
}
```

### 3. Initialize Environment

```bash
cd environments/dev
terraform init
```

## 🛠 Environment Management

Use the environment manager script for easy operations:

```bash
# Initialize development environment
./scripts/env-manager.sh dev init

# Plan changes
./scripts/env-manager.sh dev plan

# Apply changes (with confirmation)
./scripts/env-manager.sh dev apply

# Auto-approve apply
./scripts/env-manager.sh dev apply --auto-approve

# Show outputs
./scripts/env-manager.sh dev output

# Destroy environment (requires confirmation)
./scripts/env-manager.sh dev destroy
```

## 📁 Project Structure

```
aws-cloud/
├── bootstrap/           # Backend infrastructure setup
├── environments/        # Environment-specific configurations
│   ├── dev/            # Development environment
│   ├── staging/        # Staging environment
│   └── prod/           # Production environment
├── modules/            # Reusable Terraform modules
├── shared/             # Shared configurations
├── scripts/            # Automation scripts
├── docs/              # Documentation
├── day01-foundations/  # Learning materials
├── day02-networking/   # Daily exercises
└── ...                # Additional learning content
```

## 🔐 Security Features

- **Encryption**: KMS encryption for S3 bucket and DynamoDB
- **Access Control**: IAM policies for least privilege access
- **State Locking**: DynamoDB prevents concurrent modifications
- **Versioning**: S3 versioning for state file history
- **Lifecycle**: Automated cleanup of old state versions

## 📚 Next Steps

1. **Explore Documentation**: Read `docs/BACKEND-SETUP.md` for detailed instructions
2. **Create Infrastructure**: Start building your AWS resources in the `environments/` directories
3. **Build Modules**: Create reusable modules in the `modules/` directory
4. **Set Up CI/CD**: Integrate with your CI/CD pipeline

## 🆘 Need Help?

- Check `docs/BACKEND-SETUP.md` for detailed troubleshooting
- Run `./scripts/env-manager.sh --help` for environment management help
- Verify AWS CLI access: `aws sts get-caller-identity --profile sid-clouc-user`

Happy Infrastructure Coding! 🎉

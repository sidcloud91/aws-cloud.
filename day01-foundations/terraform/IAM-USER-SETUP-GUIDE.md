# IAM User Setup Guide for AWS Cloud Learning Project

## Overview
This guide will help you create an IAM user with the appropriate permissions to complete your 14-day AWS learning journey. The user will have access to all AWS services required for the project while maintaining security best practices.

## Prerequisites
- AWS CLI installed and configured with admin privileges (for initial setup)
- Access to AWS Console with administrative permissions
- Basic understanding of IAM concepts

## Method 1: AWS Console Setup (Recommended for Beginners)

### Step 1: Create the IAM User
1. **Login to AWS Console**
   - Navigate to [AWS Console](https://console.aws.amazon.com/)
   - Go to IAM service

2. **Create User**
   - Click "Users" → "Create user"
   - Username: `aws-learning-user` (or your preferred name)
   - Select "Provide user access to the AWS Management Console"
   - Choose "I want to create an IAM user"
   - Set a strong password
   - ✅ **Enable**: "User must create a new password at next sign-in" (recommended)

### Step 2: Create Custom Policy
1. **Navigate to Policies**
   - Go to IAM → Policies → "Create policy"
   - Click "JSON" tab

2. **Copy Policy JSON**
   - Copy the contents from `iam-user-policy.json` file
   - Paste into the JSON editor
   - Click "Next: Tags"

3. **Configure Policy**
   - **Name**: `AWS-Learning-Project-Policy`
   - **Description**: `Comprehensive permissions for 14-day AWS learning project including VPC, EC2, EKS, RDS, Lambda, S3, and monitoring services`
   - Click "Create policy"

### Step 3: Attach Policy to User
1. **Find Your User**
   - Go to IAM → Users → Select your user
   - Click "Permissions" tab

2. **Add Permissions**
   - Click "Add permissions" → "Attach policies directly"
   - Search for `AWS-Learning-Project-Policy`
   - Select the policy and click "Add permissions"

### Step 4: Create Access Keys
1. **Generate Access Keys**
   - In user details, click "Security credentials" tab
   - Scroll to "Access keys" section
   - Click "Create access key"
   - Select "Command Line Interface (CLI)"
   - Add optional description tag: "AWS Learning Project - 14 Day Plan"
   - Download the CSV file ⚠️ **IMPORTANT: Store securely**

## Method 2: AWS CLI Setup (Advanced Users)

### Step 1: Create the Policy
```bash
# Create the policy using AWS CLI
aws iam create-policy \\
    --policy-name AWS-Learning-Project-Policy \\
    --policy-document file://iam-user-policy.json \\
    --description "Comprehensive permissions for 14-day AWS learning project"
```

### Step 2: Create the User
```bash
# Create IAM user
aws iam create-user \\
    --user-name aws-learning-user \\
    --tags Key=Project,Value=AWSLearning Key=Duration,Value=14Days

# Create login profile (console access)
aws iam create-login-profile \\
    --user-name aws-learning-user \\
    --password "TempPassword123!" \\
    --password-reset-required
```

### Step 3: Attach Policy
```bash
# Get your account ID
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

# Attach the policy
aws iam attach-user-policy \\
    --user-name aws-learning-user \\
    --policy-arn arn:aws:iam::${ACCOUNT_ID}:policy/AWS-Learning-Project-Policy
```

### Step 4: Create Access Keys
```bash
# Create access keys
aws iam create-access-key \\
    --user-name aws-learning-user \\
    --output table
```

## Security Configuration

### Step 1: Configure AWS CLI with New User
```bash
# Configure AWS CLI profile
aws configure --profile aws-learning
# Enter the Access Key ID
# Enter the Secret Access Key
# Default region: us-east-1 (or your preferred region)
# Default output format: json
```

### Step 2: Test Configuration
```bash
# Test the setup
aws sts get-caller-identity --profile aws-learning

# Expected output should show:
# - UserId: AIDA... (your user ID)
# - Account: Your account number
# - Arn: arn:aws:iam::ACCOUNT:user/aws-learning-user
```

### Step 3: Set Environment Variables (Optional)
```bash
# Add to your ~/.zshrc or ~/.bash_profile
export AWS_PROFILE=aws-learning
export AWS_DEFAULT_REGION=us-east-1

# Or create a script for the project
cat > aws-learning-env.sh << 'EOF'
#!/bin/bash
export AWS_PROFILE=aws-learning
export AWS_DEFAULT_REGION=us-east-1
echo "AWS Learning environment configured"
echo "Profile: $AWS_PROFILE"
echo "Region: $AWS_DEFAULT_REGION"
EOF

chmod +x aws-learning-env.sh
```

## Validation Steps

### 1. Test Core Permissions
```bash
# Test VPC permissions
aws ec2 describe-vpcs --profile aws-learning

# Test S3 permissions
aws s3 ls --profile aws-learning

# Test IAM permissions (should work)
aws iam list-users --profile aws-learning

# Test EKS permissions
aws eks list-clusters --profile aws-learning
```

### 2. Terraform Validation
```bash
# Navigate to your project directory
cd /Users/sidhardhavaddi/Desktop/2025/Projects/AWS/aws-cloud./day01-foundations/terraform/

# Initialize Terraform (when you create backend config)
terraform init

# Validate configuration
terraform validate

# Plan (when you have resources defined)
terraform plan
```

## Important Security Notes

### ⚠️ Security Best Practices
1. **Rotate Access Keys**: Rotate every 90 days
2. **Use MFA**: Enable MFA for console access
3. **Principle of Least Privilege**: Review permissions after project completion
4. **Monitor Usage**: Enable CloudTrail for audit logging
5. **Secure Storage**: Never commit access keys to Git

### 🔒 After Project Completion
```bash
# Deactivate access keys
aws iam update-access-key \\
    --user-name aws-learning-user \\
    --access-key-id YOUR_ACCESS_KEY \\
    --status Inactive

# Delete user (after cleaning up resources)
aws iam detach-user-policy \\
    --user-name aws-learning-user \\
    --policy-arn arn:aws:iam::ACCOUNT:policy/AWS-Learning-Project-Policy

aws iam delete-access-key \\
    --user-name aws-learning-user \\
    --access-key-id YOUR_ACCESS_KEY

aws iam delete-login-profile --user-name aws-learning-user
aws iam delete-user --user-name aws-learning-user
```

## Troubleshooting

### Common Issues
1. **"Access Denied" errors**: Verify policy attachment and JSON syntax
2. **"User already exists"**: Choose a different username
3. **"Invalid policy document"**: Validate JSON syntax
4. **CLI not working**: Check AWS CLI configuration and credentials

### Getting Help
- AWS IAM documentation: https://docs.aws.amazon.com/iam/
- AWS CLI reference: https://docs.aws.amazon.com/cli/
- Project repository: Check `day01-foundations/` for specific configuration

## Cost Management
- The IAM user itself has no cost
- Monitor usage with AWS Cost Explorer
- Set up billing alerts (covered in Day 10)
- Clean up resources after each day to avoid charges

---

**Next Steps:**
1. Complete this IAM setup
2. Proceed to `day01-foundations/terraform/` for backend configuration
3. Follow the daily plans in `docs/daily/` directory

**Questions?** Review the ADR-0001 document for architecture decisions or check the daily planning documents.

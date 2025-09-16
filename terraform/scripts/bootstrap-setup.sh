#!/bin/bash

# Terraform Bootstrap Setup Script
# This script initializes the Terraform backend infrastructure

set -e

# Configuration
PROJECT_NAME="aws-learning"
AWS_PROFILE="sid-clouc-user"
AWS_REGION="ap-south-1"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."

    # Check if AWS CLI is installed
    if ! command -v aws &> /dev/null; then
        print_error "AWS CLI is not installed. Please install it first."
        exit 1
    fi

    # Check if Terraform is installed
    if ! command -v terraform &> /dev/null; then
        print_error "Terraform is not installed. Please install it first."
        exit 1
    fi

    # Check AWS credentials
    if ! aws sts get-caller-identity --profile $AWS_PROFILE &> /dev/null; then
        print_error "AWS credentials not configured for profile: $AWS_PROFILE"
        print_error "Please run: aws configure --profile $AWS_PROFILE"
        exit 1
    fi

    print_success "Prerequisites check passed!"
}

# Function to validate AWS permissions
validate_permissions() {
    print_status "Validating AWS permissions..."

    # Test S3 permissions
    if aws s3 ls --profile $AWS_PROFILE &> /dev/null; then
        print_success "S3 permissions validated"
    else
        print_error "S3 permissions validation failed"
        exit 1
    fi

    # Test DynamoDB permissions
    if aws dynamodb list-tables --profile $AWS_PROFILE &> /dev/null; then
        print_success "DynamoDB permissions validated"
    else
        print_error "DynamoDB permissions validation failed"
        exit 1
    fi

    # Test KMS permissions
    if aws kms list-keys --profile $AWS_PROFILE &> /dev/null; then
        print_success "KMS permissions validated"
    else
        print_error "KMS permissions validation failed"
        exit 1
    fi
}

# Function to setup Terraform variables
setup_terraform_vars() {
    print_status "Setting up Terraform variables..."

    if [ ! -f "terraform.tfvars" ]; then
        if [ -f "terraform.tfvars.example" ]; then
            cp terraform.tfvars.example terraform.tfvars
            print_warning "Created terraform.tfvars from example. Please edit with your values."
            print_warning "Make sure to update owner_email in terraform.tfvars"

            # Prompt for email if not set
            read -p "Enter your email address: " email
            if [ ! -z "$email" ]; then
                sed -i.bak "s/your-email@example.com/$email/" terraform.tfvars
                rm terraform.tfvars.bak
                print_success "Updated owner_email in terraform.tfvars"
            fi
        else
            print_error "terraform.tfvars.example not found"
            exit 1
        fi
    else
        print_success "terraform.tfvars already exists"
    fi
}

# Function to initialize and apply Terraform
run_terraform() {
    print_status "Initializing Terraform..."
    terraform init

    print_status "Validating Terraform configuration..."
    terraform validate

    print_status "Planning Terraform changes..."
    terraform plan

    print_warning "This will create AWS resources that may incur costs."
    read -p "Do you want to continue? (y/N): " confirm

    if [[ $confirm =~ ^[Yy]$ ]]; then
        print_status "Applying Terraform configuration..."
        terraform apply -auto-approve
        print_success "Terraform bootstrap completed!"
    else
        print_warning "Terraform apply cancelled by user"
        exit 0
    fi
}

# Function to display backend configuration
show_backend_config() {
    print_status "Retrieving backend configuration..."

    BUCKET_NAME=$(terraform output -raw s3_bucket_name)
    DYNAMODB_TABLE=$(terraform output -raw dynamodb_table_name)
    KMS_KEY_ARN=$(terraform output -raw kms_key_arn)

    echo ""
    print_success "=== Backend Configuration ==="
    echo ""
    echo "Add this to your terraform block in other projects:"
    echo ""
    echo "terraform {"
    echo "  backend \"s3\" {"
    echo "    bucket         = \"$BUCKET_NAME\""
    echo "    key            = \"path/to/your/terraform.tfstate\""
    echo "    region         = \"$AWS_REGION\""
    echo "    encrypt        = true"
    echo "    kms_key_id     = \"$KMS_KEY_ARN\""
    echo "    dynamodb_table = \"$DYNAMODB_TABLE\""
    echo "    profile        = \"$AWS_PROFILE\""
    echo "  }"
    echo "}"
    echo ""
    print_success "=== Setup Complete ==="
}

# Main execution
main() {
    print_status "Starting Terraform Bootstrap Setup..."
    print_status "Project: $PROJECT_NAME"
    print_status "AWS Profile: $AWS_PROFILE"
    print_status "AWS Region: $AWS_REGION"
    echo ""

    check_prerequisites
    validate_permissions
    setup_terraform_vars
    run_terraform
    show_backend_config

    print_success "Bootstrap setup completed successfully!"
    print_status "You can now use the backend configuration in other Terraform projects."
}

# Run main function
main

#!/bin/bash

# Terraform State Migration Script
# This script helps migrate existing Terraform state to the new S3 backend

set -e

# Configuration
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

# Function to backup local state
backup_local_state() {
    if [ -f "terraform.tfstate" ]; then
        print_status "Backing up local state file..."
        cp terraform.tfstate terraform.tfstate.backup.$(date +%Y%m%d_%H%M%S)
        print_success "Local state backed up"
    else
        print_status "No local state file found - this is normal for new projects"
    fi
}

# Function to initialize with new backend
init_with_backend() {
    print_status "Initializing with new S3 backend..."

    if [ -f "terraform.tfstate" ]; then
        print_warning "Local state detected - Terraform will migrate it to S3"
        terraform init -migrate-state
    else
        terraform init
    fi

    print_success "Backend initialization completed"
}

# Function to verify backend configuration
verify_backend() {
    print_status "Verifying backend configuration..."

    # Check if state is properly stored in S3
    if terraform state list &> /dev/null; then
        print_success "Backend configuration verified"
    else
        print_error "Backend verification failed"
        exit 1
    fi
}

# Function to display usage
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -b, --backup   Only backup local state (don't migrate)"
    echo "  -v, --verify   Only verify backend configuration"
    echo ""
    echo "This script helps migrate existing Terraform state to S3 backend."
    echo "Make sure you have already set up the backend infrastructure."
}

# Main migration function
migrate_state() {
    print_status "Starting Terraform state migration..."

    # Check if backend.tf exists
    if [ ! -f "backend.tf" ]; then
        print_error "backend.tf not found in current directory"
        print_error "Please ensure you're in the correct Terraform project directory"
        exit 1
    fi

    backup_local_state
    init_with_backend
    verify_backend

    print_success "State migration completed successfully!"
    print_status "Your Terraform state is now stored in S3 with DynamoDB locking"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_usage
            exit 0
            ;;
        -b|--backup)
            backup_local_state
            exit 0
            ;;
        -v|--verify)
            verify_backend
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Run migration
migrate_state

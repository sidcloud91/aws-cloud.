#!/bin/bash

# Terraform Environment Management Script
# This script helps manage different Terraform environments (dev, staging, prod)

set -e

# Configuration
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
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

# Function to show usage
show_usage() {
    echo "Usage: $0 <environment> <action> [options]"
    echo ""
    echo "Environments:"
    echo "  dev        Development environment"
    echo "  staging    Staging environment"
    echo "  prod       Production environment"
    echo ""
    echo "Actions:"
    echo "  init       Initialize the environment"
    echo "  plan       Plan changes"
    echo "  apply      Apply changes"
    echo "  destroy    Destroy infrastructure"
    echo "  output     Show outputs"
    echo "  state      Manage state (list, show, etc.)"
    echo ""
    echo "Options:"
    echo "  --auto-approve    Auto approve apply/destroy"
    echo "  --var-file=FILE   Use specific variable file"
    echo "  -h, --help        Show this help"
    echo ""
    echo "Examples:"
    echo "  $0 dev init"
    echo "  $0 dev plan"
    echo "  $0 dev apply --auto-approve"
    echo "  $0 staging plan --var-file=custom.tfvars"
    echo "  $0 prod destroy"
}

# Function to validate environment
validate_environment() {
    local env=$1
    case $env in
        dev|staging|prod)
            return 0
            ;;
        *)
            print_error "Invalid environment: $env"
            print_error "Valid environments: dev, staging, prod"
            return 1
            ;;
    esac
}

# Function to setup environment directory
setup_env_dir() {
    local env=$1
    local env_dir="$PROJECT_ROOT/environments/$env"

    if [ ! -d "$env_dir" ]; then
        print_error "Environment directory not found: $env_dir"
        return 1
    fi

    cd "$env_dir"
    print_status "Working in: $env_dir"
}

# Function to initialize environment
init_environment() {
    local env=$1
    print_status "Initializing $env environment..."

    terraform init

    # Create workspace if it doesn't exist
    if ! terraform workspace select "$env" 2>/dev/null; then
        print_status "Creating workspace: $env"
        terraform workspace new "$env"
    fi

    print_success "$env environment initialized"
}

# Function to plan changes
plan_changes() {
    local env=$1
    local var_file=$2

    print_status "Planning changes for $env environment..."

    local plan_args="-out=$env.tfplan"

    if [ ! -z "$var_file" ]; then
        plan_args="$plan_args -var-file=$var_file"
    elif [ -f "terraform.tfvars" ]; then
        plan_args="$plan_args -var-file=terraform.tfvars"
    elif [ -f "$env.tfvars" ]; then
        plan_args="$plan_args -var-file=$env.tfvars"
    fi

    terraform plan $plan_args
    print_success "Plan saved to $env.tfplan"
}

# Function to apply changes
apply_changes() {
    local env=$1
    local auto_approve=$2

    print_status "Applying changes for $env environment..."

    if [ -f "$env.tfplan" ]; then
        terraform apply "$env.tfplan"
        rm "$env.tfplan"
        print_success "Plan applied and removed"
    else
        local apply_args=""
        if [ "$auto_approve" = "true" ]; then
            apply_args="-auto-approve"
        fi

        terraform apply $apply_args
    fi

    print_success "$env environment updated"
}

# Function to destroy infrastructure
destroy_infrastructure() {
    local env=$1
    local auto_approve=$2

    print_warning "This will destroy ALL infrastructure in $env environment!"

    if [ "$auto_approve" != "true" ]; then
        read -p "Are you absolutely sure? Type 'destroy-$env' to confirm: " confirm
        if [ "$confirm" != "destroy-$env" ]; then
            print_status "Destroy cancelled"
            return 0
        fi
    fi

    print_status "Destroying $env environment..."

    local destroy_args=""
    if [ "$auto_approve" = "true" ]; then
        destroy_args="-auto-approve"
    fi

    terraform destroy $destroy_args
    print_success "$env environment destroyed"
}

# Function to show outputs
show_outputs() {
    local env=$1
    print_status "Outputs for $env environment:"
    terraform output
}

# Function to manage state
manage_state() {
    local env=$1
    shift
    local state_args="$@"

    print_status "Managing state for $env environment..."
    terraform state $state_args
}

# Parse arguments
if [ $# -lt 2 ]; then
    show_usage
    exit 1
fi

ENVIRONMENT=$1
ACTION=$2
shift 2

# Parse options
AUTO_APPROVE=false
VAR_FILE=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --auto-approve)
            AUTO_APPROVE=true
            shift
            ;;
        --var-file=*)
            VAR_FILE="${1#*=}"
            shift
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            STATE_ARGS="$STATE_ARGS $1"
            shift
            ;;
    esac
done

# Validate inputs
if ! validate_environment "$ENVIRONMENT"; then
    exit 1
fi

if ! setup_env_dir "$ENVIRONMENT"; then
    exit 1
fi

# Execute action
case $ACTION in
    init)
        init_environment "$ENVIRONMENT"
        ;;
    plan)
        plan_changes "$ENVIRONMENT" "$VAR_FILE"
        ;;
    apply)
        apply_changes "$ENVIRONMENT" "$AUTO_APPROVE"
        ;;
    destroy)
        destroy_infrastructure "$ENVIRONMENT" "$AUTO_APPROVE"
        ;;
    output)
        show_outputs "$ENVIRONMENT"
        ;;
    state)
        manage_state "$ENVIRONMENT" $STATE_ARGS
        ;;
    *)
        print_error "Invalid action: $ACTION"
        show_usage
        exit 1
        ;;
esac

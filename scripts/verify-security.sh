#!/bin/bash

# Security Setup Verification Script
# This script verifies that all security tools are properly installed and configured

set -e

echo "🔒 Verifying Security Setup..."
echo "================================"

# Check if git-secrets is installed
if command -v git-secrets &> /dev/null; then
    echo "✅ git-secrets is installed"
    git secrets --list || echo "⚠️  No git-secrets patterns configured"
else
    echo "❌ git-secrets is not installed"
    exit 1
fi

# Check if pre-commit is installed
if command -v pre-commit &> /dev/null; then
    echo "✅ pre-commit is installed"
else
    echo "❌ pre-commit is not installed"
    exit 1
fi

# Check if detect-secrets is installed
if command -v detect-secrets &> /dev/null; then
    echo "✅ detect-secrets is installed"
else
    echo "❌ detect-secrets is not installed"
    exit 1
fi

# Check if hooks are installed
if [ -f ".git/hooks/pre-commit" ]; then
    echo "✅ Pre-commit hooks are installed"
else
    echo "❌ Pre-commit hooks are not installed"
    exit 1
fi

# Check if configuration files exist
if [ -f ".pre-commit-config.yaml" ]; then
    echo "✅ Pre-commit configuration exists"
else
    echo "❌ Pre-commit configuration missing"
    exit 1
fi

if [ -f ".secrets.baseline" ]; then
    echo "✅ Detect-secrets baseline exists"
else
    echo "❌ Detect-secrets baseline missing"
    exit 1
fi

if [ -f ".gitignore" ]; then
    echo "✅ .gitignore exists"
else
    echo "❌ .gitignore missing"
    exit 1
fi

echo ""
echo "🎉 Security setup verification complete!"
echo ""
echo "Security tools configured:"
echo "- Git-secrets: Prevents AWS credentials and secrets"
echo "- Pre-commit: Multi-hook framework for code quality"
echo "- Detect-secrets: Advanced secret detection"
echo "- Comprehensive .gitignore: Prevents sensitive files"
echo ""
echo "Next steps:"
echo "1. Update owner_email in dev.tfvars"
echo "2. Run: tofu plan -var-file=dev.tfvars"
echo "3. Run: tofu apply -var-file=dev.tfvars"
echo "4. Commit and push your code securely!"

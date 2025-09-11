# Day 03 - IAM Strategy Implementation

## IAM Roles and Policies

This directory implements enterprise IAM patterns with least privilege.

### Roles to be created:
- Platform Admin (limited administrative access)
- Read-Only (audit and monitoring)
- CI/CD Deployer (automated deployment)

### Features:
- Least privilege policies
- Cross-account trust relationships
- Service Control Policies (SCP) draft
- Access Analyzer integration

### Files planned:
- `roles.tf` - IAM role definitions
- `policies.tf` - Custom policy documents
- `scp.tf` - Service Control Policy examples
- `data.tf` - AWS managed policy references

*Implementation scheduled for Day 03.*

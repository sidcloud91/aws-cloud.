# Day 02 - VPC Networking Module

## Multi-Tier VPC Configuration

This directory contains Terraform modules for creating a production-ready VPC.

### Architecture:
- Public subnets (internet gateway)
- App subnets (private with NAT)
- Data subnets (private, no internet)
- VPC endpoints for AWS services

### Files to be created:
- `main.tf` - VPC resource definitions
- `subnets.tf` - Subnet configurations
- `routing.tf` - Route tables and associations
- `endpoints.tf` - VPC endpoints (S3, SSM)
- `security.tf` - Security groups and NACLs
- `outputs.tf` - Network resource IDs

### Outputs:
- VPC ID
- Subnet IDs by tier
- Route table IDs
- Security group IDs

*Implementation planned for Day 02.*

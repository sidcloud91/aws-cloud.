# Day 11 - EKS Cluster Provisioning

## Amazon EKS with Managed Node Groups

Production-ready Kubernetes cluster configuration.

### EKS Features:
- Managed control plane
- IRSA (IAM Roles for Service Accounts)
- Cluster logging enabled
- Private endpoint access

### Node Group Configuration:
- Managed node groups
- Auto Scaling enabled
- Bottlerocket or Amazon Linux 2
- Instance diversity for cost optimization

### Security:
- Pod security policies
- Network policies
- Secret encryption
- VPC integration

### Files to implement:
- `eks.tf` - Cluster configuration
- `node-groups.tf` - Worker node setup
- `irsa.tf` - Service account roles
- `addons.tf` - EKS addons

*EKS implementation for Day 11.*

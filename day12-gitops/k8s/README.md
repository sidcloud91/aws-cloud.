# Day 12 - GitOps and Kubernetes Add-ons

## ArgoCD and Cluster Add-ons

GitOps workflow with essential Kubernetes controllers.

### ArgoCD Setup:
- ArgoCD installation via Helm
- Application of applications pattern
- Multi-environment management
- Secret management integration

### Add-ons to deploy:
- AWS Load Balancer Controller
- External DNS
- Cluster Autoscaler
- Metrics Server

### Directory Structure:
```
k8s/
├── argocd/
│   ├── values.yaml
│   └── applications/
├── addons/
│   ├── aws-load-balancer-controller/
│   ├── external-dns/
│   └── cluster-autoscaler/
└── manifests/
```

*Kubernetes manifests for Day 12.*

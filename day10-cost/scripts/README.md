# Day 10 - Cost Optimization Scripts

## Tag Audit and Cost Management

PowerShell scripts for cost governance and tag compliance.

### Scripts to create:
- `tag_audit.ps1` - Find untagged resources
- `cost_report.ps1` - Generate cost summaries
- `rightsizing.ps1` - Identify optimization opportunities

### Features:
- CSV output for analysis
- AWS CLI integration
- Filtering by resource type
- Cost threshold alerts

### Usage:
```powershell
# Audit tags
.\tag_audit.ps1 -OutputPath ".\reports\tag_audit.csv"

# Cost analysis
.\cost_report.ps1 -Days 30 -OutputPath ".\reports\cost_summary.csv"
```

*Script development for Day 10.*

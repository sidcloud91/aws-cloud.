# Day 08 - Observability and Monitoring

## CloudTrail, Config, and Monitoring Stack

Comprehensive observability for AWS environments.

### Components:
- Organization CloudTrail (all regions)
- AWS Config with conformance packs
- CloudWatch dashboards and alarms
- SNS notification topics

### Monitoring Targets:
- ALB 5XX error rates
- Target response times
- Lambda function errors
- Database performance metrics

### Files to implement:
- `cloudtrail.tf` - Audit logging
- `config.tf` - Compliance monitoring
- `cloudwatch.tf` - Metrics and alarms
- `sns.tf` - Notification routing

*Observability stack for Day 08.*

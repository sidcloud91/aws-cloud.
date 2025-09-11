# Day 06 - Serverless Infrastructure

## Lambda and DynamoDB Terraform

Infrastructure for event-driven serverless architecture.

### Resources:
- Lambda function with S3 trigger
- DynamoDB table (on-demand billing)
- IAM roles and policies
- CloudWatch log groups

### Event Flow:
S3 → Lambda → DynamoDB → CloudWatch Logs

### Files to create:
- `lambda.tf` - Function and trigger configuration
- `dynamodb.tf` - Table and indexes
- `iam.tf` - Execution roles
- `cloudwatch.tf` - Logging and monitoring

*Terraform implementation for Day 06.*

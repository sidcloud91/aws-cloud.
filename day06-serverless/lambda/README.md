# Day 06 - Serverless & Event-Driven Architecture

## Lambda Functions and Event Processing

Event-driven serverless architecture with DynamoDB integration.

### Components:
- Lambda function (Python)
- DynamoDB table with TTL
- S3 event triggers
- IAM execution roles

### Lambda Code:
Place Python Lambda code in this directory:
- `handler.py` - Main Lambda function
- `requirements.txt` - Dependencies
- `deployment.zip` - Packaged function

### Use Case:
S3 object upload → Lambda processing → DynamoDB metadata storage

### Files to implement:
- Terraform in `../terraform/`
- Lambda code in this directory

*Ready for Day 06 development.*

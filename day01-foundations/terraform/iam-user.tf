# Terraform Configuration for IAM User Creation
# This file creates an IAM user with comprehensive permissions for the AWS learning project

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "AWS-Learning-14-Day"
      Environment = "learning"
      ManagedBy   = "Terraform"
      Owner       = var.owner_email
    }
  }
}

# Variables
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "user_name" {
  description = "Name for the IAM user"
  type        = string
  default     = "aws-learning-user"
}

variable "owner_email" {
  description = "Email of the user/owner for tagging"
  type        = string
}

variable "create_console_access" {
  description = "Whether to create console access for the user"
  type        = bool
  default     = true
}

variable "require_password_reset" {
  description = "Require password reset on first login"
  type        = bool
  default     = true
}

# IAM Policy Document
data "aws_iam_policy_document" "aws_learning_policy" {
  # VPC and Networking
  statement {
    sid    = "VPCNetworkingFullAccess"
    effect = "Allow"
    actions = [
      "ec2:*Vpc*",
      "ec2:*Subnet*",
      "ec2:*RouteTable*",
      "ec2:*InternetGateway*",
      "ec2:*NatGateway*",
      "ec2:*SecurityGroup*",
      "ec2:*NetworkAcl*",
      "ec2:*VpcEndpoint*",
      "ec2:*Address*",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeRegions",
      "ec2:DescribeAccountAttributes",
      "ec2:CreateTags",
      "ec2:DeleteTags",
      "ec2:DescribeTags"
    ]
    resources = ["*"]
  }

  # EC2 Compute
  statement {
    sid    = "EC2ComputeAccess"
    effect = "Allow"
    actions = [
      "ec2:*Instance*",
      "ec2:*LaunchTemplate*",
      "ec2:*Image*",
      "ec2:*KeyPair*",
      "ec2:*Volume*",
      "ec2:*Snapshot*",
      "ec2:RunInstances",
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:RebootInstances",
      "ec2:TerminateInstances",
      "ec2:ModifyInstanceAttribute",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeInstanceAttribute",
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:DescribeParameters"
    ]
    resources = ["*"]
  }

  # Auto Scaling
  statement {
    sid    = "AutoScalingAccess"
    effect = "Allow"
    actions = [
      "autoscaling:*",
      "application-autoscaling:*"
    ]
    resources = ["*"]
  }

  # Load Balancer
  statement {
    sid       = "LoadBalancerAccess"
    effect    = "Allow"
    actions   = ["elasticloadbalancing:*"]
    resources = ["*"]
  }

  # EKS
  statement {
    sid    = "EKSFullAccess"
    effect = "Allow"
    actions = [
      "eks:*",
      "iam:CreateServiceLinkedRole",
      "iam:PassRole"
    ]
    resources = ["*"]
  }

  # S3
  statement {
    sid       = "S3FullAccess"
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["*"]
  }

  # RDS
  statement {
    sid    = "RDSFullAccess"
    effect = "Allow"
    actions = [
      "rds:*",
      "rds-db:connect"
    ]
    resources = ["*"]
  }

  # DynamoDB
  statement {
    sid       = "DynamoDBFullAccess"
    effect    = "Allow"
    actions   = ["dynamodb:*"]
    resources = ["*"]
  }

  # ElastiCache
  statement {
    sid       = "ElastiCacheAccess"
    effect    = "Allow"
    actions   = ["elasticache:*"]
    resources = ["*"]
  }

  # Lambda and Events
  statement {
    sid    = "LambdaFullAccess"
    effect = "Allow"
    actions = [
      "lambda:*",
      "events:*",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = ["*"]
  }

  # IAM (with restrictions)
  statement {
    sid       = "IAMFullAccessWithRestrictions"
    effect    = "Allow"
    actions   = ["iam:*"]
    resources = ["*"]
    condition {
      test     = "StringNotEquals"
      variable = "iam:PassedToService"
      values   = ["organizations.amazonaws.com"]
    }
  }

  # KMS
  statement {
    sid       = "KMSFullAccess"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]
  }

  # Secrets Manager
  statement {
    sid       = "SecretsManagerAccess"
    effect    = "Allow"
    actions   = ["secretsmanager:*"]
    resources = ["*"]
  }

  # Security Services
  statement {
    sid    = "SecurityServicesAccess"
    effect = "Allow"
    actions = [
      "guardduty:*",
      "inspector2:*",
      "inspector:*",
      "config:*",
      "cloudtrail:*"
    ]
    resources = ["*"]
  }

  # Monitoring
  statement {
    sid    = "MonitoringAccess"
    effect = "Allow"
    actions = [
      "cloudwatch:*",
      "logs:*",
      "sns:*",
      "events:*"
    ]
    resources = ["*"]
  }

  # Cost Management
  statement {
    sid    = "CostManagementAccess"
    effect = "Allow"
    actions = [
      "budgets:*",
      "ce:*",
      "cur:*",
      "pricing:*"
    ]
    resources = ["*"]
  }

  # Support
  statement {
    sid       = "SupportAccess"
    effect    = "Allow"
    actions   = ["support:*"]
    resources = ["*"]
  }

  # API Gateway and Serverless
  statement {
    sid    = "APIGatewayAccess"
    effect = "Allow"
    actions = [
      "apigateway:*",
      "execute-api:*"
    ]
    resources = ["*"]
  }

  # ECS and Fargate
  statement {
    sid    = "ECSFargateAccess"
    effect = "Allow"
    actions = [
      "ecs:*",
      "ecr:*",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = ["*"]
  }

  # Additional Common Services
  statement {
    sid    = "AdditionalCommonServices"
    effect = "Allow"
    actions = [
      "route53:*",
      "route53resolver:*",
      "kinesis:*",
      "firehose:*"
    ]
    resources = ["*"]
  }

  # Container Services
  statement {
    sid    = "ContainerServicesExtended"
    effect = "Allow"
    actions = [
      "ecs:*",
      "ecr:*",
      "eks:*"
    ]
    resources = ["*"]
  }

  # API Services
  statement {
    sid    = "APIServicesExtended"
    effect = "Allow"
    actions = [
      "apigateway:*",
      "execute-api:*",
      "appsync:*"
    ]
    resources = ["*"]
  }

  # Messaging Services
  statement {
    sid    = "MessagingServices"
    effect = "Allow"
    actions = [
      "sqs:*",
      "sns:*",
      "ses:*",
      "mobiletargeting:*",
      "events:*",
      "mq:*"
    ]
    resources = ["*"]
  }

  # Storage Extensions
  statement {
    sid    = "StorageExtensions"
    effect = "Allow"
    actions = [
      "elasticfilesystem:*",
      "fsx:*",
      "backup:*",
      "storagegateway:*",
      "datasync:*",
      "transfer:*"
    ]
    resources = ["*"]
  }

  # Security Extensions
  statement {
    sid    = "SecurityExtensions"
    effect = "Allow"
    actions = [
      "waf:*",
      "wafv2:*",
      "shield:*",
      "detective:*",
      "macie2:*",
      "securityhub:*",
      "access-analyzer:*",
      "ssm-incidents:*",
      "fms:*"
    ]
    resources = ["*"]
  }

  # Deployment Services
  statement {
    sid    = "DeploymentServices"
    effect = "Allow"
    actions = [
      "codebuild:*",
      "codedeploy:*",
      "codepipeline:*",
      "codecommit:*",
      "codestar:*",
      "codeguru-reviewer:*",
      "codeguru-profiler:*",
      "amplify:*",
      "appconfig:*",
      "cloudformation:*",
      "serverlessrepo:*",
      "ssm:*"
    ]
    resources = ["*"]
  }

  # Terraform State Management
  statement {
    sid    = "TerraformStateManagement"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:GetBucketVersioning",
      "s3:PutBucketVersioning",
      "s3:GetEncryptionConfiguration",
      "s3:PutEncryptionConfiguration",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
      "dynamodb:DescribeTable",
      "dynamodb:CreateTable"
    ]
    resources = [
      "arn:aws:s3:::tfstate-*",
      "arn:aws:s3:::tfstate-*/*",
      "arn:aws:dynamodb:*:*:table/terraform-locks-*"
    ]
  }
}

# Create the IAM policy
resource "aws_iam_policy" "aws_learning_policy" {
  name        = "AWS-Learning-Project-Policy"
  description = "Comprehensive permissions for 14-day AWS learning project"
  policy      = data.aws_iam_policy_document.aws_learning_policy.json

  tags = {
    Description = "Policy for AWS learning project covering VPC, EC2, EKS, RDS, Lambda, S3, and monitoring services"
  }
}

# Create the IAM user
resource "aws_iam_user" "aws_learning_user" {
  name = var.user_name
  path = "/"

  tags = {
    Project     = "AWS-Learning-14-Day"
    Purpose     = "Learning and development"
    Environment = "learning"
  }
}

# Attach the policy to the user
resource "aws_iam_user_policy_attachment" "aws_learning_policy_attachment" {
  user       = aws_iam_user.aws_learning_user.name
  policy_arn = aws_iam_policy.aws_learning_policy.arn
}

# Create console access (optional)
resource "aws_iam_user_login_profile" "aws_learning_user_login" {
  count                   = var.create_console_access ? 1 : 0
  user                    = aws_iam_user.aws_learning_user.name
  password_reset_required = var.require_password_reset

  lifecycle {
    ignore_changes = [password_reset_required]
  }
}

# Create access key
resource "aws_iam_access_key" "aws_learning_user_key" {
  user = aws_iam_user.aws_learning_user.name
}

# Outputs
output "user_name" {
  description = "Name of the created IAM user"
  value       = aws_iam_user.aws_learning_user.name
}

output "user_arn" {
  description = "ARN of the created IAM user"
  value       = aws_iam_user.aws_learning_user.arn
}

output "policy_arn" {
  description = "ARN of the created IAM policy"
  value       = aws_iam_policy.aws_learning_policy.arn
}

output "access_key_id" {
  description = "Access key ID for the IAM user"
  value       = aws_iam_access_key.aws_learning_user_key.id
}

output "secret_access_key" {
  description = "Secret access key for the IAM user"
  value       = aws_iam_access_key.aws_learning_user_key.secret
  sensitive   = true
}

output "console_login_url" {
  description = "URL for AWS Console login"
  value       = "https://console.aws.amazon.com/"
}

# Instructions for usage
output "setup_instructions" {
  description = "Instructions for configuring AWS CLI"
  value       = <<-EOT

    To configure AWS CLI with the new user credentials:

    1. Run: aws configure --profile aws-learning
    2. Access Key ID: ${aws_iam_access_key.aws_learning_user_key.id}
    3. Secret Access Key: ${aws_iam_access_key.aws_learning_user_key.secret}
    4. Default region: ${var.aws_region}
    5. Default output format: json

    Test the configuration:
    aws sts get-caller-identity --profile aws-learning

    Export for current session:
    export AWS_PROFILE=aws-learning

  EOT
}

# Development Environment Outputs

# S3 Storage Module Outputs
output "storage_bucket_id" {
  description = "The ID of the S3 storage bucket"
  value       = module.storage.bucket_id
}

output "storage_bucket_arn" {
  description = "The ARN of the S3 storage bucket"
  value       = module.storage.bucket_arn
}

output "storage_bucket_name" {
  description = "The name of the S3 storage bucket"
  value       = module.storage.bucket_name
}

output "storage_bucket_domain_name" {
  description = "The bucket domain name"
  value       = module.storage.bucket_domain_name
}

# Future module outputs can be added here
# Example:
# output "vpc_id" {
#   description = "ID of the VPC"
#   value       = module.networking.vpc_id
# }

# S3 Module Variables

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "bucket_purpose" {
  description = "Purpose of the bucket (e.g., data, logs, artifacts)"
  type        = string
  default     = "storage"
}

variable "force_destroy" {
  description = "Allow deletion of bucket even if it contains objects"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags for the bucket"
  type        = map(string)
  default     = {}
}

variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}

variable "enable_encryption" {
  description = "Enable server-side encryption for the S3 bucket"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS key ID for server-side encryption (if null, uses AES256)"
  type        = string
  default     = null
}

variable "block_public_access" {
  description = "Block all public access to the bucket"
  type        = bool
  default     = true
}

variable "lifecycle_enabled" {
  description = "Enable lifecycle configuration for the bucket"
  type        = bool
  default     = false
}

variable "lifecycle_prefix" {
  description = "Prefix for lifecycle rule"
  type        = string
  default     = ""
}

variable "expiration_days" {
  description = "Number of days after which objects expire (0 to disable)"
  type        = number
  default     = 0
}

variable "noncurrent_version_expiration_days" {
  description = "Number of days after which noncurrent versions expire (0 to disable)"
  type        = number
  default     = 0
}

variable "abort_incomplete_multipart_upload_days" {
  description = "Number of days after which incomplete multipart uploads are aborted (0 to disable)"
  type        = number
  default     = 7
}

variable "bucket_policy" {
  description = "JSON policy document for the bucket (optional)"
  type        = string
  default     = null
}

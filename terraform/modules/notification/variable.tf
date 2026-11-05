# ============================================================
# Common
# ============================================================

variable "prefix" {
  description = "Prefix used for naming AWS resources created by this module. Use a consistent and recognizable prefix to identify notifier-related resources."
  type        = string
}

# ============================================================
# AWS Lambda
# ============================================================

variable "package_dir" {
  description = "Path to Lambda deployment package directory"
  type        = string
}


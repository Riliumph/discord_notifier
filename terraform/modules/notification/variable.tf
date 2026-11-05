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

# ============================================================
# AWS CloudWatch Logs
# ============================================================

variable "log_retention_period" {
  description = "Number of days to retain Lambda logs in CloudWatch Logs. Logs older than this period are automatically deleted. Set according to operational and compliance requirements."
  type        = number
}

# ============================================================
# AWS EventBridge Scheduler
# ============================================================

variable "schedule_timezone" {
  description = "Time zone used to evaluate the schedule expression. Specify an IANA time zone name, such as Asia/Tokyo or UTC. This is particularly important for cron-based schedules."
  type        = string
  default     = "Asia/Tokyo"
}

variable "schedule_expression" {
  description = "Schedule expression that defines when the notification Lambda function is invoked. Supports EventBridge Scheduler expressions such as cron(), rate(), and at()."
  type        = string
}

## COMMON

variable "project_name" {
  type    = string
  default = "discord-notifier"

}

variable "owner_name" {
  type    = string
  default = "FLAFURI"
}

variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "region-short" {
  type    = string
  default = "apne-1"
}

# ============================================================
# AWS CloudWatch Logs
# ============================================================

variable "log_retention_period" {
  type    = number
  default = 7
}

# ============================================================
# AWS EventBridge Scheduler
# ============================================================

variable "schedule_expression" {
  type    = string
  default = "cron(0 0 * * ? *)"
}

locals {
  scheduler_name = "${var.prefix}-scheduler"
}

# ============================================================
# AWS IAM
# ============================================================

# EventBridge Scheduler が Assume する IAM Role
resource "aws_iam_role" "scheduler" {
  name = "${local.scheduler_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "scheduler.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Lambda Invoke 権限
resource "aws_iam_role_policy" "scheduler" {
  name = "${local.scheduler_name}-policy"
  role = aws_iam_role.scheduler.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "lambda:InvokeFunction"
      ]
      Resource = [
        aws_lambda_function.notifier.arn,
        "${aws_lambda_function.notifier.arn}:*"
      ]
    }]
  })
}

# ============================================================
# EventBridge Scheduler
# ============================================================

# Schedule
resource "aws_scheduler_schedule" "daily" {
  name = "${local.scheduler_name}-daily"

  group_name = aws_scheduler_schedule_group.owner_group.name

  schedule_expression          = var.schedule_expression
  schedule_expression_timezone = var.schedule_timezone

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = aws_lambda_function.notifier.arn
    role_arn = aws_iam_role.scheduler.arn

    retry_policy {
      maximum_event_age_in_seconds = 3600
      maximum_retry_attempts       = 3
    }

    input = jsonencode({
      source = "eventbridge-scheduler"
    })
  }
}

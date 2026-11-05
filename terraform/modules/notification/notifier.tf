locals {
  notifier_name = "${var.prefix}-notifier"
}

# ============================================================
# AWS IAM
# ============================================================

resource "aws_iam_role" "notifier" {
  name = "${local.notifier_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Lambda execution policy
resource "aws_iam_role_policy" "notifier" {
  name = "${local.notifier_name}-policy"
  role = aws_iam_role.notifier.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter"
        ]
        Resource = [
          aws_ssm_parameter.message_store.arn,
          aws_ssm_parameter.sending_store.arn,
        ]
      },
    ]
  })
}

# ============================================================
# AWS Lambda
# ============================================================

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = var.package_dir
  output_path = "${path.module}/notifier.zip"
}

# Lambda function
resource "aws_lambda_function" "notifier" {
  function_name = local.notifier_name
  description   = "Send notification message retrieved from SSM Parameter Store"

  role = aws_iam_role.notifier.arn

  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256

  handler = "notifier.lambda_handler"
  runtime = "python3.14"

  timeout     = 30
  memory_size = 128

  environment {
    variables = {
      MESSAGE_STORE_NAME = aws_ssm_parameter.message_store.name
      SENDING_STORE_NAME = aws_ssm_parameter.sending_store.name
    }
  }
}

# ============================================================
# AWS CloudWatch Logs
# ============================================================

resource "aws_cloudwatch_log_group" "lambda" {
  name = "/aws/lambda/${local.notifier_name}"

  retention_in_days = var.log_retention_period
}

resource "aws_iam_role_policy_attachment" "basic" {
  role       = aws_iam_role.notifier.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# ============================================================
# Parameter Store
# ============================================================

resource "aws_ssm_parameter" "sending_store" {
  name  = "/${var.prefix}/sending/webhook-url"
  type  = "String"
  value = "dummy"

  lifecycle {
    # 手動変更を期待するためvalueの変更はchange判定しない。
    ignore_changes = [value]
  }
}

# ============================================================
# EventBridge Scheduler
# ============================================================

# Schedule Group
resource "aws_scheduler_schedule_group" "owner_group" {
  name = var.owner_name
}

locals {
  prefix = "${var.project_name}-${var.region-short}"
}

module "notification" {
  source     = "./modules/notification"
  prefix     = local.prefix
  owner_name = var.owner_name

  # python
  package_dir = "${path.root}/../src"

  # log
  log_retention_period = var.log_retention_period

  # event bridge
  schedule_expression = var.schedule_expression
}

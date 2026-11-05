locals {
  prefix = "${var.project_name}-${var.region-short}"
}

module "notification" {
  source = "./modules/notification"
  prefix = local.prefix

  # python
  package_dir = "${path.root}/../src"

  # log
  log_retention_period = var.log_retention_period
}

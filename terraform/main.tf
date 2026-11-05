locals {
  prefix = "${var.project_name}-${var.region-short}"
}

module "notification" {
  source = "./modules/notification"
  prefix = local.prefix
}

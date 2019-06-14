data "aws_caller_identity" "default" {}

module "default_label" {
  source    = "git::https://github.com/pricemethod/terraform-terraform-label.git?ref=master"
  name      = "${var.name}"
  namespace = "${var.namespace}"
  stack     = "${var.stack}"
}

locals {
  enabled = "${var.enabled == "true" ? 1 : 0}"
}

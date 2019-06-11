data "aws_caller_identity" "default" {}

module "default_label" {
  source    = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.1.3"
  name      = "${var.name}"
  namespace = "${var.namespace}"
  stack     = "${var.stack}"
}

locals {
  enabled = "${var.enabled == "true" ? 1 : 0}"
}

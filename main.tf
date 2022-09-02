data "aws_caller_identity" "default" {
}

module "default_label" {
  source    = "cloudposse/label/null"
  version   = "v0.25.0"
  name      = var.name
  namespace = var.namespace
  stage     = var.stage
}

locals {
  enabled = var.enabled == "true" ? 1 : 0
}


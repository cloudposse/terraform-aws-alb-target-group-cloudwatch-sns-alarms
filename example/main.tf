provider "aws" {
  region = "us-west-2"
}

module "alb_alarms" {
  source                  = "../"
  name                    = "${var.name}"
  namespace               = "${var.namespace}"
  stage                   = "${var.stage}"
  alb_name                = "sv-staging-app-alb"
  alb_arn_suffix          = "XXXXXXXXXXXXXXX"
  target_group_name       = "sv-staging-app-tg"
  target_group_arn_suffix = "YYYYYYYYYYYYYYY"
}

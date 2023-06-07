provider "aws" {
  region = var.region
}

module "vpc" {
  source                  = "cloudposse/vpc/aws"
  version                 = "2.1.0"
  ipv4_primary_cidr_block = var.vpc_cidr_block
  context                 = module.this.context
}

module "subnets" {
  source               = "cloudposse/dynamic-subnets/aws"
  version              = "2.3.0"
  availability_zones   = var.availability_zones
  vpc_id               = module.vpc.vpc_id
  igw_id               = [module.vpc.igw_id]
  ipv4_cidr_block      = [module.vpc.vpc_cidr_block]
  nat_gateway_enabled  = false
  nat_instance_enabled = false
  context              = module.this.context
}

module "alb" {
  source                                  = "cloudposse/alb/aws"
  version                                 = "0.27.0"
  vpc_id                                  = module.vpc.vpc_id
  security_group_ids                      = [module.vpc.vpc_default_security_group_id]
  subnet_ids                              = module.subnets.public_subnet_ids
  target_group_name                       = module.alb_ingress.target_group_name
  access_logs_enabled                     = false
  alb_access_logs_s3_bucket_force_destroy = true

  context = module.this.context
}

module "alb_ingress" {
  source                              = "cloudposse/alb-ingress/aws"
  version                             = "0.16.1"
  vpc_id                              = module.vpc.vpc_id
  default_target_group_enabled        = true
  unauthenticated_listener_arns       = [module.alb.http_listener_arn]
  unauthenticated_listener_arns_count = 1

  context = module.this.context
}

resource "aws_sns_topic" "sns_topic" {
  #bridgecrew:skip=BC_AWS_GENERAL_15:Skipping `Encrypt SNS Topic Data` in example/test modules
  name         = module.this.id
  display_name = "Test terraform-aws-alb-target-group-cloudwatch-sns-alarms"
  tags         = module.this.tags
}

module "alb_target_group_cloudwatch_sns_alarms" {
  source                  = "../../"
  alb_arn_suffix          = module.alb.alb_arn_suffix
  target_group_arn_suffix = module.alb_ingress.target_group_arn_suffix

  evaluation_periods             = var.evaluation_periods
  period                         = var.period
  target_3xx_count_threshold     = var.target_3xx_count_threshold
  target_4xx_count_threshold     = var.target_4xx_count_threshold
  target_5xx_count_threshold     = var.target_5xx_count_threshold
  elb_5xx_count_threshold        = var.elb_5xx_count_threshold
  target_response_time_threshold = var.target_response_time_threshold

  notify_arns               = [aws_sns_topic.sns_topic.arn]
  alarm_actions             = [aws_sns_topic.sns_topic.arn]
  ok_actions                = [aws_sns_topic.sns_topic.arn]
  insufficient_data_actions = [aws_sns_topic.sns_topic.arn]

  context = module.this.context
}

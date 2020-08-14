provider "aws" {
  region = var.region
}

module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.17.0"
  namespace  = var.namespace
  name       = var.name
  stage      = var.stage
  delimiter  = var.delimiter
  attributes = var.attributes
  tags       = var.tags
}

module "vpc" {
  source     = "git::https://github.com/cloudposse/terraform-aws-vpc.git?ref=tags/0.8.1"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  delimiter  = var.delimiter
  attributes = var.attributes
  cidr_block = var.vpc_cidr_block
  tags       = var.tags
}

module "subnets" {
  source               = "git::https://github.com/cloudposse/terraform-aws-dynamic-subnets.git?ref=tags/0.16.1"
  availability_zones   = var.availability_zones
  namespace            = var.namespace
  stage                = var.stage
  name                 = var.name
  attributes           = var.attributes
  delimiter            = var.delimiter
  vpc_id               = module.vpc.vpc_id
  igw_id               = module.vpc.igw_id
  cidr_block           = module.vpc.vpc_cidr_block
  nat_gateway_enabled  = false
  nat_instance_enabled = false
  tags                 = var.tags
}

module "alb" {
  source                                  = "git::https://github.com/cloudposse/terraform-aws-alb.git?ref=tags/0.7.0"
  namespace                               = var.namespace
  stage                                   = var.stage
  name                                    = var.name
  attributes                              = var.attributes
  delimiter                               = var.delimiter
  vpc_id                                  = module.vpc.vpc_id
  security_group_ids                      = [module.vpc.vpc_default_security_group_id]
  subnet_ids                              = module.subnets.public_subnet_ids
  target_group_name                       = module.alb_ingress.target_group_name
  access_logs_enabled                     = false
  alb_access_logs_s3_bucket_force_destroy = true
  tags                                    = var.tags
}

module "alb_ingress" {
  source                              = "git::https://github.com/cloudposse/terraform-aws-alb-ingress.git?ref=tags/0.9.0"
  namespace                           = var.namespace
  stage                               = var.stage
  name                                = var.name
  attributes                          = var.attributes
  delimiter                           = var.delimiter
  vpc_id                              = module.vpc.vpc_id
  default_target_group_enabled        = true
  unauthenticated_listener_arns       = [module.alb.http_listener_arn]
  unauthenticated_listener_arns_count = 1
  tags                                = var.tags
}

resource "aws_sns_topic" "sns_topic" {
  name         = module.label.id
  display_name = "Test terraform-aws-alb-target-group-cloudwatch-sns-alarms"
  tags         = module.label.tags
}

module "alb_target_group_cloudwatch_sns_alarms" {
  source     = "../../"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  attributes = var.attributes
  delimiter  = var.delimiter
  tags       = var.tags

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
}

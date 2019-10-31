output "public_subnet_cidrs" {
  value       = module.subnets.public_subnet_cidrs
  description = "Public subnet CIDRs"
}

output "private_subnet_cidrs" {
  value       = module.subnets.private_subnet_cidrs
  description = "Private subnet CIDRs"
}

output "vpc_cidr" {
  value       = module.vpc.vpc_cidr_block
  description = "VPC ID"
}

output "alb_name" {
  description = "The ARN suffix of the ALB"
  value       = module.alb.alb_name
}

output "alb_arn" {
  description = "The ARN of the ALB"
  value       = module.alb.alb_arn
}

output "alb_arn_suffix" {
  description = "The ARN suffix of the ALB"
  value       = module.alb.alb_arn_suffix
}

output "alb_dns_name" {
  description = "DNS name of ALB"
  value       = module.alb.alb_dns_name
}

output "alb_zone_id" {
  description = "The ID of the zone which ALB is provisioned"
  value       = module.alb.alb_zone_id
}

output "target_group_name" {
  description = "ALB Target Group name"
  value       = module.alb_ingress.target_group_name
}

output "target_group_arn" {
  description = "ALB Target Group ARN"
  value       = module.alb_ingress.target_group_arn
}

output "target_group_arn_suffix" {
  description = "ALB Target Group ARN suffix"
  value       = module.alb_ingress.target_group_arn_suffix
}

output "httpcode_target_3xx_count_cloudwatch_metric_alarm_id" {
  value       = module.alb_target_group_cloudwatch_sns_alarms.httpcode_target_3xx_count_cloudwatch_metric_alarm_id
  description = "Target Group 3xx count CloudWatch metric alarm ID"
}

output "httpcode_target_3xx_count_cloudwatch_metric_alarm_arn" {
  value       = module.alb_target_group_cloudwatch_sns_alarms.httpcode_target_3xx_count_cloudwatch_metric_alarm_arn
  description = "Target Group 3xx count CloudWatch metric alarm ARN"
}

output "httpcode_target_4xx_count_cloudwatch_metric_alarm_id" {
  value       = module.alb_target_group_cloudwatch_sns_alarms.httpcode_target_4xx_count_cloudwatch_metric_alarm_id
  description = "Target Group 4xx count CloudWatch metric alarm ID"
}

output "httpcode_target_4xx_count_cloudwatch_metric_alarm_arn" {
  value       = module.alb_target_group_cloudwatch_sns_alarms.httpcode_target_4xx_count_cloudwatch_metric_alarm_arn
  description = "Target Group 4xx count CloudWatch metric alarm ARN"
}

output "httpcode_target_5xx_count_cloudwatch_metric_alarm_id" {
  value       = module.alb_target_group_cloudwatch_sns_alarms.httpcode_target_5xx_count_cloudwatch_metric_alarm_id
  description = "Target Group 5xx count CloudWatch metric alarm ID"
}

output "httpcode_target_5xx_count_cloudwatch_metric_alarm_arn" {
  value       = module.alb_target_group_cloudwatch_sns_alarms.httpcode_target_5xx_count_cloudwatch_metric_alarm_arn
  description = "Target Group 5xx count CloudWatch metric alarm ARN"
}

output "httpcode_elb_5xx_count_cloudwatch_metric_alarm_id" {
  value       = module.alb_target_group_cloudwatch_sns_alarms.httpcode_elb_5xx_count_cloudwatch_metric_alarm_id
  description = "ELB 5xx count CloudWatch metric alarm ID"
}

output "httpcode_elb_5xx_count_cloudwatch_metric_alarm_arn" {
  value       = module.alb_target_group_cloudwatch_sns_alarms.httpcode_elb_5xx_count_cloudwatch_metric_alarm_arn
  description = "ELB 5xx count CloudWatch metric alarm ARN"
}

output "target_response_time_average_cloudwatch_metric_alarm_id" {
  value       = module.alb_target_group_cloudwatch_sns_alarms.target_response_time_average_cloudwatch_metric_alarm_id
  description = "Target Group response time average CloudWatch metric alarm ID"
}

output "target_response_time_average_cloudwatch_metric_alarm_arn" {
  value       = module.alb_target_group_cloudwatch_sns_alarms.target_response_time_average_cloudwatch_metric_alarm_arn
  description = "Target Group response time average CloudWatch metric alarm ARN"
}

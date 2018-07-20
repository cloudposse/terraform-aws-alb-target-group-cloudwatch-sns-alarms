locals {
  thresholds = {
    target_3xx_count     = "${max(var.target_3xx_count_threshold, 0)}"
    target_4xx_count     = "${max(var.target_4xx_count_threshold, 0)}"
    target_5xx_count     = "${max(var.target_5xx_count_threshold, 0)}"
    target_response_time = "${max(var.target_response_time_threshold, 0)}"
  }

  target_3xx_alarm_enabled           = "${floor(var.target_3xx_count_threshold) < 0     ? 0 : 1 * local.enabled}"
  target_4xx_alarm_enabled           = "${floor(var.target_4xx_count_threshold) < 0     ? 0 : 1 * local.enabled}"
  target_5xx_alarm_enabled           = "${floor(var.target_5xx_count_threshold) < 0     ? 0 : 1 * local.enabled}"
  target_response_time_alarm_enabled = "${floor(var.target_response_time_threshold) < 0 ? 0 : 1 * local.enabled}"

  dimensions_map = {
    "TargetGroup"  = "${join("/", list("targetgroup", var.target_group_name, var.target_group_arn_suffix))}"
    "LoadBalancer" = "${join("/", list("app", var.alb_name, var.alb_arn_suffix))}"
  }
}

module "httpcode_alarm_label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.1.3"
  name       = "${var.name}"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  attributes = "${compact(concat(var.attributes, list("%v", "count", "high")))}"
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_3xx_count" {
  count               = "${local.target_3xx_alarm_enabled}"
  alarm_name          = "${format(module.httpcode_alarm_label.id, "3XX")}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "HTTPCode_Target_3XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "${var.period}"
  statistic           = "Sum"
  threshold           = "${local.thresholds["target_3xx_count"]}"
  alarm_description   = "${format(var.httpcode_alarm_description, "3XX", module.default_label.id, local.thresholds["target_3xx_count"], var.period/60, var.evaluation_periods)}"
  alarm_actions       = ["${var.notify_arns}"]
  ok_actions          = ["${var.notify_arns}"]

  dimensions = "${local.dimensions_map}"
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_4xx_count" {
  count               = "${local.target_4xx_alarm_enabled}"
  alarm_name          = "${format(module.httpcode_alarm_label.id, "4XX")}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "HTTPCode_Target_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "${var.period}"
  statistic           = "Sum"
  threshold           = "${local.thresholds["target_4xx_count"]}"
  alarm_description   = "${format(var.httpcode_alarm_description, "4XX", module.default_label.id, local.thresholds["target_4xx_count"], var.period/60, var.evaluation_periods)}"
  alarm_actions       = ["${var.notify_arns}"]
  ok_actions          = ["${var.notify_arns}"]

  dimensions = "${local.dimensions_map}"
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_5xx_count" {
  count               = "${local.target_5xx_alarm_enabled}"
  alarm_name          = "${format(module.httpcode_alarm_label.id, "5XX")}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "${var.period}"
  statistic           = "Sum"
  threshold           = "${local.thresholds["target_5xx_count"]}"
  alarm_description   = "${format(var.httpcode_alarm_description, "5XX", module.default_label.id, local.thresholds["target_5xx_count"], var.period/60, var.evaluation_periods)}"
  alarm_actions       = ["${var.notify_arns}"]
  ok_actions          = ["${var.notify_arns}"]

  dimensions = "${local.dimensions_map}"
}

module "target_response_time_alarm_label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.1.3"
  name       = "${var.name}"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  attributes = "${compact(concat(var.attributes, list("target", "response", "high")))}"
}

resource "aws_cloudwatch_metric_alarm" "target_response_time_average" {
  count               = "${local.target_response_time_alarm_enabled}"
  alarm_name          = "${format(module.target_response_time_alarm_label.id)}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = "${var.period}"
  statistic           = "Average"
  threshold           = "${local.thresholds["target_response_time"]}"
  alarm_description   = "${format(var.target_response_time_alarm_description, module.default_label.id, local.thresholds["target_response_time"], var.period/60, var.evaluation_periods)}"
  alarm_actions       = ["${var.notify_arns}"]
  ok_actions          = ["${var.notify_arns}"]

  dimensions = "${local.dimensions_map}"
}

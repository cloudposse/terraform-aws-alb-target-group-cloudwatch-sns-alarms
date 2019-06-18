locals {
  # default to using notify_arns unless a more specific action is specified.
  alarm_actions                  = "${coalescelist(var.alarm_actions,var.notify_arns)}"
  alarm_warn_actions             = "${coalescelist(var.alarm_warn_actions,var.notify_warn_arns)}"
  ok_actions                     = "${coalescelist(var.ok_actions,var.notify_arns)}"
  ok_warn_actions                = "${coalescelist(var.ok_warn_actions,var.notify_warn_arns)}"
  insufficient_data_actions      = "${coalescelist(var.insufficient_data_actions,var.notify_arns)}"
  insufficient_data_warn_actions = "${coalescelist(var.insufficient_data_warn_actions,var.notify_warn_arns)}"

  thresholds = {
    elb_5xx_count                  = "${max(var.elb_5xx_count_threshold, 0)}"
    elb_5xx_count_warn             = "${max(var.elb_5xx_count_warn_threshold, 0)}"
    target_4xx_count               = "${max(var.target_4xx_count_threshold, 0)}"
    target_4xx_count_warn          = "${max(var.target_4xx_count_warn_threshold, 0)}"
    target_4xx_rate                = "${max(var.target_4xx_rate_threshold, 0)}"
    target_4xx_rate_warn           = "${max(var.target_4xx_rate_warn_threshold, 0)}"
    target_5xx_count               = "${max(var.target_5xx_count_threshold, 0)}"
    target_5xx_count_warn          = "${max(var.target_5xx_count_warn_threshold, 0)}"
    target_5xx_rate                = "${max(var.target_5xx_rate_threshold, 0)}"
    target_5xx_rate_warn           = "${max(var.target_5xx_rate_warn_threshold, 0)}"
    target_healthy_host_count      = "${max(var.target_healthy_host_count_threshold, 0)}"
    target_healthy_host_count_warn = "${max(var.target_healthy_host_count_warn_threshold, 0)}"
    target_response_time           = "${max(var.target_response_time_threshold, 0)}"
    target_response_time_warn      = "${max(var.target_response_time_warn_threshold, 0)}"
  }

  elb_5xx_alarm_enabled                   = "${floor(var.elb_5xx_count_threshold)                  <= 0     ? 0 : 1 * local.enabled}"
  target_4xx_alarm_enabled                = "${floor(var.target_4xx_count_threshold)               <= 0     ? 0 : 1 * local.enabled}"
  target_4xx_warn_alarm_enabled           = "${floor(var.target_4xx_count_warn_threshold)          <= 0     ? 0 : 1 * local.enabled}"
  target_4xx_rate_alarm_enabled           = "${floor(var.target_4xx_rate_threshold)                <= 0     ? 0 : 1 * local.enabled}"
  target_4xx_rate_warn_alarm_enabled      = "${floor(var.target_4xx_rate_warn_threshold)           <= 0     ? 0 : 1 * local.enabled}"
  target_5xx_alarm_enabled                = "${floor(var.target_5xx_count_threshold)               <= 0     ? 0 : 1 * local.enabled}"
  target_5xx_warn_alarm_enabled           = "${floor(var.target_5xx_count_warn_threshold)          <= 0     ? 0 : 1 * local.enabled}"
  target_5xx_rate_alarm_enabled           = "${floor(var.target_5xx_rate_threshold)                <= 0     ? 0 : 1 * local.enabled}"
  target_5xx_rate_warn_alarm_enabled      = "${floor(var.target_5xx_rate_warn_threshold)           <= 0     ? 0 : 1 * local.enabled}"
  target_healthy_host_alarm_enabled       = "${floor(var.target_healthy_host_count_threshold)      <= 0     ? 0 : 1 * local.enabled}"
  target_healthy_host_warn_alarm_enabled  = "${floor(var.target_healthy_host_count_warn_threshold) <= 0     ? 0 : 1 * local.enabled}"
  target_response_time_alarm_enabled      = "${floor(var.target_response_time_threshold)           <= 0     ? 0 : 1 * local.enabled}"

  target_group_dimensions_map = {
    "TargetGroup"  = "${var.target_group_arn_suffix}"
    "LoadBalancer" = "${var.alb_arn_suffix}"
  }

  load_balancer_dimensions_map = {
    "LoadBalancer" = "${var.alb_arn_suffix}"
  }
}

module "httpcode_alarm_label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.1.3"
  name       = "${var.name}"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  attributes = "${compact(concat(var.attributes, list("%v", "count", "high")))}"
}

module "httpcode_rate_alarm_label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.1.3"
  name       = "${var.name}"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  attributes = "${compact(concat(var.attributes, list("%v", "rate", "high")))}"
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_4xx_count" {
  count                     = "${local.target_4xx_alarm_enabled}"
  alarm_name                = "${format(module.httpcode_alarm_label.id, "4XX")}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "${var.evaluation_periods}"
  metric_name               = "HTTPCode_Target_4XX_Count"
  namespace                 = "AWS/ApplicationELB"
  period                    = "${var.period}"
  statistic                 = "Sum"
  threshold                 = "${local.thresholds["target_4xx_count"]}"
  treat_missing_data        = "${var.treat_missing_data}"
  alarm_description         = "${format(var.httpcode_alarm_description, "4XX", module.default_label.id, local.thresholds["target_4xx_count"], var.period/60, var.evaluation_periods)}"
  alarm_actions             = ["${local.alarm_actions}"]
  ok_actions                = ["${local.ok_actions}"]
  insufficient_data_actions = ["${local.insufficient_data_actions}"]

  dimensions = "${local.target_group_dimensions_map}"
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_4xx_count_warn" {
  count                     = "${local.target_4xx_warn_alarm_enabled}"
  alarm_name                = "${format(module.httpcode_alarm_label.id, "4XX warn")}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "${var.evaluation_periods}"
  metric_name               = "HTTPCode_Target_4XX_Count"
  namespace                 = "AWS/ApplicationELB"
  period                    = "${var.period}"
  statistic                 = "Sum"
  threshold                 = "${local.thresholds["target_4xx_count_warn"]}"
  treat_missing_data        = "${var.treat_missing_data}"
  alarm_description         = "${format(var.httpcode_alarm_description, "4XX", module.default_label.id, local.thresholds["target_4xx_count_warn"], var.period/60, var.evaluation_periods)}"
  alarm_actions             = ["${local.alarm_warn_actions}"]
  ok_actions                = ["${local.ok_warn_actions}"]
  insufficient_data_actions = ["${local.insufficient_data_warn_actions}"]

  dimensions = "${local.target_group_dimensions_map}"
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_4xx_rate" {
  count                     = "${local.target_4xx_rate_alarm_enabled}"
  alarm_name                = "${format(module.httpcode_rate_alarm_label.id, "4XX")}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "${var.evaluation_periods}"
  threshold                 = "${local.thresholds["target_4xx_rate"]}"
  treat_missing_data        = "${var.treat_missing_data}"
  alarm_description         = "${format(var.httpcode_rate_alarm_description, "4XX", module.default_label.id, local.thresholds["target_4xx_rate"], var.period/60, var.evaluation_periods)}"
  alarm_actions             = ["${local.alarm_actions}"]
  ok_actions                = ["${local.ok_actions}"]
  insufficient_data_actions = ["${local.insufficient_data_actions}"]

  metric_query {
    id          = "e1"
    expression  = "m2/m1*100"
    label       = "Error Rate"
    return_data = "true"
  }

  metric_query {
    id = "m1"

    metric {
      metric_name = "RequestCount"
      namespace   = "AWS/ApplicationELB"
      period      = "${var.period}"
      stat        = "Sum"
      unit        = "Count"

      dimensions = "${local.target_group_dimensions_map}"
    }
  }

  metric_query {
    id = "m2"

    metric {
      metric_name = "HTTPCode_Target_4XX_Count"
      namespace   = "AWS/ApplicationELB"
      period      = "${var.period}"
      stat        = "Sum"
      unit        = "Count"

      dimensions = "${local.target_group_dimensions_map}"
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_4xx_rate_warn" {
  count                     = "${local.target_4xx_rate_warn_alarm_enabled}"
  alarm_name                = "${format(module.httpcode_rate_alarm_label.id, "4XX warn")}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "${var.evaluation_periods}"
  threshold                 = "${local.thresholds["target_4xx_rate_warn"]}"
  treat_missing_data        = "${var.treat_missing_data}"
  alarm_description         = "${format(var.httpcode_rate_alarm_description, "4XX", module.default_label.id, local.thresholds["target_4xx_rate_warn"], var.period/60, var.evaluation_periods)}"
  alarm_actions             = ["${local.alarm_warn_actions}"]
  ok_actions                = ["${local.ok_warn_actions}"]
  insufficient_data_actions = ["${local.insufficient_data_warn_actions}"]

  metric_query {
    id          = "e1"
    expression  = "m2/m1*100"
    label       = "Error Rate"
    return_data = "true"
  }

  metric_query {
    id = "m1"

    metric {
      metric_name = "RequestCount"
      namespace   = "AWS/ApplicationELB"
      period      = "${var.period}"
      stat        = "Sum"
      unit        = "Count"

      dimensions = "${local.target_group_dimensions_map}"
    }
  }

  metric_query {
    id = "m2"

    metric {
      metric_name = "HTTPCode_Target_4XX_Count"
      namespace   = "AWS/ApplicationELB"
      period      = "${var.period}"
      stat        = "Sum"
      unit        = "Count"

      dimensions = "${local.target_group_dimensions_map}"
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_5xx_count" {
  count                     = "${local.target_5xx_alarm_enabled}"
  alarm_name                = "${format(module.httpcode_alarm_label.id, "5XX")}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "${var.evaluation_periods}"
  metric_name               = "HTTPCode_Target_5XX_Count"
  namespace                 = "AWS/ApplicationELB"
  period                    = "${var.period}"
  statistic                 = "Sum"
  threshold                 = "${local.thresholds["target_5xx_count"]}"
  treat_missing_data        = "${var.treat_missing_data}"
  alarm_description         = "${format(var.httpcode_alarm_description, "5XX", module.default_label.id, local.thresholds["target_5xx_count"], var.period/60, var.evaluation_periods)}"
  alarm_actions             = ["${local.alarm_actions}"]
  ok_actions                = ["${local.ok_actions}"]
  insufficient_data_actions = ["${local.insufficient_data_actions}"]

  dimensions = "${local.target_group_dimensions_map}"
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_5xx_count_warn" {
  count                     = "${local.target_5xx_warn_alarm_enabled}"
  alarm_name                = "${format(module.httpcode_alarm_label.id, "5XX warn")}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "${var.evaluation_periods}"
  metric_name               = "HTTPCode_Target_5XX_Count"
  namespace                 = "AWS/ApplicationELB"
  period                    = "${var.period}"
  statistic                 = "Sum"
  threshold                 = "${local.thresholds["target_5xx_count_warn"]}"
  treat_missing_data        = "${var.treat_missing_data}"
  alarm_description         = "${format(var.httpcode_alarm_description, "5XX", module.default_label.id, local.thresholds["target_5xx_count_warn"], var.period/60, var.evaluation_periods)}"
  alarm_actions             = ["${local.alarm_warn_actions}"]
  ok_actions                = ["${local.ok_warn_actions}"]
  insufficient_data_actions = ["${local.insufficient_data_warn_actions}"]

  dimensions = "${local.target_group_dimensions_map}"
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_5xx_rate" {
  count                     = "${local.target_5xx_rate_alarm_enabled}"
  alarm_name                = "${format(module.httpcode_rate_alarm_label.id, "5XX")}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "${var.evaluation_periods}"
  threshold                 = "${local.thresholds["target_5xx_rate"]}"
  treat_missing_data        = "${var.treat_missing_data}"
  alarm_description         = "${format(var.httpcode_rate_alarm_description, "5XX", module.default_label.id, local.thresholds["target_5xx_rate"], var.period/60, var.evaluation_periods)}"
  alarm_actions             = ["${local.alarm_actions}"]
  ok_actions                = ["${local.ok_actions}"]
  insufficient_data_actions = ["${local.insufficient_data_actions}"]

  metric_query {
    id          = "e1"
    expression  = "m2/m1*100"
    label       = "Error Rate"
    return_data = "true"
  }

  metric_query {
    id = "m1"

    metric {
      metric_name = "RequestCount"
      namespace   = "AWS/ApplicationELB"
      period      = "${var.period}"
      stat        = "Sum"
      unit        = "Count"

      dimensions = "${local.target_group_dimensions_map}"
    }
  }

  metric_query {
    id = "m2"

    metric {
      metric_name = "HTTPCode_Target_5XX_Count"
      namespace   = "AWS/ApplicationELB"
      period      = "${var.period}"
      stat        = "Sum"
      unit        = "Count"

      dimensions = "${local.target_group_dimensions_map}"
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_5xx_rate_warn" {
  count                     = "${local.target_5xx_rate_warn_alarm_enabled}"
  alarm_name                = "${format(module.httpcode_rate_alarm_label.id, "5XX warn")}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "${var.evaluation_periods}"
  threshold                 = "${local.thresholds["target_5xx_rate_warn"]}"
  treat_missing_data        = "${var.treat_missing_data}"
  alarm_description         = "${format(var.httpcode_rate_alarm_description, "5XX", module.default_label.id, local.thresholds["target_5xx_rate_warn"], var.period/60, var.evaluation_periods)}"
  alarm_actions             = ["${local.alarm_warn_actions}"]
  ok_actions                = ["${local.ok_warn_actions}"]
  insufficient_data_actions = ["${local.insufficient_data_warn_actions}"]

  metric_query {
    id          = "e1"
    expression  = "m2/m1*100"
    label       = "Error Rate"
    return_data = "true"
  }

  metric_query {
    id = "m1"

    metric {
      metric_name = "RequestCount"
      namespace   = "AWS/ApplicationELB"
      period      = "${var.period}"
      stat        = "Sum"
      unit        = "Count"

      dimensions = "${local.target_group_dimensions_map}"
    }
  }

  metric_query {
    id = "m2"

    metric {
      metric_name = "HTTPCode_Target_5XX_Count"
      namespace   = "AWS/ApplicationELB"
      period      = "${var.period}"
      stat        = "Sum"
      unit        = "Count"

      dimensions = "${local.target_group_dimensions_map}"
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "healthy_host_target_count" {
  count                     = "${local.target_healthy_host_alarm_enabled}"
  alarm_name                = "${format(module.httpcode_alarm_label.id, "HealthyHost")}"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "${var.evaluation_periods}"
  metric_name               = "HealthyHostCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = "${var.period}"
  statistic                 = "Minimum"
  threshold                 = "${local.thresholds["target_healthy_host_count"]}"
  treat_missing_data        = "${var.treat_missing_data}"
  alarm_description         = "${format(var.target_healthy_host_alarm_description, module.default_label.id, local.thresholds["target_healthy_host_count"], var.period/60)}"
  alarm_actions             = ["${local.alarm_actions}"]
  ok_actions                = ["${local.ok_actions}"]
  insufficient_data_actions = ["${local.insufficient_data_actions}"]

  dimensions = "${local.target_group_dimensions_map}"
}

resource "aws_cloudwatch_metric_alarm" "healthy_host_target_count_warn" {
  count                     = "${local.target_healthy_host_warn_alarm_enabled}"
  alarm_name                = "${format(module.httpcode_alarm_label.id, "HealthyHost warn")}"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "${var.evaluation_periods}"
  metric_name               = "HealthyHostCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = "${var.period}"
  statistic                 = "Minimum"
  threshold                 = "${local.thresholds["target_healthy_host_count_warn"]}"
  treat_missing_data        = "${var.treat_missing_data}"
  alarm_description         = "${format(var.target_healthy_host_alarm_description, module.default_label.id, local.thresholds["target_healthy_host_count_warn"], var.period/60)}"
  alarm_actions             = ["${local.alarm_warn_actions}"]
  ok_actions                = ["${local.ok_warn_actions}"]
  insufficient_data_actions = ["${local.insufficient_data_warn_actions}"]

  dimensions = "${local.target_group_dimensions_map}"
}

resource "aws_cloudwatch_metric_alarm" "httpcode_elb_5xx_count" {
  count                     = "${local.elb_5xx_alarm_enabled}"
  alarm_name                = "${format(module.httpcode_alarm_label.id, "ELB-5XX")}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "${var.evaluation_periods}"
  metric_name               = "HTTPCode_ELB_5XX_Count"
  namespace                 = "AWS/ApplicationELB"
  period                    = "${var.period}"
  statistic                 = "Sum"
  threshold                 = "${local.thresholds["elb_5xx_count"]}"
  treat_missing_data        = "${var.treat_missing_data}"
  alarm_description         = "${format(var.httpcode_alarm_description, "ELB-5XX", module.default_label.id, local.thresholds["elb_5xx_count"], var.period/60, var.evaluation_periods)}"
  alarm_actions             = ["${local.alarm_actions}"]
  ok_actions                = ["${local.ok_actions}"]
  insufficient_data_actions = ["${local.insufficient_data_actions}"]

  dimensions = "${local.load_balancer_dimensions_map}"
}

module "target_response_time_alarm_label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.1.3"
  name       = "${var.name}"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  attributes = "${compact(concat(var.attributes, list("target", "response", "high")))}"
}

resource "aws_cloudwatch_metric_alarm" "target_response_time_average" {
  count                     = "${local.target_response_time_alarm_enabled}"
  alarm_name                = "${format(module.target_response_time_alarm_label.id)}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "${var.evaluation_periods}"
  metric_name               = "TargetResponseTime"
  namespace                 = "AWS/ApplicationELB"
  period                    = "${var.period}"
  statistic                 = "Average"
  threshold                 = "${local.thresholds["target_response_time"]}"
  treat_missing_data        = "${var.treat_missing_data}"
  alarm_description         = "${format(var.target_response_time_alarm_description, module.default_label.id, local.thresholds["target_response_time"], var.period/60, var.evaluation_periods)}"
  alarm_actions             = ["${local.alarm_actions}"]
  ok_actions                = ["${local.ok_actions}"]
  insufficient_data_actions = ["${local.insufficient_data_actions}"]

  dimensions = "${local.target_group_dimensions_map}"
}

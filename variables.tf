variable "name" {
  type        = "string"
  description = "Name (unique identifier for app or service)"
}

variable "namespace" {
  type        = "string"
  description = "Namespace (e.g. `lyr` or `lyric`)"
  default     = "lyric"
}

variable "delimiter" {
  type        = "string"
  description = "The delimiter to be used in labels."
  default     = "-"
}

variable "stack" {
  type        = "string"
  description = "Stack (e.g. `prod-us-east-1`, `dev-us-west-2`)"
}

variable "attributes" {
  type        = "list"
  description = "List of attributes to add to label."
  default     = []
}

variable "tags" {
  type        = "map"
  description = "Map of key-value pairs to use for tags."
  default     = {}
}

variable "enabled" {
  type        = "string"
  description = "Whether to create all resources."
  default     = "true"
}

variable "notify_arns" {
  type        = "list"
  description = "A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into ANY state from any other state. May be overridden by the value of a more specific {alarm,ok,insufficient_data}_actions variable. "
  default     = []
}

variable "notify_warn_arns" {
  type        = "list"
  description = "A list of ARNs (i.e. SNS Topic ARN) to execute when this WARNING alarm transitions into ANY state from any other state. May be overridden by the value of a more specific {alarm,ok,insufficient_data}_warn_actions variable. "
  default     = []
}

variable "alarm_actions" {
  type        = "list"
  description = "A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an ALARM state from any other state.  If set, this list takes precedence over notify_arns."
  default     = []
}

variable "alarm_warn_actions" {
  type        = "list"
  description = "A list of ARNs (i.e. SNS Topic ARN) to execute when this WARNING alarm transitions into an ALARM state from any other state.  If set, this list takes precedence over notify_warn_arns."
  default     = []
}

variable "ok_actions" {
  type        = "list"
  description = "A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an OK state from any other state. If set, this list takes precedence over notify_arns."
  default     = []
}

variable "ok_warn_actions" {
  type        = "list"
  description = "A list of ARNs (i.e. SNS Topic ARN) to execute when this WARNING alarm transitions into an OK state from any other state. If set, this list takes precedence over notify_warn_arns."
  default     = []
}

variable "insufficient_data_actions" {
  type        = "list"
  description = "A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state. If set, this list takes precedence over notify_arns."
  default     = []
}

variable "insufficient_data_warn_actions" {
  type        = "list"
  description = "A list of ARNs (i.e. SNS Topic ARN) to execute when this WARNING alarm transitions into an INSUFFICIENT_DATA state from any other state. If set, this list takes precedence over notify_warn_arns."
  default     = []
}

variable "alb_name" {
  type        = "string"
  description = "The name of ALB to monitor."
}

variable "alb_arn_suffix" {
  type        = "string"
  description = "The ARN suffix of ALB."
}

variable "target_group_name" {
  type        = "string"
  description = "The name of the ALB Target Group to monitor."
}

variable "target_group_arn_suffix" {
  type        = "string"
  description = "The ARN suffix of ALB Target Group."
}

variable "evaluation_periods" {
  type        = "string"
  description = "Number of periods to evaluate for the alarm."
  default     = "2"
}

variable "period" {
  type        = "string"
  description = "Duration in seconds to evaluate for the alarm."
  default     = "60"
}

variable "target_4xx_count_threshold" {
  type        = "string"
  description = "The maximum count of 4XX requests over a period. A value `<=0` will disable the alert."
  default     = "10"
}

variable "target_4xx_warn_count_threshold" {
  type        = "string"
  description = "The maximum count of 4XX requests over a period. A value `<=0` will disable the alert."
  default     = "0"
}

variable "target_5xx_count_threshold" {
  type        = "string"
  description = "The maximum count of 5XX requests over a period. A value `<=0` will disable the alert."
  default     = "10"
}

variable "target_5xx_warn_count_threshold" {
  type        = "string"
  description = "The maximum count of 5XX requests over a period. A value `<=0` will disable the alert."
  default     = "0"
}

variable "elb_5xx_count_threshold" {
  type        = "string"
  description = "The maximum count of ELB 5XX requests over a period. A value `<=0` will disable the alert."
  default     = "10"
}

variable "elb_5xx_warn_count_threshold" {
  type        = "string"
  description = "The maximum count of ELB 5XX requests over a period. A value `<=0` will disable the alert."
  default     = "0"
}

variable "httpcode_alarm_description" {
  type        = "string"
  description = "The string to format and use as the httpcode alarm description."
  default     = "HTTPCode %v count for %v over %v last %d minute(s) over %v period(s)"
}

variable "target_healthy_host_count_threshold" {
  type        = "string"
  description = "A value below which an alert will trigger for healthy hosts in a target group. A value `<=0` will disable the alert."
  default     = "1"
}

variable "target_healthy_host_warn_count_threshold" {
  type        = "string"
  description = "A value below which a WARNING alert will trigger for healthy hosts in a target group. A value `<=0` will disable the alert."
  default     = "0"
}

variable "target_healthy_host_alarm_description" {
  type        = "string"
  description = "The string to format and use as the healthy host alarm description."
  default     = "Healthy hosts count for %v below %v for last %d minute(s)"
}

variable "target_response_time_threshold" {
  type        = "string"
  description = "The maximum average target response time (in seconds) over a period. A value `<=0` will disable the alert."
  default     = "0"
}

variable "target_response_time_warn_threshold" {
  type        = "string"
  description = "The maximum average target response time (in seconds) over a period. A value `<=0` will disable the alert."
  default     = "0"
}

variable "target_response_time_alarm_description" {
  type        = "string"
  description = "The string to format and use as the target response time alarm description."
  default     = "Target Response Time average for %v over %v last %d minute(s) over %v period(s)"
}

variable "treat_missing_data" {
  type        = "string"
  description = "Sets how alarms handle missing data points. Values supported: missing, ignore, breaching and notBreaching."
  default     = "missing"
}

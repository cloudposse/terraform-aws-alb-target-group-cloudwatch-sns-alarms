variable "namespace" {
  type        = string
  description = "Namespace (e.g. `eg` or `cp`)"
  default     = ""
}

variable "stage" {
  type        = string
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  default     = ""
}

variable "name" {
  type        = string
  description = "Name of the application"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  description = "Additional attributes (_e.g._ \"1\")"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Additional tags (_e.g._ { BusinessUnit : ABC })"
  default     = {}
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Enable/disable resources creation"
}

variable "notify_arns" {
  type        = list(string)
  description = "A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into ANY state from any other state. May be overridden by the value of a more specific {alarm,ok,insufficient_data}_actions variable. "
  default     = []
}

variable "alarm_actions" {
  type        = list(string)
  description = "A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an ALARM state from any other state.  If set, this list takes precedence over notify_arns"
  default     = []
}

variable "ok_actions" {
  type        = list(string)
  description = "A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an OK state from any other state. If set, this list takes precedence over notify_arns"
  default     = []
}

variable "insufficient_data_actions" {
  type        = list(string)
  description = "A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state. If set, this list takes precedence over notify_arns"
  default     = []
}

variable "alb_arn_suffix" {
  type        = string
  description = "The ARN suffix of ALB"
}

variable "target_group_arn_suffix" {
  type        = string
  description = "The ARN suffix of ALB Target Group"
}

variable "evaluation_periods" {
  type        = number
  description = "Number of periods to evaluate for the alarm"
  default     = 1
}

variable "period" {
  type        = number
  description = "Duration in seconds to evaluate for the alarm"
  default     = 300
}

variable "target_3xx_count_threshold" {
  type        = number
  description = "The maximum count of 3XX requests over a period. A negative value will disable the alert"
  default     = 25
}

variable "target_4xx_count_threshold" {
  type        = number
  description = "The maximum count of 4XX requests over a period. A negative value will disable the alert"
  default     = 25
}

variable "target_5xx_count_threshold" {
  type        = number
  description = "The maximum count of 5XX requests over a period. A negative value will disable the alert"
  default     = 25
}

variable "elb_5xx_count_threshold" {
  type        = number
  description = "The maximum count of ELB 5XX requests over a period. A negative value will disable the alert"
  default     = 25
}

variable "httpcode_alarm_description" {
  type        = string
  description = "The string to format and use as the httpcode alarm description"
  default     = "HTTPCode %v count for %v over %v last %d minute(s) over %v period(s)"
}

variable "target_response_time_threshold" {
  type        = number
  description = "The maximum average target response time (in seconds) over a period. A negative value will disable the alert"
  default     = 0.5
}

variable "target_response_time_alarm_description" {
  type        = string
  description = "The string to format and use as the target response time alarm description"
  default     = "Target Response Time average for %v over %v last %d minute(s) over %v period(s)"
}

variable "treat_missing_data" {
  type        = string
  description = "Sets how alarms handle missing data points. Values supported: missing, ignore, breaching and notBreaching"
  default     = "missing"
}

variable "name" {
  type        = "string"
  description = "Name (unique identifier for app or service)"
}

variable "namespace" {
  type        = "string"
  description = "Namespace (e.g. `cp` or `cloudposse`)"
}

variable "delimiter" {
  type        = "string"
  description = "The delimiter to be used in labels."
  default     = "-"
}

variable "stage" {
  type        = "string"
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
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
  description = "Whether to create all resources"
  default     = "true"
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
  default     = ""
}

variable "target_group_arn_suffix" {
  type        = "string"
  description = "The ARN suffix of ALB Target Group."
  default     = ""
}

variable "evaluation_periods" {
  type        = "string"
  description = "Number of periods to evaluate for the alarm."
  default     = "1"
}

variable "period" {
  type        = "string"
  description = "Duration in seconds to evaluate for the alarm."
  default     = "300"
}

variable "target_3xx_count_threshold" {
  type        = "string"
  description = "The maximum count of 3XX requests over a period."
  default     = "25"
}

variable "target_4xx_count_threshold" {
  type        = "string"
  description = "The maximum count of 4XX requests over a period."
  default     = "25"
}

variable "target_5xx_count_threshold" {
  type        = "string"
  description = "The maximum count of 5XX requests over a period."
  default     = "25"
}

variable "httpcode_alarm_description" {
  type        = "string"
  description = "The string to format and use as the httpcode alarm description."
  default     = "HTTPCode %v count for %v over %v last %d minute(s) over %v period(s)"
}

variable "target_response_time_threshold" {
  type        = "string"
  description = "The maximum average target response time (in seconds) over a period."
  default     = "0.5"
}

variable "target_response_time_alarm_description" {
  type        = "string"
  description = "The string to format and use as the target response time alarm description."
  default     = "Target Response Time average for %v over %v last %d minute(s) over %v period(s)"
}

variable "region" {
  type        = string
  description = "AWS Region for S3 bucket"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "namespace" {
  type        = string
  description = "Namespace (e.g. `eg` or `cp`)"
}

variable "evaluation_periods" {
  type        = number
  description = "Number of periods to evaluate for the alarm"
}

variable "period" {
  type        = number
  description = "Duration in seconds to evaluate for the alarm"
}

variable "target_3xx_count_threshold" {
  type        = number
  description = "The maximum count of 3XX requests over a period. A negative value will disable the alert"
}

variable "target_4xx_count_threshold" {
  type        = number
  description = "The maximum count of 4XX requests over a period. A negative value will disable the alert"
}

variable "target_5xx_count_threshold" {
  type        = number
  description = "The maximum count of 5XX requests over a period. A negative value will disable the alert"
}

variable "elb_5xx_count_threshold" {
  type        = number
  description = "The maximum count of ELB 5XX requests over a period. A negative value will disable the alert"
}

variable "target_response_time_threshold" {
  type        = number
  description = "The maximum average target response time (in seconds) over a period. A negative value will disable the alert"
}


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alarm_actions | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an ALARM state from any other state.  If set, this list takes precedence over notify_arns. | list | `<list>` | no |
| alb_arn_suffix | The ARN suffix of ALB. | string | - | yes |
| alb_name | The name of ALB to monitor. | string | - | yes |
| attributes | List of attributes to add to label. | list | `<list>` | no |
| delimiter | The delimiter to be used in labels. | string | `-` | no |
| enabled | Whether to create all resources. | string | `true` | no |
| evaluation_periods | Number of periods to evaluate for the alarm. | string | `1` | no |
| httpcode_alarm_description | The string to format and use as the httpcode alarm description. | string | `HTTPCode %v count for %v over %v last %d minute(s) over %v period(s)` | no |
| insufficient_data_actions | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state. If set, this list takes precedence over notify_arns. | list | `<list>` | no |
| name | Name (unique identifier for app or service) | string | - | yes |
| namespace | Namespace (e.g. `cp` or `cloudposse`) | string | - | yes |
| notify_arns | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into ANY state from any other state. May be overridden by the value of a more specific {alarm,ok,insufficient_data}_actions variable. | list | `<list>` | no |
| ok_actions | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an OK state from any other state. If set, this list takes precedence over notify_arns. | list | `<list>` | no |
| period | Duration in seconds to evaluate for the alarm. | string | `300` | no |
| stack | Stack (e.g. `prod-us-east-1`, `dev-us-west-2`) | string | - | yes |
| tags | Map of key-value pairs to use for tags. | map | `<map>` | no |
| target_3xx_count_threshold | The maximum count of 3XX requests over a period. A negative value will disable the alert. | string | `25` | no |
| target_4xx_count_threshold | The maximum count of 4XX requests over a period. A negative value will disable the alert. | string | `25` | no |
| target_5xx_count_threshold | The maximum count of 5XX requests over a period. A negative value will disable the alert. | string | `25` | no |
| elb_5xx_count_threshold | The maximum count of ELB 5XX requests over a period. A negative value will disable the alert. | string | `25` | no |
| target_group_arn_suffix | The ARN suffix of ALB Target Group. | string | - | yes |
| target_group_name | The name of the ALB Target Group to monitor. | string | - | yes |
| target_response_time_alarm_description | The string to format and use as the target response time alarm description. | string | `Target Response Time average for %v over %v last %d minute(s) over %v period(s)` | no |
| target_response_time_threshold | The maximum average target response time (in seconds) over a period. A negative value will disable the alert. | string | `0.5` | no |
| treat_missing_data | Sets how alarms handle missing data points. Values supported: missing, ignore, breaching and notBreaching. | string | `missing` | no |

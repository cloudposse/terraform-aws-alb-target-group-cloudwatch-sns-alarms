
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| additional_notify_arns | Optional list of additional ARNs to notify on alarm and ok actions. | list | `<list>` | no |
| alb_arn_suffix | The ARN suffix of ALB. | string | - | yes |
| alb_name | The name of ALB to monitor. | string | - | yes |
| attributes | List of attributes to add to label. | list | `<list>` | no |
| create_sns_topic | Determines if a new sns topic will be generated. If set to false, the existing sns_topic_name variable must be set. | string | `true` | no |
| delimiter | The delimiter to be used in labels. | string | `-` | no |
| enabled | Whether to create all resources. | string | `true` | no |
| evaluation_periods | Number of periods to evaluate for the alarm. | string | `1` | no |
| httpcode_alarm_description | The string to format and use as the httpcode alarm description. | string | `HTTPCode %v count for %v over %v last %d minute(s) over %v period(s)` | no |
| name | Name (unique identifier for app or service) | string | - | yes |
| namespace | Namespace (e.g. `cp` or `cloudposse`) | string | - | yes |
| period | Duration in seconds to evaluate for the alarm. | string | `300` | no |
| sns_topic_name | Name of existing SNS topic to use for alarm and ok actions, instead of generating a new one. | string | `` | no |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | - | yes |
| tags | Map of key-value pairs to use for tags. | map | `<map>` | no |
| target_3xx_count_threshold | The maximum count of 3XX requests over a period. | string | `25` | no |
| target_4xx_count_threshold | The maximum count of 4XX requests over a period. | string | `25` | no |
| target_5xx_count_threshold | The maximum count of 5XX requests over a period. | string | `25` | no |
| target_group_arn_suffix | The ARN suffix of ALB Target Group. | string | - | yes |
| target_group_name | The name of the ALB Target Group to monitor. | string | - | yes |
| target_response_time_alarm_description | The string to format and use as the target response time alarm description. | string | `Target Response Time average for %v over %v last %d minute(s) over %v period(s)` | no |
| target_response_time_threshold | The maximum average target response time (in seconds) over a period. | string | `0.5` | no |

## Outputs

| Name | Description |
|------|-------------|
| sns_topic_arn | The ARN of the SNS topic |
| sns_topic_name | The name of the SNS topic |


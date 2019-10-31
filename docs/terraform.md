## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alarm_actions | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an ALARM state from any other state.  If set, this list takes precedence over notify_arns | list(string) | `<list>` | no |
| alb_arn_suffix | The ARN suffix of ALB | string | - | yes |
| attributes | Additional attributes (_e.g._ "1") | list(string) | `<list>` | no |
| delimiter | Delimiter between `namespace`, `stage`, `name` and `attributes` | string | `-` | no |
| elb_5xx_count_threshold | The maximum count of ELB 5XX requests over a period. A negative value will disable the alert | number | `25` | no |
| enabled | Enable/disable resources creation | bool | `true` | no |
| evaluation_periods | Number of periods to evaluate for the alarm | number | `1` | no |
| httpcode_alarm_description | The string to format and use as the httpcode alarm description | string | `HTTPCode %v count for %v over %v last %d minute(s) over %v period(s)` | no |
| insufficient_data_actions | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state. If set, this list takes precedence over notify_arns | list(string) | `<list>` | no |
| name | Name of the application | string | - | yes |
| namespace | Namespace (e.g. `eg` or `cp`) | string | `` | no |
| notify_arns | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into ANY state from any other state. May be overridden by the value of a more specific {alarm,ok,insufficient_data}_actions variable. | list(string) | `<list>` | no |
| ok_actions | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an OK state from any other state. If set, this list takes precedence over notify_arns | list(string) | `<list>` | no |
| period | Duration in seconds to evaluate for the alarm | number | `300` | no |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | `` | no |
| tags | Additional tags (_e.g._ { BusinessUnit : ABC }) | map(string) | `<map>` | no |
| target_3xx_count_threshold | The maximum count of 3XX requests over a period. A negative value will disable the alert | number | `25` | no |
| target_4xx_count_threshold | The maximum count of 4XX requests over a period. A negative value will disable the alert | number | `25` | no |
| target_5xx_count_threshold | The maximum count of 5XX requests over a period. A negative value will disable the alert | number | `25` | no |
| target_group_arn_suffix | The ARN suffix of ALB Target Group | string | - | yes |
| target_response_time_alarm_description | The string to format and use as the target response time alarm description | string | `Target Response Time average for %v over %v last %d minute(s) over %v period(s)` | no |
| target_response_time_threshold | The maximum average target response time (in seconds) over a period. A negative value will disable the alert | number | `0.5` | no |
| treat_missing_data | Sets how alarms handle missing data points. Values supported: missing, ignore, breaching and notBreaching | string | `missing` | no |

## Outputs

| Name | Description |
|------|-------------|
| httpcode_elb_5xx_count_cloudwatch_metric_alarm_arn | ELB 5xx count CloudWatch metric alarm ARN |
| httpcode_elb_5xx_count_cloudwatch_metric_alarm_id | ELB 5xx count CloudWatch metric alarm ID |
| httpcode_target_3xx_count_cloudwatch_metric_alarm_arn | Target 3xx count CloudWatch metric alarm ARN |
| httpcode_target_3xx_count_cloudwatch_metric_alarm_id | Target 3xx count CloudWatch metric alarm ID |
| httpcode_target_4xx_count_cloudwatch_metric_alarm_arn | Target 4xx count CloudWatch metric alarm ARN |
| httpcode_target_4xx_count_cloudwatch_metric_alarm_id | Target 4xx count CloudWatch metric alarm ID |
| httpcode_target_5xx_count_cloudwatch_metric_alarm_arn | Target 5xx count CloudWatch metric alarm ARN |
| httpcode_target_5xx_count_cloudwatch_metric_alarm_id | Target 5xx count CloudWatch metric alarm ID |
| target_response_time_average_cloudwatch_metric_alarm_arn | Response time average CloudWatch metric alarm ARN |
| target_response_time_average_cloudwatch_metric_alarm_id | Response time average CloudWatch metric alarm ID |


<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0, < 0.14.0 |
| aws | ~> 2.0 |
| local | ~> 1.2 |
| null | ~> 2.0 |
| template | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alarm\_actions | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an ALARM state from any other state.  If set, this list takes precedence over notify\_arns | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| alb\_arn\_suffix | The ARN suffix of ALB | `string` | n/a | yes |
| attributes | Additional attributes (\_e.g.\_ "1") | `list(string)` | `[]` | no |
| delimiter | Delimiter between `namespace`, `stage`, `name` and `attributes` | `string` | `"-"` | no |
| elb\_5xx\_count\_threshold | The maximum count of ELB 5XX requests over a period. A negative value will disable the alert | `number` | `25` | no |
| enabled | Enable/disable resources creation | `bool` | `true` | no |
| evaluation\_periods | Number of periods to evaluate for the alarm | `number` | `1` | no |
| httpcode\_alarm\_description | The string to format and use as the httpcode alarm description | `string` | `"HTTPCode %v count for %v over %v last %d minute(s) over %v period(s)"` | no |
| insufficient\_data\_actions | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an INSUFFICIENT\_DATA state from any other state. If set, this list takes precedence over notify\_arns | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| name | Name of the application | `string` | n/a | yes |
| namespace | Namespace (e.g. `eg` or `cp`) | `string` | `""` | no |
| notify\_arns | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into ANY state from any other state. May be overridden by the value of a more specific {alarm,ok,insufficient\_data}\_actions variable. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| ok\_actions | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an OK state from any other state. If set, this list takes precedence over notify\_arns | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| period | Duration in seconds to evaluate for the alarm | `number` | `300` | no |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | `string` | `""` | no |
| tags | Additional tags (\_e.g.\_ { BusinessUnit : ABC }) | `map(string)` | `{}` | no |
| target\_3xx\_count\_threshold | The maximum count of 3XX requests over a period. A negative value will disable the alert | `number` | `25` | no |
| target\_4xx\_count\_threshold | The maximum count of 4XX requests over a period. A negative value will disable the alert | `number` | `25` | no |
| target\_5xx\_count\_threshold | The maximum count of 5XX requests over a period. A negative value will disable the alert | `number` | `25` | no |
| target\_group\_arn\_suffix | The ARN suffix of ALB Target Group | `string` | n/a | yes |
| target\_response\_time\_alarm\_description | The string to format and use as the target response time alarm description | `string` | `"Target Response Time average for %v over %v last %d minute(s) over %v period(s)"` | no |
| target\_response\_time\_threshold | The maximum average target response time (in seconds) over a period. A negative value will disable the alert | `number` | `0.5` | no |
| treat\_missing\_data | Sets how alarms handle missing data points. Values supported: missing, ignore, breaching and notBreaching | `string` | `"missing"` | no |

## Outputs

| Name | Description |
|------|-------------|
| httpcode\_elb\_5xx\_count\_cloudwatch\_metric\_alarm\_arn | ELB 5xx count CloudWatch metric alarm ARN |
| httpcode\_elb\_5xx\_count\_cloudwatch\_metric\_alarm\_id | ELB 5xx count CloudWatch metric alarm ID |
| httpcode\_target\_3xx\_count\_cloudwatch\_metric\_alarm\_arn | Target Group 3xx count CloudWatch metric alarm ARN |
| httpcode\_target\_3xx\_count\_cloudwatch\_metric\_alarm\_id | Target Group 3xx count CloudWatch metric alarm ID |
| httpcode\_target\_4xx\_count\_cloudwatch\_metric\_alarm\_arn | Target Group 4xx count CloudWatch metric alarm ARN |
| httpcode\_target\_4xx\_count\_cloudwatch\_metric\_alarm\_id | Target Group 4xx count CloudWatch metric alarm ID |
| httpcode\_target\_5xx\_count\_cloudwatch\_metric\_alarm\_arn | Target Group 5xx count CloudWatch metric alarm ARN |
| httpcode\_target\_5xx\_count\_cloudwatch\_metric\_alarm\_id | Target Group 5xx count CloudWatch metric alarm ID |
| target\_response\_time\_average\_cloudwatch\_metric\_alarm\_arn | Target Group response time average CloudWatch metric alarm ARN |
| target\_response\_time\_average\_cloudwatch\_metric\_alarm\_id | Target Group response time average CloudWatch metric alarm ID |

<!-- markdownlint-restore -->

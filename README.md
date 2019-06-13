# terraform-aws-alb-target-group-cloudwatch-sns-alarms

Terraform module for creating alarms for tracking important changes and occurrences from ALBs.

## Usage

**IMPORTANT:** The `master` branch is used in `source` just as an example. In your code, do not pin to `master` because there may be breaking changes between releases.
Instead pin to the release tag (e.g. `?ref=tags/x.y.z`) of one of our [latest releases](https://github.com/pricemethod/terraform-aws-alb-target-group-cloudwatch-sns-alarms/releases).


```hcl
module "alb_alarms" {
  source                  = "git::https://github.com/pricemethod/terraform-aws-alb-target-group-cloudwatch-sns-alarms.git?ref=master"
  name                    = "app"
  namespace               = "lyric"
  stack                   = "prod-us-esat-1"
  alb_name                = "prod-app-alb"
  alb_arn_suffix          = "XXXXXXXXX"
  target_group_name       = "prod-app-tg"
  target_group_arn_suffix = "YYYYYYYYY"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alarm_actions | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an ALARM state from any other state.  If set, this list takes precedence over notify_arns. | list | `<list>` | no |
| alarm_warn_actions | A list of ARNs (i.e. SNS Topic ARN) to execute when this WARNING alarm transitions into an ALARM state from any other state.  If set, this list takes precedence over notify_warn_arns. | list | `<list>` | no |
| alb_arn_suffix | The ARN suffix of ALB. | string | - | yes |
| alb_name | The name of ALB to monitor. | string | - | yes |
| attributes | List of attributes to add to label. | list | `<list>` | no |
| delimiter | The delimiter to be used in labels. | string | `-` | no |
| elb_5xx_count_threshold | The maximum count of ELB 5XX requests over a period. A value `<=0` will disable the alert. | string | `10` | no |
| elb_5xx_warn_count_threshold | The maximum count of ELB 5XX requests over a period. A value `<=0` will disable the alert. | string | `0` | no |
| enabled | Whether to create all resources. | string | `true` | no |
| evaluation_periods | Number of periods to evaluate for the alarm. | string | `2` | no |
| httpcode_alarm_description | The string to format and use as the httpcode alarm description. | string | `HTTPCode %v count for %v over %v last %d minute(s) over %v period(s)` | no |
| insufficient_data_actions | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state. If set, this list takes precedence over notify_arns. | list | `<list>` | no |
| name | Name (unique identifier for app or service) | string | - | yes |
| namespace | Namespace (e.g. `lyr` or `lyric`) | string | `lyric` | yes |
| notify_arns | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into ANY state from any other state. May be overridden by the value of a more specific {alarm,ok,insufficient_data}_actions variable. | list | `<list>` | no |
| notify_warn_arns | A list of ARNs (i.e. SNS Topic ARN) to execute when this WARNING alarm transitions into ANY state from any other state. May be overridden by the value of a more specific {alarm,ok,insufficient_data}_warn_actions variable. | list | `<list>` | no |
| ok_actions | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an OK state from any other state. If set, this list takes precedence over notify_arns. | list | `<list>` | no |
| ok_warn_actions | A list of ARNs (i.e. SNS Topic ARN) to execute when this WARNING alarm transitions into an OK state from any other state. If set, this list takes precedence over notify_warn_arns. | list | `<list>` | no |
| period | Duration in seconds to evaluate for the alarm. | string | `60` | no |
| stack | Stack (e.g. `prod-us-east-1`, `dev-us-west-2`) | string | - | yes |
| tags | Map of key-value pairs to use for tags. | map | `<map>` | no |
| target_4xx_count_threshold | The maximum count of 4XX requests over a period. A value `<=0` will disable the alert. | string | `10` | no |
| target_4xx_warn_count_threshold | The maximum count of 4XX requests over a period. A value `<=0` will disable the alert. | string | `0` | no |
| target_5xx_count_threshold | The maximum count of 5XX requests over a period. A value `<=0` will disable the alert. | string | `10` | no |
| target_5xx_warn_count_threshold | The maximum count of 5XX requests over a period. A value `<=0` will disable the alert. | string | `0` | no |
| target_group_arn_suffix | The ARN suffix of ALB Target Group. | string | - | yes |
| target_group_name | The name of the ALB Target Group to monitor. | string | - | yes |
| target_healthy_host_count_threshold | A value below which an alert will trigger for healthy hosts in a target group. A value `<=0` will disable the alert. | string | `1` | no |
| target_healthy_host_warn_count_threshold | A value below which a WARNING alert will trigger for healthy hosts in a target group. A value `<=0` will disable the alert. | string | `0` | no |
| target_healthy_host_alarm_description | The string to format and use as the healthy host alarm description. | string | `Healthy hosts count for %v below %v for last %d minute(s)` | no |
| target_response_time_alarm_description | The string to format and use as the target response time alarm description. | string | `Target Response Time average for %v over %v last %d minute(s) over %v period(s)` | no |
| target_response_time_threshold | The maximum average target response time (in seconds) over a period. A value `<=0` will disable the alert. | string | `0` | no |
| treat_missing_data | Sets how alarms handle missing data points. Values supported: missing, ignore, breaching and notBreaching. | string | `missing` | no |


## Copyright

Copyright © 2017-2019 [Cloud Posse, LLC](https://cpco.io/copyright)


## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.


## Trademarks

All other trademarks referenced herein are the property of their respective owners.

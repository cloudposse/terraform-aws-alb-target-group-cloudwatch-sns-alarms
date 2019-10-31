region = "us-east-2"

availability_zones = ["us-east-2a", "us-east-2b"]

namespace = "eg"

stage = "test"

name = "alb-tg-cw-alarms"

vpc_cidr_block = "172.16.0.0/16"

evaluation_periods = 1

period = 300

target_3xx_count_threshold = 25

target_4xx_count_threshold = 25

target_5xx_count_threshold = 25

elb_5xx_count_threshold = 25

target_response_time_threshold = 0.5

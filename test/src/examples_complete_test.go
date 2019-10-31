package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/complete",
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.us-east-2.tfvars"},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	vpcCidr := terraform.Output(t, terraformOptions, "vpc_cidr")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "172.16.0.0/16", vpcCidr)

	// Run `terraform output` to get the value of an output variable
	privateSubnetCidrs := terraform.OutputList(t, terraformOptions, "private_subnet_cidrs")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, []string{"172.16.0.0/19", "172.16.32.0/19"}, privateSubnetCidrs)

	// Run `terraform output` to get the value of an output variable
	publicSubnetCidrs := terraform.OutputList(t, terraformOptions, "public_subnet_cidrs")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, []string{"172.16.96.0/19", "172.16.128.0/19"}, publicSubnetCidrs)

	// Run `terraform output` to get the value of an output variable
	albName := terraform.Output(t, terraformOptions, "alb_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "eg-test-alb-tg-cw-alarms", albName)

	// Run `terraform output` to get the value of an output variable
	targetGroupName := terraform.Output(t, terraformOptions, "target_group_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "eg-test-alb-tg-cw-alarms", targetGroupName)

	// Run `terraform output` to get the value of an output variable
	defaultTargetGroupArn := terraform.Output(t, terraformOptions, "target_group_arn")
	// Verify we're getting back the outputs we expect
	assert.Contains(t, defaultTargetGroupArn, "targetgroup/eg-test-alb-tg-cw-alarms")

	// Run `terraform output` to get the value of an output variable
	httpcodeElb5xxCountCloudwatchMetricAlarmId := terraform.Output(t, terraformOptions, "httpcode_elb_5xx_count_cloudwatch_metric_alarm_id")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "eg-test-alb-tg-cw-alarms-elb-5xx-count-high", httpcodeElb5xxCountCloudwatchMetricAlarmId)

	// Run `terraform output` to get the value of an output variable
	httpcodeTarget3xxCountCloudwatchMetricAlarmId := terraform.Output(t, terraformOptions, "httpcode_target_3xx_count_cloudwatch_metric_alarm_id")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "eg-test-alb-tg-cw-alarms-3xx-count-high", httpcodeTarget3xxCountCloudwatchMetricAlarmId)

	// Run `terraform output` to get the value of an output variable
	httpcodeTarget4xxCountCloudwatchMetricAlarmId := terraform.Output(t, terraformOptions, "httpcode_target_4xx_count_cloudwatch_metric_alarm_id")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "eg-test-alb-tg-cw-alarms-4xx-count-high", httpcodeTarget4xxCountCloudwatchMetricAlarmId)

	// Run `terraform output` to get the value of an output variable
	httpcodeTarget5xxCountCloudwatchMetricAlarmId := terraform.Output(t, terraformOptions, "httpcode_target_5xx_count_cloudwatch_metric_alarm_id")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "eg-test-alb-tg-cw-alarms-5xx-count-high", httpcodeTarget5xxCountCloudwatchMetricAlarmId)

	// Run `terraform output` to get the value of an output variable
	targetResponseTimeAverageCloudwatchMetricAlarmId := terraform.Output(t, terraformOptions, "target_response_time_average_cloudwatch_metric_alarm_id")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "eg-test-alb-tg-cw-alarms-target-response-high", targetResponseTimeAverageCloudwatchMetricAlarmId)
}

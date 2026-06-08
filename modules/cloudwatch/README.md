# CloudWatch Module

This module sets up automatic idle shutdown for the server. It monitors CPU usage and stops the instance when it stays idle for too long.

```
CloudWatch Alarm (CPU < 10% for 15 min)
        │
        ▼
SNS Topic (minecraft-idle-shutdown-topic)
        │
        ▼
Lambda Function (minecraft-discord-control)
        │
        ▼
EC2 Instance Stopped
```

## Resources Created

| Resource |  Description |
|----------|-------------|
| `aws_sns_topic` | SNS topic for idle shutdown notifications |
| `aws_sns_topic_subscription` | Subscribes the Lambda function to the SNS topic |
| `aws_lambda_permission` | Grants SNS permission to invoke the Lambda |
| `aws_cloudwatch_metric_alarm` | Alarm that triggers when CPU < 10% for 2 consecutive periods |

## Variables

| Name | Description |
|------|-------------|
| `instance_id` | EC2 instance ID to monitor |   
| `lambda_function_arn` | ARN of the Lambda function to invoke | 
| `lambda_function_name` | Name of the Lambda function to invoke | 

## Outputs

| Name | Description |
|------|-------------|
| `alarm_arn` | ARN of the CloudWatch alarm |
| `alarm_name` | Name of the CloudWatch alarm |


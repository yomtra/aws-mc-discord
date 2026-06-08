# IAM Module

This module sets up IAM roles and policies. It gives the EC2 instance permission to access S3, and gives the Lambda function permission to control the EC2 instance.

## Resources Created

| Resource | Name| Description |
|----------|------|-------|
| `aws_iam_role` | `instance_role` |IAM role assumed by the EC2 instance |
| `aws_iam_role` | `lambda_minecraft_control` |IAM role assumed by the Lambda function |
| `aws_iam_policy` | `s3_access_policy` |Grants S3 read access to the EC2 instance role |
| `aws_iam_policy` | `lambda_ec2_control_policy` |Grants EC2 start/stop/describe to the Lambda role |
| `aws_iam_role_policy_attachment` | `instance_policy_attachment` |Attaches S3 policy to EC2 instance role |
| `aws_iam_role_policy_attachment` | `lambda_policy_attachment` |Attaches EC2 control policy to Lambda role |
| `aws_iam_role_policy_attachment` | `lambda_logs` |Attaches `AWSLambdaBasicExecutionRole` to Lambda role |
| `aws_iam_instance_profile` |`mc_instance_profile`| Instance profile wrapping the EC2 role |

## Input Variables

| Name | Description |
|------|-------------|
| `mc_bucket` | S3 bucket name for the modpack policy |  
| `instance_arn` | EC2 instance ARN (used for resource-level permissions) |

## Outputs

| Name | Description |
|------|-------------|
| `role_arn` | ARN of the EC2 instance IAM role |
| `instance_profile_name` | Name of the EC2 instance profile |
| `instance_profile_arn` | ARN of the EC2 instance profile |
| `lambda_role_arn` | ARN of the Lambda IAM role |



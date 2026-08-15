# Lambda Module

This module creates the Lambda function that powers the Discord bot commands for controlling the EC2 instance. 

## Resources Created

| Resource | Description |
|----------|-------------|
| `archive_file`  | Locally zips the `Bot/` directory for Lambda deployment |
| `aws_lambda_function`  | Lambda function |
| `aws_lambda_function_url` | Public HTTP endpoint for Discord interactions |

## Input Variables

| Name | Description | 
|------|-------------|
| `minecraft_instance_id` | EC2 instance ID of the Minecraft server | 
| `discord_public_key` | Discord application public key | 
| `allowed_role_ids` | List of Discord role IDs allowed to control the server | 
| `lambda_role_arn` | ARN of the Lambda IAM role | 

## Outputs

| Name | Description |
|------|-------------|
| `lambda_function_url` | Public URL for Discord interactions |
| `lambda_function_arn` | ARN of the Lambda function |
| `lambda_function_name` | Name of the Lambda function |


### After deployment:

1. Copy the `lambda_function_url` output and set it as the  **Interactions Endpoint URL** in the Discord Developer Portal.

<img width="1201" height="116" alt="image" src="https://github.com/user-attachments/assets/a9fa0dc7-821f-4586-b4a9-b29c82e09b2a" />


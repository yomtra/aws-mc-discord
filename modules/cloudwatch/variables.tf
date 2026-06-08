variable "instance_id" {
  description = "EC2 instance ID to monitor"
  type        = string
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function to invoke on alarm"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function to invoke on alarm"
  type        = string
}

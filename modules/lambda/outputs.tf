output "lambda_function_url" {
  value       = aws_lambda_function_url.discord_endpoint.function_url
}

output "lambda_function_arn" {
  value       = aws_lambda_function.minecraft_discord_control.arn
}

output "lambda_function_name" {
  value       = aws_lambda_function.minecraft_discord_control.function_name
}
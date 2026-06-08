output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "lambda_url" {
  value = module.lambda.lambda_function_url
}

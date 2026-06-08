output "role_arn" {
	value       = aws_iam_role.instance_role.arn
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.mc_instance_profile.name
}
 
output "instance_profile_arn" {
  value = aws_iam_instance_profile.mc_instance_profile.arn
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_minecraft_control.arn
}
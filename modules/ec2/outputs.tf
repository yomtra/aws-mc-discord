output "instance_id" {
	value       = aws_instance.minecraft.id
}

output "public_ip" {
	value       = aws_eip.minecraft_eip.public_ip
}

output "instance_arn" {
  value = aws_instance.minecraft.arn
}
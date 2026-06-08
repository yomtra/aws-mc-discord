output "alarm_arn" {
  value       = aws_cloudwatch_metric_alarm.minecraft_idle_shutdown.arn
}

output "alarm_name" {
  value       = aws_cloudwatch_metric_alarm.minecraft_idle_shutdown.alarm_name
}

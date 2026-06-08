resource "aws_sns_topic" "minecraft_idle_shutdown" {
  name = "minecraft-idle-shutdown-topic"
}

resource "aws_sns_topic_subscription" "minecraft_idle_lambda" {
  topic_arn = aws_sns_topic.minecraft_idle_shutdown.arn
  protocol  = "lambda"
  endpoint  = var.lambda_function_arn
}

resource "aws_lambda_permission" "allow_sns_invoke" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.minecraft_idle_shutdown.arn
}

resource "aws_cloudwatch_metric_alarm" "minecraft_idle_shutdown" {
  alarm_name          = "minecraft-idle-shutdown"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "10"
  alarm_description   = "Shuts down Minecraft EC2 instance when CPU is below 5% for 10 minutes"
  treat_missing_data  = "notBreaching"

  dimensions = {
    InstanceId = var.instance_id
  }

  alarm_actions = [aws_sns_topic.minecraft_idle_shutdown.arn]

}
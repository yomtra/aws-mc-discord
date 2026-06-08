data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../../Bot"
  output_path = "${path.module}/../../lambda_function.zip"
}

resource "aws_lambda_function" "minecraft_discord_control" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "minecraft-discord-control"
  role          = var.lambda_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
  timeout       = 10

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      INSTANCE_ID = var.minecraft_instance_id
      DISCORD_PUBLIC_KEY = var.discord_public_key
      ALLOWED_ROLE_IDS = var.allowed_role_ids
    }
  }
}

resource "aws_lambda_function_url" "discord_endpoint" {
  function_name      = aws_lambda_function.minecraft_discord_control.function_name
  authorization_type = "NONE"
  cors {
    allow_origins = ["*"]
    allow_methods = ["GET", "POST"]
    allow_headers = ["Content-Type"]
  }
}
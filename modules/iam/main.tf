#allows an instance to assume this role
resource "aws_iam_role" "instance_role" {
  name = "mc-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

#iam role for lambda
resource "aws_iam_role" "lambda_minecraft_control" {
  name = "minecraft-lambda-control-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

#role has permissions to list bucket and download files
resource "aws_iam_policy" "s3_access_policy" {
  name        = "mc-instance-access-policy"
  path        = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject", 
          "s3:ListBucket",
        ]
        Effect   = "Allow"
        Resource = [ 
          "arn:aws:s3:::${var.mc_bucket}" ,
          "arn:aws:s3:::${var.mc_bucket}/*",
          ] 
      },
    ]
  })
}

#lambda has permissions to control ec2 instance
resource "aws_iam_policy" "lambda_ec2_control_policy" {
  name = "lambda-ec2-control-policy"
  path = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:StartInstances",
          "ec2:StopInstances"
        ]
        Resource = var.instance_arn
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances"
        ]
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "instance_policy_attachment" {
  role       = aws_iam_role.instance_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

resource "aws_iam_instance_profile" "mc_instance_profile" {
  name = "mc-instance-profile"
  role = aws_iam_role.instance_role.name
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_minecraft_control.name
  policy_arn = aws_iam_policy.lambda_ec2_control_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_minecraft_control.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}